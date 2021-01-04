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
    
    @Published var accountExists = false
    @Published var registerUser = false
    
    @Published var error = false
    @Published var errorMsg = ""
    
    @Published var isLoading = false
    
    func createNewAccount(){
        self.doCreateAccount.toggle()
        return
    }
    
    func createAccount(){
        self.isLoading = true
        self.accountExists = false
        
        Auth.auth().createUser(withEmail: self.email, password: self.password){ (res, err) in
            
            if err != nil{
                self.errorMsg = err!.localizedDescription
                self.error.toggle()
                self.accountExists = true
                self.isLoading = false
                return
            }
            
            self.registerUser.toggle()
            self.doCreateAccount.toggle()
            
        }
        
    }
    
}
