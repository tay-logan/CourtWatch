//
//  HomeView.swift
//  Court Watch
//
//  Created by Taylor Logan, Cian Toole, Tahereh Alamdari,
//  Quang Dang, Nathan Zabloudil, Yamuna Rizal
//  University of Louisville Capstone Project Spring 2023
//

import SwiftUI
import CloudKit

struct NavButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            .cornerRadius(8)
    }
}

struct HomeView: View {
    
    let persistenceController = PersistenceController.shared
    let container = CKContainer(identifier: "iCloud.courtWatch")
    
    @State private var isPresentingINFO: Bool = false
        
    var body: some View {
            VStack() {
                
                NavigationStack {
                    Button() {
                        
                        isPresentingINFO = true
                    }label: {
                        Image(systemName: "info.circle").resizable().frame(width: 20, height: 20)
                    }.offset(x: 480, y: -200)
                    .alert("INFO", isPresented: $isPresentingINFO, actions: {
                        Button("OK", action: {})
                    }, message: {
                        Text("Update Notes: \n v2.0. Created Main Menu screen. Created Reports Screen. Created Manage Judges Screen. Fine-tuned New Entry screen.  \n\nCreated by: Justin Williams, Jacob Langdon, Chuda Dhakal. Fall 2022.\n\n Continued by Taylor Logan, Cian Toole, Tahereh Alamdari, Quang Dang, Nathan Zabloudil, Yamuna Rizal. Spring 2023.")
                    })
                    
                    
                    Image("icon").resizable().aspectRatio(contentMode: .fit).frame(width: 300, height: 300).offset(y: -30)
                    Text("Court Watch").font(.system(size: 48)).offset(y: -40)
                    NavigationLink(destination: ContentView(vm: CourtWatchViewModel(container: container), jvm: JudgeListViewModel(container: container))
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)){
                            HStack {
                                Image("plus").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading).offset(x: 25)
                                    Text("New Entry").font(.system(size: 36)).foregroundColor(.black).frame(width: 235, height: 75, alignment: .center)
                                }}.buttonStyle(NavButton()).padding(20)
                    
                    NavigationLink(destination: ReportsView(vm: CourtWatchViewModel(container: container), jvm: JudgeListViewModel(container: container))
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)){
                        HStack {
                            Image("reports").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading).offset(x: 30)
                            (Text("Reports").font(.system(size: 36)).foregroundColor(.black)).frame(width: 235, height: 75, alignment: .center)
                        }}.buttonStyle(NavButton()).padding(20)
                    
                    NavigationLink(destination: ManageView(vm: JudgeListViewModel(container: container)).environment(\.managedObjectContext, persistenceController.container.viewContext)){
                        HStack {
                            Image("manage").resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50, alignment: .leading).offset(x: 25)
                            Text("Manage").font(.system(size: 36)).foregroundColor(.black).frame(width: 235, height: 75, alignment: .center)
                        }}.buttonStyle(NavButton()).padding(20)
                }
            }
    }
}
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
