//
//  ContentView.swift
//  CW Forms
//
//  Created by Justin Williams, Jacob Langdon, Chuda Dhakal
//  University of Louisville Capstone Project Fall 2022
//
//  Continued by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import SwiftUI
import CloudKit

struct ContentView: View {
    // MARK: Variables
    
    @StateObject private var vm: CourtWatchViewModel
    @StateObject private var jvm: JudgeListViewModel
    
    init(vm: CourtWatchViewModel, jvm: JudgeListViewModel) {
        _vm = StateObject(wrappedValue: vm)
        _jvm = StateObject(wrappedValue: jvm)
    }
    
    
    @State private var isPresentingConfirm: Bool = false
    @State private var isPresentingOK: Bool = false
    
    // observer variables
    @State var firstname: String = UserDefaults.standard.string(forKey: "FirstName_Key") ?? ""
    @State var lastname: String = UserDefaults.standard.string(forKey: "LastName_Key") ?? ""
    @State var email: String = UserDefaults.standard.string(forKey: "Email_Key") ?? ""
    @State private var timestamp = Date()
    
    // defendant variables
    @State var gender: String = UserDefaults.standard.string(forKey: "Gender_Key") ?? ""
    @State var race: String = UserDefaults.standard.string(forKey: "Race_Key") ?? ""
    @State var disability: String = "No"
    @State var attnpresent: Bool = false
    @State var representation: String = UserDefaults.standard.string(forKey: "Representation_Key") ?? ""
    @State var attorneyname: String = UserDefaults.standard.string(forKey: "AttorneyName_Key") ?? ""
    @State var charge: String = UserDefaults.standard.string(forKey: "Charge_Key") ?? ""
    @State var pretrialriskassessment: String = "No"
    
    // proceeding variables
    @State private var observationdate = Date()
    @State var proceedingtype: String = UserDefaults.standard.string(forKey: "ProceedingType_Key") ?? ""
    @State private var scheduledproceedingtime = Date()
    @State var proceedingoutcome: String = UserDefaults.standard.string(forKey: "ProceedingOutcome_Key") ?? ""
    @State var monetarybailamount: String = UserDefaults.standard.string(forKey: "MonetaryBailAmount_Key") ?? ""
    @State var atmosphere: String = UserDefaults.standard.string(forKey: "CourtAtmosphere_Key") ?? ""
    @State var notes: String = UserDefaults.standard.string(forKey: "Notes_Key") ?? ""
    @State private var selectedJudge: String = ""
    
    
    // MARK: Main Textfields
    var body: some View
    {
        VStack
        {
            Form
            {
                // Observer Info section
                Section(header: Text("Observer Info"))
                {
                    TextField("First Name*",
                              text: $firstname)
                    .disableAutocorrection(true)
                    TextField("Last Name*",
                              text: $lastname)
                    .disableAutocorrection(true)
                    TextField("Email*",
                              text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    DatePicker("Timestamp",
                               selection: $timestamp)
                }
                // Defendant Info section
                Section(header: Text("Defendant Info"))
                {
                    TextField("Gender",
                              text: $gender)
                    TextField("Race",
                              text: $race)
                    
                    HStack
                    {
                        Text("Obvious Disability?")
                        Spacer()
                        Picker("Obvious Disability?", selection: $disability)
                        {
                            Text("Yes").tag("Yes")
                            Text("No").tag("No")
                        }.frame(width: 400)
                        .pickerStyle(.segmented)
                    }
                    
                    HStack
                    {
                        Text("Attorney Present?")
                        Spacer()
                        Picker("Attorney Present?", selection: $attnpresent)
                        {
                            Text("Yes").tag(true)
                            Text("No").tag(false)
                        }.frame(width: 400)
                        .pickerStyle(.segmented)
                    }
                    
                    if (attnpresent)
                    {
                        TextField("Attorney Name",
                                  text: $attorneyname)
                        .disableAutocorrection(true)
                    }
                    TextField("Charges*",
                              text: $charge)
                    HStack
                    {
                        Text("Pre-Trial Risk Assessment?")
                        Spacer()
                        Picker("Pre-Trial Risk Assessment?", selection: $pretrialriskassessment)
                        {
                            Text("Yes").tag("Yes")
                            Text("No").tag("No")
                        }.frame(width: 400)
                        .pickerStyle(.segmented)
                    }
                    
                }
                // Proceeding Info section
                Section(header: Text("Proceeding Info"))
                {
                    DatePicker("Observation Date",
                               selection: $observationdate,
                               displayedComponents: [.date])
                    TextField("Proceeding Type",
                              text: $proceedingtype)
                    DatePicker("Scheduled Proceeding Time",
                               selection: $scheduledproceedingtime,
                               displayedComponents: [.hourAndMinute])
                    Picker("Judge*", selection: $selectedJudge)
                    {
                        Text("Select Judge").tag("")
                        ForEach(jvm.judges, id: \.recordId)
                        {
                            judge in
                            Text(judge.judgefirstname + " " + judge.judgelastname).tag(judge.judgelastname)
                        }
                    }
                    .onAppear()
                    {
                        jvm.populateJudges()
                    }
                    .onChange(of: selectedJudge, perform:
                                {
                        newValue in
                        print(newValue as String)
                    })
                    .pickerStyle(.menu)

                    TextField("Proceeding Outcome*",
                              text: $proceedingoutcome)
                    TextField("Monetary Bail Amount",
                              text: $monetarybailamount)
                    TextField("Court Room Atmosphere",
                              text: $atmosphere)
                }
                // Notes section
                Section(header: Text("Additional Notes"))
                {
                    TextEditor(text: $notes)
                        .font(.title)
                        .foregroundColor(.black)
                        .frame(height: 200)
                }
                
                // User actions
                Section(header: Text("Actions"), footer: Text("* indicates required field."))
                {
//                    TODO: Implement saving locally to iPad, then uncomment this button
//                    
//                    Button("Save to Device")
//                    {
//                        UserDefaults.standard.set(firstname, forKey: "FirstName_Key")
//                        UserDefaults.standard.set(lastname, forKey: "LastName_Key")
//                        UserDefaults.standard.set(email, forKey: "Email_Key")
//                        UserDefaults.standard.set(gender, forKey: "Gender_Key")
//                        UserDefaults.standard.set(race, forKey: "Race_Key")
//                        UserDefaults.standard.set(disability, forKey: "Disability_Key")
//                        UserDefaults.standard.set(representation, forKey: "Representation_Key")
//                        UserDefaults.standard.set(attorneyname, forKey: "AttorneyName_Key")
//                        UserDefaults.standard.set(charge, forKey: "Charge_Key")
//                        UserDefaults.standard.set(pretrialriskassessment, forKey: "RiskAssessment_Key")
//                        UserDefaults.standard.set(proceedingtype, forKey: "ProceedingType_Key")
//                        UserDefaults.standard.set(scheduledproceedingtime, forKey: "ScheduledProceedingTime_Key")
//                        UserDefaults.standard.set(selectedJudge, forKey: "JudgeLastName_Key")
//                        UserDefaults.standard.set(proceedingoutcome, forKey: "ProceedingOutcome_Key")
//                        UserDefaults.standard.set(monetarybailamount, forKey: "MonetaryBailAmount_Key")
//                        UserDefaults.standard.set(atmosphere, forKey: "CourtAtmosphere_Key")
//                        UserDefaults.standard.set(notes, forKey: "Notes_Key")
//                        isPresentingOK = true
//                    }.disabled(firstname.isEmpty || lastname.isEmpty || email.isEmpty || charge.isEmpty || proceedingoutcome.isEmpty || selectedJudge.isEmpty || (attnpresent == true && attorneyname.isEmpty))
//                    .alert("Saved!", isPresented: $isPresentingOK, actions:
//                    {
//                        Button("OK", action: {})
//                    }, message:
//                    {
//                        Text("Information saved to your device.")
//                    })
                    
                    Button("Send to Database")
                    {
                        isPresentingConfirm = true
                    }.disabled(firstname.isEmpty || lastname.isEmpty || email.isEmpty || charge.isEmpty || proceedingoutcome.isEmpty || selectedJudge.isEmpty || (attnpresent == true && attorneyname.isEmpty))
                    .alert("Send to Database?", isPresented: $isPresentingConfirm, actions:
                    {
                        Button("Yes, Send It", action:
                        {
                            // database stuff, clears text fields & sends data to CloudKit database
                            
                            vm.saveInfo(firstname: firstname, lastname: lastname, email: email, timestamp: timestamp, gender: gender, race: race, disability: disability, representation: representation, attorneyname: attorneyname, charge: charge, pretrialriskassessment: pretrialriskassessment, observationdate: observationdate, proceedingtype: proceedingtype, scheduledproceedingtime: scheduledproceedingtime, judgelastname: selectedJudge, proceedingoutcome: proceedingoutcome, monetarybailamount: monetarybailamount, atmosphere: atmosphere, notes: notes)
                            self.firstname = ""
                            self.lastname = ""
                            self.email = ""
                            self.gender = ""
                            self.race = ""
                            self.disability = "No"
                            self.attnpresent = false
                            self.attorneyname = ""
                            self.charge = ""
                            self.pretrialriskassessment = "No"
                            self.proceedingtype = ""
                            self.selectedJudge = ""
                            self.proceedingoutcome = ""
                            self.monetarybailamount = ""
                            self.atmosphere = ""
                            self.notes = ""
                            
                            
                            // clears all textfields but requires user to quit the app, should be put in an IF statement that checks that the user data was saved successfully before executing
                            let domain = Bundle.main.bundleIdentifier!
                            UserDefaults.standard.removePersistentDomain(forName: domain)
                            UserDefaults.standard.synchronize()
                        })
                        Button("Cancel", role: .cancel, action: {})
                    }, message:
                    {
                        Text("You cannot undo this action.")
                    })
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(vm: CourtWatchViewModel(container: CKContainer.default()), jvm: JudgeListViewModel(container: CKContainer.default()))
            
        }
    }
}
