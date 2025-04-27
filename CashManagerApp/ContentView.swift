//
//  ContentView.swift
//  CashManagerApp
//
//  Created by Hoàng Nam on 27/4/25.
//

import SwiftUI

enum Screen {
    case welcomeSreen1
    case login
    case createCase
    case home
}

struct ContentView: View {
    @State private var navigationPath: NavigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $navigationPath) {
            WelcomeScreen1(navigationPath: $navigationPath)
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .welcomeSreen1:
                        Text("Welcome Screen 1")
                    case .login:
                        LogInView(path: $navigationPath)
                    case .createCase:
                        CreateUserView(path: $navigationPath)
                    case .home:
                        HomeScreen()
                    }
                }
        }
    }
}
