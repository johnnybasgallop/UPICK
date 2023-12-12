//
//  SignInViewModel.swift
//  BarkLog
//
//  Created by johnny basgallop on 09/12/2023.
//
import SwiftUI
import Foundation
import Firebase
import CryptoKit
import FirebaseFirestore
import AuthenticationServices

class SignInViewModel: ObservableObject{
    @Published var nonce = ""
    @AppStorage ("log_state") var log_state = false
    
    func SignInWithAppleRequest(_ request: ASAuthorizationOpenIDRequest){
        nonce = randomNonceString()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
    }
    
    func SignInWithAppleCompletion(_ result: Result <ASAuthorization, Error>) {
        switch result{
        case .success(let user):
            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                print("credential 23")
                return
            }
            
            guard let token = credential.identityToken else {
                print("error with token 27")
                return
            }
            
            guard let tokenString = String(data: token, encoding: .utf8) else{
                print("error with token string")
                return
            }
            
            let credention = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            
            Task{
                do{
                   try await Auth.auth().signIn(with: credention)
                    DispatchQueue.main.async {
                        self.log_state = true
                    }
                }
                catch{
                    print("caught")
                }
            }
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}


private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}



