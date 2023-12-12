//
//  SignUpScreen.swift
//  BarkLog
//
//  Created by johnny basgallop on 10/12/2023.
//

import SwiftUI
import AuthenticationServices

struct SignUpScreen: View {
    
    @AppStorage ("log_state") var log_state = false
    @StateObject var signInViewModel = SignInViewModel()
    
    var body: some View {
        VStack{
            
            Text("UPick")
                .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40)).offset(y:screenHeight * 0.01)
            
            Spacer()
            
            Image("SplashImage")
                .resizable()
                .frame(width: screenWidth * 0.7, height: screenWidth * 0.7).offset(y: -screenHeight * 0.05)
            
            
            VStack(alignment: .leading){
                Text("Find.")
                    .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40)).offset(y:screenHeight * 0.05)
                
                Text("Watch.")
                    .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40)).offset(y:screenHeight * 0.05)
                
                Text("Enjoy.")
                    .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40)).offset(y:screenHeight * 0.05)
            }.frame(width: screenWidth * 0.65, alignment: .leading).offset(y: -screenHeight * 0.06 )
            
    
            Spacer()
            
            SignInWithAppleButton {request in
                signInViewModel.SignInWithAppleRequest(request)
            } onCompletion: { result in
                signInViewModel.SignInWithAppleCompletion(result)
            }.frame(width: 300, height: 50).cornerRadius(10).offset(y: -screenHeight * 0.02)
        }
    }
}

#Preview {
    SignUpScreen()
       
}

