//
//  ApplicationsViewModel.swift
//  Social App
//
//  Created by Ryan Koo on 2/9/21.
//

import SwiftUI
import Firebase

class ApplicationsViewModel : ObservableObject{
    
    @Published var IncomingApplications : [ApplicationModel] = []
    
    let ref = Firestore.firestore()
    
    init() {
        
        getAllIncomingApplications()
    }
    
    func getAllIncomingApplications() {
        
        let uid = Auth.auth().currentUser!.uid
        
        ref.collection("Applications").whereField("recipient", isEqualTo: uid).getDocuments { (snap, err) in
            
            if let err = err {
                // Error fetching documents
                print("Error fetching incoming applications: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let applicantID = document.data()["applicant"] as! String
                    let recepientID = document.data()["recipient"] as! String
                    let applicationMessage = document.data()["applicationMessage"] as! String
                    let postID = document.data()["postId"] as! String
                    
                    self.IncomingApplications.append(ApplicationModel(id: document.documentID, applicantID: applicantID, recipientID: recepientID, applicationMessage: applicationMessage, postID: postID))
                    
                    print("Success")
                    
                    // Sort (need to add application submission time as a field value (as! Timestamp)
//                    self.Applications.sort { (p1, p2) -> Bool in
//                        return p1.time > p2.time
//                    }
                    
                }
            }
            
        }
        
    }
}


