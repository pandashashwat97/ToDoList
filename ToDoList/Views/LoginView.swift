//
//  LoginView.swift
//  ToDoList
//
//  Created by Shashwat Panda on 04/12/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var userName: String = ""
    @State var password: String = ""
    @State var isUserRegistered: Bool = true
    @State var isLoginSuccessful: Bool = false
    
    var textFieldBColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Welcome")
                .padding(.bottom, 20)
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundStyle(Color.indigo)
            VStack {
                TextField("user name", text: $userName)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(textFieldBColor))
                    .cornerRadius(10)
                SecureField("password", text: $password)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(textFieldBColor))
                    .cornerRadius(10)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
            }
            HStack{
                Button {
                    if isUserRegistered {
                        listViewModel.login(userName: userName, password: password, completion: { isLoginSuccessful in
                            if isLoginSuccessful {
                                self.isLoginSuccessful.toggle()
                            }
                        })
                    } else {
                            listViewModel.register(userName: userName, password: password, completion: {
                                isRegisterationSuccessful in
                                if isRegisterationSuccessful {
                                    self.isLoginSuccessful.toggle()
                                }
                            })
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isUserRegistered ? Color.cyan : Color.pink)
                            .frame(width: 150, height: 50)
                        Text(isUserRegistered ? "Login": "Register")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 50, bottom: 0, trailing: 0))
                Button {
                    isUserRegistered.toggle()
                } label: {
                    Text(isUserRegistered ? "Not Registerd ?" : "Back to Login!")
                        .font(.custom("Inter", size: 18))
                        .fontWeight(.heavy)
                        .padding(.leading, 10)
                        .foregroundStyle(isUserRegistered ? Color.pink : Color.cyan)
                }
                .padding(.top, 20)
                .navigationDestination(isPresented: $isLoginSuccessful) {
                    ListView()
                }
            }
            if let invalidAuth = listViewModel.invalidAuth {
                Text(invalidAuth)
                    .padding(.top, 30)
                    .foregroundStyle(Color.red)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView(userName: "", password: "")
}
