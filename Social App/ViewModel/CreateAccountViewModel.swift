//
//  CreateAccountViewModel.swift
//  Social App
//
//  Created by Ryan Koo on 1/3/21.
//

import SwiftUI
import Firebase

class CreateAccountViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var doCreateAccount = false
    
    @Published var registerUser = false
    
    @Published var error = false
    @Published var errorMsg = ""
    
    @Published var isLoadingCA = false
    @Published var createDone = false
    
    @Published var id = ""
    
    func createNewAccount(){
        self.doCreateAccount.toggle()
        return
    }
    
    func createAccount(){
        
        print("first: " ,Auth.auth().currentUser!.uid)
        
        
        Auth.auth().createUser(withEmail: self.email, password: self.password){ (res, error) in
            
            if error != nil{
                
                if let errCode = AuthErrorCode(rawValue: (error?._code)!) {

                    switch errCode {
                        case .emailAlreadyInUse:
                            print("email already in use")
                            self.errorMsg = "E-mail is already in use."
                        case .invalidEmail:
                            print("invalid email")
                            self.errorMsg = "Invalid e-mail address."
                        case .weakPassword:
                            print("weak password")
                            self.errorMsg = "Weak password."
                        default:
                            break
                    }
                }
                
                self.error = true
                self.isLoadingCA = false
                self.createDone = true
                return
            }
            
            print("hi : ", self.isLoadingCA)
            self.registerUser.toggle()
            self.doCreateAccount.toggle()
            
        }
        
        self.id = Auth.auth().currentUser!.uid
        print("cre: ", id)
    
        
    }
    
    
}
