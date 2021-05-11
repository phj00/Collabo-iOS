import SwiftUI
import Firebase

class ProfileViewModel : ObservableObject{
    let uid = Auth.auth().currentUser!.uid
    @Published var showProfile = false
    @Published var userInfo = UserModel(username: "", school: "", pic: "", bio: "", uid: "", savedPosts: [String](), appliedTo: [String](), connections: [String]())
    @Published var currentView = false
    @Published var currentBool = false
    @Published var tempBool = false
    @Published var connectionStatus = false
    @Published var connection_array = [String]()
    @Published var tempUserString = ""
    @Published var temp = false
    @AppStorage("current_status") var status = false

    
    func showProf(userString : String) {
        fetchUser(uid: userString) { (user) in
            self.userInfo = user
            
        }
    }
    
    func setUserString(userString : String) {
        self.tempUserString = userString
    }

    func getUserString() -> String {
        
        return self.tempUserString
        
    }
    
    func connectTo(userString: String){
        
        let uid = Auth.auth().currentUser!.uid

        ref.collection("Users").document(userString).updateData([
            "connections": FieldValue.arrayUnion([uid])
        ])
        
        ref.collection("Users").document(uid).updateData([
            "connections": FieldValue.arrayUnion([userString])
        ])
        
        ref.collection("Connections").document(userString).updateData([
            "connections": FieldValue.arrayUnion([uid])
        ])
        
        ref.collection("Connections").document(uid).updateData([
            "connections": FieldValue.arrayUnion([userString])
        ])
        
        connectionStatus = !connectionStatus
    }
    
    func disconnectFrom(userString: String){
        
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").document(uid).updateData([
            "connections": FieldValue.arrayRemove([userString])
        ])
        
        ref.collection("Users").document(userString).updateData([
            "connections": FieldValue.arrayRemove([uid])
        ])
        
        ref.collection("Connections").document(uid).updateData([
            "connections": FieldValue.arrayRemove([userString])
        ])
        
        ref.collection("Connections").document(userString).updateData([
            "connections": FieldValue.arrayRemove([uid])
        ])

        connectionStatus = !connectionStatus
    }
    
    func connectionContains(userString: String) -> Bool {
        
        let uid = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("Users").document(uid).getDocument {
            (document, error) in
            if let document = document {
                self.connection_array = document["connections"] as? Array ?? [""]
            }
        }
        Firestore.firestore().collection("Connections").document(uid).getDocument {
            (document, error) in
            if let document = document {
                self.connection_array = document["connections"] as? Array ?? [""]
            }
        }
        
        if self.connection_array.contains(userString) {
            return true
        } else {
            return false
        }
        
    }
}
