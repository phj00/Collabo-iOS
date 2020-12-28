import SwiftUI
import Firebase

class SettingsViewModel : ObservableObject{
    
    @Published var userInfo = UserModel(username: "", school: "", pic: "", bio: "", uid: "", savedPosts: [String]())
    @AppStorage("current_status") var status = false
    
    // Image Picker For Updating Image...
    @Published var picker = false
    @Published var img_data = Data(count: 0)
    
    // Loading View..
    @Published var isLoading = false
    
    // 12.28 Added :
    @Published var MyProjects : [PostModel] = []
    @Published var noMyProjects = false
    @Published var updateId = ""
    @Published var uid = Auth.auth().currentUser!.uid
    
    let ref = Firestore.firestore()
    
    init() {
        
        fetchUser(uid: uid) { (user) in
            self.userInfo = user
        }
        
        getMyProjects()
    }
    
    func logOut(){
        
        // logging out..
        
        try! Auth.auth().signOut()
        status = false
    }
    
    func updateImage(){
        
        isLoading = true
        
        UploadImage(imageData: img_data, path: "profile_Photos") { (url) in
            
            self.ref.collection("Users").document(self.uid).updateData([
            
                "imageurl": url,
            ]) { (err) in
                if err != nil{return}
                
                // Updating View..
                self.isLoading = false
                fetchUser(uid: self.uid) { (user) in
                    self.userInfo = user
                }
            }
        }
    }
    
    func updateDetails(field : String){
        
        alertView(msg: "Update \(field)") { (txt) in
            
            if txt != ""{
                
                self.updateBio(id: field == "Name" ? "username" : "bio", value: txt)
            }
        }
    }
    
    func updateBio(id: String,value: String){
        
        ref.collection("Users").document(uid).updateData([
        
            id: value,
        ]) { (err) in
            
            if err != nil{return}
            
            // refreshing View...
            
            fetchUser(uid: self.uid) { (user) in
                self.userInfo = user
            }
        }
    }
    
    // 12:28 Added:
    
    func getMyProjects(){
        
        ref.collection("Projects").addSnapshotListener { (snap, err) in
            guard let docs = snap else{
                self.noMyProjects = true
                return
                
            }
            
            if docs.documentChanges.isEmpty{
                
                self.noMyProjects = true
                return
            }
            
            docs.documentChanges.forEach { (doc) in
                
                let userString = doc.document.data()["userString"] as! String
    
                // Checking If Doc Added...
                if doc.type == .added && userString == self.uid {
                    
                    // Retreving And Appending...
                    
                    let title = doc.document.data()["title"] as! String
                    let category = doc.document.data()["category"] as! String
                    let time = doc.document.data()["time"] as! Timestamp
                    let pic = doc.document.data()["url"] as! String
                    let userRef = doc.document.data()["ref"] as! DocumentReference
                    let userString = doc.document.data()["userString"] as! String
                    
                    // getting user Data...
                    
                    fetchUser(uid: userRef.documentID) { (user) in
                        
                        self.MyProjects.append(PostModel(id: doc.document.documentID, title: title, category: category, pic: pic, time: time.dateValue(), user: user, userString: userString))
                        // Sorting All Model..
                        // you can also doi while reading docs...
                        self.MyProjects.sort { (p1, p2) -> Bool in
                            return p1.time > p2.time
                        }
                    }
                }
                
                // removing post when deleted...
                
                if doc.type == .removed{
                    
                    let id = doc.document.documentID
                    
                    self.MyProjects.removeAll { (post) -> Bool in
                        return post.id == id
                    }
                }
                
                if doc.type == .modified{
                    
                    // firebase is firing modifed when a new doc writed
                    // I dont know Why may be its bug...
                    print("Updated...")
                    // Updating Doc...
                    
                    let id = doc.document.documentID
                    let title = doc.document.data()["title"] as! String
                    //let category = doc.document.data()["category"] as! String
                    
                    let index = self.MyProjects.firstIndex { (post) -> Bool in
                        return post.id == id
                    } ?? -1
                    
                    // safe Check...
                    // since we have safe check so no worry
                    
                    if index != -1{
                        
                        self.MyProjects[index].title = title
                        //self.Projects[index].category = category
                        self.updateId = ""
                    }
                }
            }
        }
    }
    
}
