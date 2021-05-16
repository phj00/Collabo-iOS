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
    @Published var OutgoingApplications : [ApplicationModel] = []
    
    let ref = Firestore.firestore()
    
    init() {
        
        getAllIncomingApplications()
        getAllOutgoingApplications()
    }
    
    func getAllIncomingApplications() {
        
        let uid = Auth.auth().currentUser!.uid
        
        self.IncomingApplications.removeAll()
        
        ref.collection("Applications").whereField("recepientUid", isEqualTo: uid).getDocuments { (snap, err) in
            
            if let err = err {
                // Error fetching documents
                print("Error fetching incoming applications: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let applicantID = document.data()["applicantUid"] as! String
                    let recepientID = document.data()["recepientUid"] as! String
                    let applicantUserName = document.data()["applicantName"] as! String
                    let applicationMessage = document.data()["applicationMessage"] as! String
                    let postID = document.data()["postId"] as! String
                    let applicantPhoto = document.data()["applicantPhoto"] as! String
                    let positionApplied = document.data()["positionApplied"] as! String
                    
                    self.IncomingApplications.append(ApplicationModel(id: document.documentID, applicantID: applicantID, recipientID: recepientID, applicantUserName: applicantUserName, applicationMessage: applicationMessage, postID: postID, applicantPhoto: applicantPhoto, positionApplied: positionApplied))
                    
                    print("Success")
                    
                    // Sort (need to add application submission time as a field value (as! Timestamp)
//                    self.Applications.sort { (p1, p2) -> Bool in
//                        return p1.time > p2.time
//                    }
                    
                }
            }
            
        }
        
    }
    
    func getAllOutgoingApplications() {
        
        let uid = Auth.auth().currentUser!.uid
        
        self.OutgoingApplications.removeAll()
        
        ref.collection("Applications").whereField("applicantUid", isEqualTo: uid).getDocuments { (snap,err) in
            
            if let err = err {
                print("Error fetching incoming applications: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let applicantID = document.data()["applicantUid"] as! String
                    let recepientID = document.data()["recepientUid"] as! String
                    let applicantUserName = document.data()["applicantName"] as! String
                    let applicationMessage = document.data()["applicationMessage"] as! String
                    let postID = document.data()["postId"] as! String
                    let applicantPhoto = document.data()["applicantPhoto"] as! String
                    let positionApplied = document.data()["positionApplied"] as! String
                    
                    self.OutgoingApplications.append(ApplicationModel(id: document.documentID, applicantID: applicantID, recipientID: recepientID, applicantUserName: applicantUserName, applicationMessage: applicationMessage, postID: postID, applicantPhoto: applicantPhoto, positionApplied: positionApplied))
           
                }
            
            }
            
        }
        
    }
}


