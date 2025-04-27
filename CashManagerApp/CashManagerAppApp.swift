//
//  CashManagerAppApp.swift
//  CashManagerApp
//
//  Created by Hoàng Nam on 27/4/25.
//

import FirebaseCore
import SwiftUI

@main
struct CashManagerApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
