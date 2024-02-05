//
//  CW_Forms_3App.swift
//  CW Forms 3
//
//  Created by Capstone Court Watch on 11/1/22.
//

import SwiftUI
import CloudKit

@main
struct CW_Forms_3App: App {
    let persistenceController = PersistenceController.shared
    let container = CKContainer(identifier: "iCloud.courtWatch")

    var body: some Scene {
        WindowGroup {
            HomeView()
            //ContentView(vm: CourtWatchViewModel(container: container))
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
