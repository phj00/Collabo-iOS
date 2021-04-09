import SwiftUI
import Firebase

// Global Refernce

let ref = Firestore.firestore()

func fetchUser(uid: String,completion: @escaping (UserModel) -> ()){
    
    ref.collection("Users").document(uid).getDocument { (doc, err) in
        guard let user = doc else{return}
        
        let username = user.data()?["username"] as! String
        let school = user.data()?["school"] as! String
        let pic = user.data()?["imageurl"] as! String
        let bio = user.data()?["bio"] as! String
        let uid = user.documentID
        let savedPosts = user.data()?["savedPosts"] as! Array<String>
        
        DispatchQueue.main.async {
            completion(UserModel(username: username, school: school, pic: pic, bio: bio, uid: uid, savedPosts: savedPosts))
        }
    }
}
