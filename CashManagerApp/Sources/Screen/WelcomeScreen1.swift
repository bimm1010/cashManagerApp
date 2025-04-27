    //
    //  WelcomeScreen1.swift
    //  CaseManager
    //
    //  Created by Hoàng Nam on 8/4/25.
    //

import SwiftUI

struct WelcomeScreen1: View {
    @Binding var navigationPath: NavigationPath
    var body: some View {
        ZStack {
            OnboardingView(navigationPath: $navigationPath)
            ViewStartApp()
        }
    }
}


struct ViewStartApp: View {
    @State private var isShow: Bool = true
    var body: some View {
        if isShow {
            ZStack {
                Rectangle().fill(Color(hex: GlobalConfig.colorTheme)).ignoresSafeArea(.all)
                Text("Expenses")
                    .font(.custom("Inter_28pt-Regular", size: 50))
                    .fontWeight(.bold).foregroundStyle(.white)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.8)))
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    withAnimation(.linear(duration: 0.1)) {
                        self.isShow = false
                    }
                }
            }
        }
    }
}

struct OnboardingView: View {
    @Binding var navigationPath: NavigationPath
    var body: some View {
        ZStack {
            Rectangle().fill(Color.white.opacity(0.3)).ignoresSafeArea(.all)
            VStack{
                Image("Frame33")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(edges: .top)
                Spacer()
                TextForTitle(isStringForTitle: "Spend Smarter")
                TextForTitle(isStringForTitle: "Save More")
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: GlobalConfig.colorTheme))
                    .frame(width: 350, height: 60)
                    .shadow(
                        color: Color(hex: GlobalConfig.colorTheme).opacity(0.6),
                        radius: 15,
                        x: 0,
                        y: 15
                    )
                    .onTapGesture {
                        navigationPath.append(Screen.createCase)
                    }
                    .padding(.vertical, 25)
                    .overlay(
                        Text("Get Started")
                            .font(.custom("Inter_14pt-Regular", size: 18))
                            .foregroundColor(.white)
                            .padding(.all))
                HStack{
                    Text("Already Have Account?")
                        .font(.custom("Inter_14pt-Regular", size: 14))
                        .fontWeight(.light)
                    Button(action: {
                        navigationPath.append(Screen.login)
                    }) {
                        Text("Log In")
                            .foregroundStyle(Color(hex: GlobalConfig.colorTheme))
                            .font(.system(size: 14))
                    }
                }.padding(.bottom, 20)
            }
            
        }
    }
}

struct TextForTitle: View {
    let isStringForTitle: String
    var body: some View {
        Text(isStringForTitle)
            .font(.custom("Inter_28pt-SemiBold", size: 36))
            .fontWeight(.bold)
            .foregroundStyle(Color(hex: GlobalConfig.colorTheme))
    }
}
