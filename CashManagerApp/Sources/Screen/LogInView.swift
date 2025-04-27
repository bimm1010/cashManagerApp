    //
    //  LogInView.swift
    //  CaseManager
    //
    //  Created by Hoàng Nam on 9/4/25.
    //

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    @State private var userNameLogin: String = "test1@gmail.com"
    @State private var passwordLogin: String = "123456"
    @Binding var path: NavigationPath
    @State private var messageNotification: String = ""
    @State private var isShowMessageAlert: Bool = false
    var body: some View {
        VStack {
            TextForTitle(isStringForTitle: "Welcome back!")
            UserLoginField(userNameLogin: $userNameLogin)
            PassWordLoginField(passwordLogin: $passwordLogin)
            ButtonSubmitLoginUser(
                userNameLoginData: $userNameLogin,
                passwordLoginData: $passwordLogin,
                path: $path,
                messageError: $messageNotification,
                showAlertMessage: $isShowMessageAlert
            )
            MessageAlert(messageAlert: $messageNotification, showMessage: $isShowMessageAlert)
        }
    }
}


struct UserLoginField: View {
    @Binding var userNameLogin: String
    var body: some View {
        VStack {
            Text("Name on Card")
                .font(.system(size: 12)) // Reduced font size
                .foregroundColor(Color.gray) // Label color
                .frame(maxWidth: .infinity, alignment: .leading) // Left alignment
                .padding(.leading, 8) // Add some left padding
                .offset(x: 6, y: 14)
            
            TextField("Enter your username", text: $userNameLogin)
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


struct PassWordLoginField: View {
    @Binding var passwordLogin: String
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
                        TextField("Enter your password", text: $passwordLogin)
                    }else {
                        SecureField("Enter your password", text: $passwordLogin)
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

struct ButtonSubmitLoginUser: View {
    @Binding var userNameLoginData: String
    @Binding var passwordLoginData: String
    @Binding var path: NavigationPath
    @Binding var messageError: String
    @Binding var showAlertMessage: Bool
    @State private var isEnable: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: GlobalConfig.colorTheme))
            .frame(width: 250, height: 50)
            .shadow(color: Color(hex: GlobalConfig.colorTheme).opacity(0.6), radius: 15, x: 0, y: 15)
            .padding(.vertical, 25)
            .overlay(
                Text("Let's Go")
                    .font(.custom("Inter_14pt-Regular", size: 18))
                    .foregroundColor(.white)
                    .padding(.all))
            .onTapGesture {
                if isEnable {
                    Task {
                        isEnable = false
                        await checkAccount()
                    }
                }
                
            }
    }
    func checkAccount() async {
        if !userNameLoginData.isEmpty && !passwordLoginData.isEmpty {
            do {
                let _ = try await Auth.auth().signIn(withEmail: userNameLoginData, password: passwordLoginData)
                messageError = "login success"
                userNameLoginData = ""
                passwordLoginData = ""
                path.append(Screen.home)
            }
            catch {
                showAlertMessage = true
                let errorCode = (error as NSError).code
                switch errorCode {
                case AuthErrorCode.userNotFound.rawValue:
                    messageError = "Email not found"
                case AuthErrorCode.wrongPassword.rawValue:
                    messageError = "Password not correct"
                case AuthErrorCode.invalidEmail.rawValue:
                    messageError = "Email not valid"
                default:
                    messageError = "check your email and password"
                }
            }
        }
    }
}


struct MessageAlert: View {
    @Binding var messageAlert: String
    @Binding var showMessage: Bool
    var body: some View {
        showMessage ? Text(messageAlert).foregroundColor(.red) : nil
    }
}
