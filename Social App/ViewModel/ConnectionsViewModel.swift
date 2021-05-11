import SwiftUI
import Firebase

class ConnectionsViewModel : ObservableObject{
    
    @Published var currentFollowers = [String]()
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    @Published var temp = false
    @Published var imageString = ""
    @Published var tempString = ""
    
    func getAllFollowing(userString : String) {
        
        ref.collection("Users").whereField("uid", isEqualTo: userString).getDocuments { (snap, err) in
            
            if let err = err {
                // Error fetching documents
                print("Error fetching followers: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let connections = document.data()["connections"] as! [String]
                    self.currentFollowers.append(contentsOf: connections)
                }
        
            }
        }
    }
    
    func setUser(userString : String) {
        
        self.tempString = userString
    }
    
    func setImage(userString : String) {
        Firestore.firestore().collection("Users").document(userString).getDocument {
            (document, error) in
            if let document = document {
                self.imageString = document["imageurl"] as? String ?? ""
            }
        }
    }
}
