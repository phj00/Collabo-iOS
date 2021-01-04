import SwiftUI
import Firebase

class LoginViewModel : ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var emailNotRegistered = false
    
    @Published var code = ""
    @Published var number = ""
    
    // For Any Errors..
    @Published var errorMsg = ""
    @Published var error = false
    
    @Published var registerUser = false
    @AppStorage("current_status") var status = false
    
    // Loading when Searches for user...
    @Published var isLoading = false
    
    func logIn(){
        
        self.emailNotRegistered = false
        
        if self.email != "" && self.password != ""{
            
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in
                
                if err != nil{
                    self.errorMsg = err!.localizedDescription
                    self.error.toggle()
                    self.emailNotRegistered = true
                    self.isLoading = false
                    return
                }
                print("hello")
                self.checkUser()
            }
        }
        
    }
    
    func checkUser(){
        
        let ref = Firestore.firestore()
        
        ref.collection("Users").whereField("email", isEqualTo: self.email).getDocuments { (snap, err) in
            
            if err != nil{
                // No Documents..
                // No User Found...
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            
            if snap!.documents.isEmpty{
                
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
    
}
