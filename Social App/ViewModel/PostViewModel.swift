import SwiftUI
import Firebase

class PostViewModel : ObservableObject{
    
    @Published var Projects : [PostModel] = []
    @Published var noProjects = false
    @Published var newPost = false
    @Published var updateId = ""
    
    init() {
        
        getAllProjects()
    }
    
    func getAllProjects(){
        
        ref.collection("Projects").addSnapshotListener { (snap, err) in
            guard let docs = snap else{
                self.noProjects = true
                return
                
            }
            
            if docs.documentChanges.isEmpty{
                
                self.noProjects = true
                return
            }
            
            docs.documentChanges.forEach { (doc) in
                
                // Checking If Doc Added...
                if doc.type == .added{
                    
                    // Retreving And Appending...
                    
                    let title = doc.document.data()["title"] as! String
                    let category = doc.document.data()["category"] as! String
                    let time = doc.document.data()["time"] as! Timestamp
                    let pic = doc.document.data()["url"] as! String
                    let userRef = doc.document.data()["ref"] as! DocumentReference
                    
                    // getting user Data...
                    
                    fetchUser(uid: userRef.documentID) { (user) in
                        
                        self.Projects.append(PostModel(id: doc.document.documentID, title: title, category: category, pic: pic, time: time.dateValue(), user: user))
                        // Sorting All Model..
                        // you can also doi while reading docs...
                        self.Projects.sort { (p1, p2) -> Bool in
                            return p1.time > p2.time
                        }
                    }
                }
                
                // removing post when deleted...
                
                if doc.type == .removed{
                    
                    let id = doc.document.documentID
                    
                    self.Projects.removeAll { (post) -> Bool in
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
                    
                    let index = self.Projects.firstIndex { (post) -> Bool in
                        return post.id == id
                    } ?? -1
                    
                    // safe Check...
                    // since we have safe check so no worry
                    
                    if index != -1{
                        
                        self.Projects[index].title = title
                        //self.Projects[index].category = category
                        self.updateId = ""
                    }
                }
            }
        }
    }
    
    // deleting Projects...
    
    func deletePost(id: String){
        
        ref.collection("Projects").document(id).delete { (err) in
            if err != nil{
                print(err!.localizedDescription)
                return
            }
        }
    }
    
    func editPost(id: String){
        
        updateId = id
        // Poping New Post Screen
        newPost.toggle()
    }
    
    // 12.04. Save Post
    
    func savePost(id: String){
        
        let uid = Auth.auth().currentUser!.uid
        var group_array = [String]()
        
        // Retriving saved posts
        
        Firestore.firestore().collection("Users").document(uid).getDocument {
            (document, error) in
            if let document = document {
                group_array = document["savedPosts"] as? Array ?? [""]
                print(group_array)
            }
        }
        
        let temp = ref.collection("Users").document(uid)

        // Atomically add a new region to the "regions" array field.
        temp.updateData([
            "savedPosts": FieldValue.arrayUnion([id])
        ])
        
        
        
    }
}
