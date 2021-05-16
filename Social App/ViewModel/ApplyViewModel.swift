//
//  ApplyViewModel.swift
//  Social App
//
//  Created by Ryan Koo on 4/18/21.
//

import Foundation
import Firebase

class ApplyViewModel : ObservableObject{
    
    let uid = Auth.auth().currentUser!.uid
    
    @Published var currentView = false
    @Published var postId = ""
    @Published var position = ""
    @Published var applicationMessage = ""
    
    func setPostId(postId : String) {
        self.postId = postId
    }
    
    func setPostPosition(title : String) {
        self.position = title
    }
    
    func setApplicationMessage(message : String) {
        self.applicationMessage = message
    }
    
    func applyTo(postId: String){
        
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid

        ref.collection("Postings").document(postId).updateData([
            "appliedBy": FieldValue.arrayUnion([uid])
        ])

        ref.collection("Users").document(uid).updateData([
            "appliedTo": FieldValue.arrayUnion([postId])
        ])
        
        let dataRef = ref.collection("Applications").document()
        let applicationUid = dataRef.documentID
        
        self.getApplicantName() {

            (property) in
            if let property = property {
                dataRef.setData([
                    "applicantUid": uid,
                    "applicantName": property,
                    "postId": postId,
                    "applicationMessage": self.applicationMessage
                ])
            } else {
                print("Error")
            }
        }
        
        self.getUserString(postId: postId) {
            (property) in
            if let property = property {
                ref.collection("Applications").document(applicationUid).setData(["recepientUid": property], merge: true)
            }
        }
        
        self.getApplicantPhoto() {
            (property) in
            if let property = property {
                ref.collection("Applications").document(applicationUid).setData(["applicantPhoto": property], merge: true)
            }
        }
        
        self.getPositionApplied(postId: postId) {
            (property) in
            if let property = property {
                ref.collection("Applications").document(applicationUid).setData(["positionApplied": property], merge: true)
            }
        }
        
//        self.setApplicationMessage(message: "")
        
    }
    
    func withdrawApplication(postId: String){
        
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Users").document(uid).updateData([
            "appliedTo": FieldValue.arrayRemove([postId])
        ])
        
        ref.collection("Postings").document(postId).updateData([
            "appliedBy": FieldValue.arrayRemove([uid])
        ])
        
        ref.collection("Applications").whereField("postId", isEqualTo: postId).getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in QuerySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }

    }
    
    func getUserString(postId: String, completion: @escaping (String?) -> Void) {
        
        ref.collection("Postings").document(postId).getDocument { (document, error) in
            if let document = document, document.exists {
                let property = document.get("userString") as! String
                completion(property)
            } else {
                print("Document does not exist.")
                completion(nil)
            }
        }
    }
    
    func getApplicantName(completion: @escaping (String?) -> Void) {
        
        ref.collection("Users").document(uid).getDocument { (document, error) in
            
            if let document = document, document.exists {
                let property = document.get("username") as! String
                completion(property)
            } else {
                print("Document does not exist.")
                completion(nil)
            }
            
        }
        
    }
    
    func getApplicantPhoto(completion: @escaping (String?) -> Void) {
        
        let temp = ref.collection("Users").document(uid)

        temp.getDocument { (document, error) in
            
            if let document = document, document.exists {
                let property = document.get("imageurl") as! String
                completion(property)
            } else {
                print("Document does not exist.")
                completion(nil)
            }
            
        }
    }
    
    func getPositionApplied(postId: String, completion: @escaping (String?) -> Void) {

        ref.collection("Postings").document(postId).getDocument { (document, error) in
            if let document = document, document.exists {
                let property = document.get("title") as! String
                completion(property)
            } else {
                print("Document does not exist.")
                completion(nil)
            }
        }
    }
    
}
