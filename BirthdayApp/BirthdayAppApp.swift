//
//  BirthdayAppApp.swift
//  BirthdayApp
//
//  Created by Vaibhavi Bandaru on 7/11/25.
//

import SwiftUI
import SwiftData

@main
struct BirthdayAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                //container that allows data persistence to occur
                .modelContainer(for: Friend.self)
        }
    }
}

