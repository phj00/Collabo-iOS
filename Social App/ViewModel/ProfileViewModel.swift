import SwiftUI
import Firebase

class ProfileViewModel : ObservableObject{
    let uid = Auth.auth().currentUser!.uid
    @Published var showProfile = false
    @Published var userInfo = UserModel(username: "", school: "", pic: "", bio: "", uid: "", savedPosts: [String]())

    //this function will be able to get us the correct user collection from the userString
    //Feed in userString from the post, match the userString with the list of the uid, and then
    //instantiate variables for all of the doc fields from users. (var school = userString.uid)
    //then feed it into profileView and get a full screen cover
    func showProf(userString : String) {
        fetchUser(uid: userString) { (user) in
            self.userInfo = user
        }
}

}
