//
//  MyTennisAppApp.swift
//  MyTennisApp
//
//  Created by Khanh Nguyen on 10/19/24.
//

import SwiftUI
import SwiftData
 
@main
struct MyTennisAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
				.modelContainer(for: Time.self)
    }
}
