import SwiftUI
import Firebase

class RegisterViewModel : ObservableObject{
    
    @Published var name = ""
    @Published var bio = ""
    @Published var school = ""
    @Published var savedPosts = [String]()
    @Published var appliedTo = [String]()
    @Published var connections = [String]()

    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    let ref = Firestore.firestore()
    // Loading View...
    @Published var isLoading = false
    @Published var isRegistered = false
    @AppStorage("current_status") var status = false
    
    func register(){
        
        isLoading = true
        // setting User Data To Firestore....
        
        let uid = Auth.auth().currentUser!.uid
        
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(uid).setData([
            
                "uid": uid,
                "imageurl": url,
                "username": self.name,
                "school": self.school,
                "bio": self.bio,
                "dateCreated": Date(),
                "savedPosts": self.savedPosts,
                "appliedTo": self.appliedTo,
                "connections": self.connections

                
            ])
            self.ref.collection("Connections").document(uid).setData([
                "id": uid,
                "pic": url,
                "username": self.name,
                "connections": self.connections
            ])
            { (err) in
             
                if err != nil{
                    self.isLoading = false
                    return
                }
                
                self.isLoading = false
                // success means settings status as true...
                self.status = true
                self.isRegistered = true
            }
        }
    }
}
