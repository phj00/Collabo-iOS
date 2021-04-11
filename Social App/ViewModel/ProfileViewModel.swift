import SwiftUI
import Firebase

class ProfileViewModel : ObservableObject{
    let uid = Auth.auth().currentUser!.uid
    @Published var showProfile = false
    @Published var userInfo = UserModel(username: "", school: "", pic: "", bio: "", uid: "", savedPosts: [String](), appliedTo: [String]())
    @Published var currentView = false
    @Published var currentBool = false
    @Published var tempBool = false
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
}

