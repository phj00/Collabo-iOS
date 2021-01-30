import SwiftUI
import Firebase

class PostViewModel : ObservableObject{
    
    @Published var Projects : [PostModel] = []
    @Published var noProjects = false
    @Published var newPost = false
    @Published var updateId = ""
    @Published var savedStatus = false
    @Published var appliedStatus = false
    @Published var group_array = [String]()
    @Published var applied_by = [String]()
    @Published var uid = Auth.auth().currentUser!.uid

    
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
                    let userString = doc.document.data()["userString"] as! String
                    let appliedBy = doc.document.data()["appliedBy"] as! Array<String>
                    
                    // getting user Data...
                    
                    fetchUser(uid: userRef.documentID) { (user) in
                        
                        self.Projects.append(PostModel(id: doc.document.documentID, title: title, category: category, pic: pic, time: time.dateValue(), user: user, userString: userString, appliedBy: appliedBy))
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
        
        // 12.28: Deletes instance of postid from every user's savedPosts array.
        ref.collection("Users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                // Some error occured
                print(err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    document.reference.updateData([
                        "savedPosts": FieldValue.arrayRemove([id])
                    ])
                }
            }
        }
        
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
    
    // 12.24. Save Post
    
    func savePost(id: String){
        
        let uid = Auth.auth().currentUser!.uid
        let temp = ref.collection("Users").document(uid)

        // Atomically add a new region to the "regions" array field.
        temp.updateData([
            "savedPosts": FieldValue.arrayUnion([id])
        ])
        
        savedStatus = !savedStatus
        
    }
    
    // 12.25 Un-Save Post
    
    func unsavePost(id: String){
        
        let uid = Auth.auth().currentUser!.uid
        let temp = ref.collection("Users").document(uid)

        temp.updateData([
            "savedPosts": FieldValue.arrayRemove([id])
        ])
        
        savedStatus = !savedStatus
        
    }
    
    func savedContains(id: String) -> Bool {
        
        let uid = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("Users").document(uid).getDocument {
            (document, error) in
            if let document = document {
                self.group_array = document["savedPosts"] as? Array ?? [""]
            }
        }
        
        if self.group_array.contains(id) {
            return true
        } else {
            return false
        }
        
    }
    
    func getSaved() -> Array<String> {
        
        let uid = Auth.auth().currentUser!.uid
        
        Firestore.firestore().collection("Users").document(uid).getDocument {
            (document, error) in
            if let document = document {
                self.group_array = document["savedPosts"] as? Array ?? [""]
            }
        }
        return self.group_array
    }
    
    func applyTo(postId: String){
        
        let uid = Auth.auth().currentUser!.uid
        let temp = ref.collection("Projects").document(postId)
        
        let defaultApplicationMessage = "Hi, my name is ____ and I would like to talk with you more about your project."

        temp.updateData([
            "appliedBy": FieldValue.arrayUnion([uid])
        ])
        
        appliedStatus = !appliedStatus
        
        self.getUserString(postId: postId) {
            (property) in
            if let property = property {
                ref.collection("Applications").document().setData([
                    "applicant": uid,
                    "recipient": property,
                    "postId": postId,
                    "applicationMessage": defaultApplicationMessage
                ])
            } else {
                print("Error")
            }
        }
        
        
    }
    
    func unapply(postId: String){
        
        let uid = Auth.auth().currentUser!.uid
        let temp = ref.collection("Projects").document(postId)
        
        temp.updateData([
            "appliedBy": FieldValue.arrayRemove([uid])
        ])
        
        appliedStatus = !appliedStatus
     
    }
    
    func getUserString(postId: String, completion: @escaping (String?) -> Void) {
    
        let temp = ref.collection("Projects").document(postId)
        
        temp.getDocument { (document, error) in
            if let document = document, document.exists {
                let property = document.get("userString") as! String
                completion(property)
            } else {
                print("Document does not exist.")
                completion(nil)
            }
        }
    }
    
}
