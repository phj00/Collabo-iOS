import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject{
    
    @Published var name = ""
    @Published var bio = ""
    @Published var school = ""
    @Published var company = ""
    @Published var savedPosts = [String]()
    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    let ref = Firestore.firestore()
    // Loading View...
    @Published var isLoading = false
    @Published var NewAccLogIn = false
    @AppStorage("current_status") var status = false
    
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var doCreateAccount = false
    
    @Published var registerUser = false
    
    @Published var error = false
    @Published var errorMsg = ""
    
    @Published var isLoadingCA = false
    
    func register(uid: String){
        
        isLoading = true
        // setting User Data To Firestore....
        print(uid)
        
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(uid).setData([
            
                "uid": uid,
                "imageurl": url,
                "username": self.name,
                "school": self.school,
//                "company": self.company,
                "bio": self.bio,
                "dateCreated": Date(),
                "savedPosts": self.savedPosts
                
            ]) { (err) in
             
                if err != nil{
                    self.isLoading = false
                    return
                }
                self.isLoading = false
                // success means settings status as true...
                self.status = true
                self.NewAccLogIn.toggle()
            }
        }
//        print("reg : " , self.isLoading)
    }
    
}
