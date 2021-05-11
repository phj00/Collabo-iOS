import SwiftUI
import Firebase

class ConnectionsViewModel : ObservableObject{
    
    @Published var currentConnections : [ConnectionsModel] = []
    @Published var tempConnections = [String]()
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    @Published var temp = false
    @Published var imageString = ""
    @Published var tempString = ""
    
    func getAllFollowing(userString : String) {
        
        self.currentConnections.removeAll()
        self.tempConnections.removeAll()
        
        ref.collection("Connections").whereField("id", isEqualTo: userString).getDocuments { (snap, err) in
            
            if let err = err {
                // Error fetching documents
                print("Error fetching followers: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let connections = document.data()["connections"] as! [String]
                    
                    self.tempConnections.append(contentsOf: connections)
                    
                    for connection in self.tempConnections {
                        self.ref.collection("Connections").whereField("id", isEqualTo: connection).getDocuments {
                            (snap, err) in
                            
                            if let err = err {
                                
                                print("Error fetching followers: \(err)")
                            } else {
                                for document in snap!.documents {
                                    
                                    let id = document.data()["id"] as! String
                                    let username = document.data()["username"] as! String
                                    let pic = document.data()["pic"] as! String
                                    let connections = document.data()["connections"] as! [String]
                                    
                                    self.currentConnections.append(ConnectionsModel(id: id, username: username, pic: pic, connections: connections))
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    print("Success")
                }
        
            }
        }
    }

    
    func settingsConnections() {
        
        let uid = Auth.auth().currentUser!.uid
        
        self.currentConnections.removeAll()
        
        ref.collection("Connections").whereField("id", isEqualTo: uid).getDocuments { (snap, err) in
            
            if let err = err {
                // Error fetching documents
                print("Error fetching followers: \(err)")
            } else {
                for document in snap!.documents {
                    
                    let connections = document.data()["connections"] as! [String]
                    
                    self.tempConnections.append(contentsOf: connections)
                    
                    for connection in self.tempConnections {
                        self.ref.collection("Connections").whereField("id", isEqualTo: connection).getDocuments {
                            (snap, err) in
                            
                            if let err = err {
                                
                                print("Error fetching followers: \(err)")
                            } else {
                                for document in snap!.documents {
                                    
                                    let id = document.data()["id"] as! String
                                    let username = document.data()["username"] as! String
                                    let pic = document.data()["pic"] as! String
                                    let connections = document.data()["connections"] as! [String]
                                    
                                    self.currentConnections.append(ConnectionsModel(id: id, username: username, pic: pic, connections: connections))
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    print("Success")
                }
        
            }
        }
    }
    
    func setUser(userString : String) {
        
        self.tempString = userString
    }
}
