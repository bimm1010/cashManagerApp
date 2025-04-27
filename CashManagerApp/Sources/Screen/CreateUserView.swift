    //
    //  CreateUserView.swift
    //  CaseManager
    //
    //  Created by Hoàng Nam on 9/4/25.
    //

import SwiftUI
import FirebaseAuth

struct CreateUserView: View {
    @State private var userName: String = "Test1@gmail.com"
    @State private var passWord: String = "123456"
    @Binding var path: NavigationPath
    @State var showAlert: Bool = false
    @State private var message: String = ""
    @State private var isLoading: Bool = false
    var body: some View {
        VStack {
            Image("Frame33").resizable().frame(width: 100, height: 100)
            TextForTitle(isStringForTitle:"Welcome to Cash Manager")
                .multilineTextAlignment(.center)
            UserField(userName: $userName)
            PassWordField(password: $passWord)
            MessageView(isLoading: $isLoading)
            AlertView(showAlert: $showAlert, Message: $message)
            ButtonSubmitCreateUser(
                userData: $userName,
                passData: $passWord,
                showAlert: $showAlert, Message: $message, path: $path, isLoading: $isLoading
            )
            HaveAccountButton(navigationPath: $path)
        }
    }
}



struct UserField: View {
    @Binding var userName: String
    var body: some View {
        VStack {
            Text("Name on Card")
                .font(.system(size: 12)) // Reduced font size
                .foregroundColor(Color.gray) // Label color
                .frame(maxWidth: .infinity, alignment: .leading) // Left alignment
                .padding(.leading, 8) // Add some left padding
                .offset(x: 6, y: 14)
            
            TextField("Enter your username", text: $userName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            Color(hex: GlobalConfig.colorTheme),
                            lineWidth: 1
                        ) // Light gray border
                )
                .accessibilityLabel("Name on Card") // Accessibility label
        }.padding(.horizontal, 30)
    }
}


struct PassWordField: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    var body: some View {
        VStack {
            Text("Pass on Card")
                .font(.system(size: 12)) // Reduced font size
                .foregroundColor(Color.gray) // Label color
                .frame(maxWidth: .infinity, alignment: .leading) // Left alignment
                .padding(.leading, 8) // Add some left padding
                .offset(x: 6, y: 14)
                .background(Color.white)
            
            ZStack {
                Group {
                    if isPasswordVisible {
                        TextField("Enter your password", text: $password)
                    }else {
                        SecureField("Enter your password", text: $password)
                    }
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: GlobalConfig.colorTheme), lineWidth: 1))
                .textContentType(.password)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .accessibilityLabel("Pass on Card")
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                        .font(.system(size: 15))
                        .foregroundStyle(
                            isPasswordVisible ? Color.red: Color(hex: GlobalConfig.colorTheme)
                        )
                }.offset(x: 140, y: 0)
            }
        }.padding(.horizontal, 30)
    }
}

struct ButtonSubmitCreateUser: View {
    @Binding var userData: String
    @Binding var passData: String
    @Binding var showAlert: Bool
    @Binding var Message: String
    @Binding var path: NavigationPath
    @Binding var isLoading: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: GlobalConfig.colorTheme))
            .frame(width: 250, height: 50)
            .shadow(color: Color(hex: GlobalConfig.colorTheme).opacity(0.6), radius: 15, x: 0, y: 15)
            .onTapGesture {
                if !userData.isEmpty && !passData.isEmpty {
                    showAlert = false
                    Auth.auth().createUser(withEmail: userData, password: passData) { authResult, error in
                        if let error = error as NSError? {
                            switch error.code {
                            case AuthErrorCode.emailAlreadyInUse.rawValue:
                                isLoading = true
                            default:
                                print("Error creating user: \(error.localizedDescription)")
                            }
                        }else {
                            Message = "Create User Successfully"
                            path.append(Screen.login)
                        }
                    }
                }else {
                    Message = "Check your email and password"
                    showAlert = true
                }
            }
            .padding(.vertical, 25)
            .overlay(
                Text("Let's Go")
                    .font(.custom("Inter_14pt-Regular", size: 18))
                    .foregroundColor(.white)
                    .padding(.all))
    }
}

struct HaveAccountButton: View {
    @Binding var navigationPath: NavigationPath
    @State private var timer: Timer?
    var body: some View {
        HStack{
            Text("Already Have Account?")
                .font(.custom("Inter_14pt-Regular", size: 14))
                .fontWeight(.light)
            Button(
                action: {
                    navigationPath = NavigationPath()
                    timer?.invalidate()
                    timer = Timer
                        .scheduledTimer(
                            withTimeInterval: 0.5,
                            repeats: false
                        ) { _ in
                            navigationPath.append(Screen.login)
                        }
                    
                }) {
                    Text("Log In")
                        .foregroundStyle(Color(hex: GlobalConfig.colorTheme))
                        .font(.system(size: 14))
                }
        }.padding(.bottom, 20)
    }
}

struct AlertView: View {
    @Binding var showAlert: Bool
    @Binding var Message: String
    var body: some View {
        if showAlert {
            Text(Message).foregroundStyle(.red)
        }
    }
}

struct MessageView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if isLoading {
            Text("Email already exist").foregroundStyle(.red)
        }
    }
}
