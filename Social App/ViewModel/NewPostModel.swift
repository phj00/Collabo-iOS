import SwiftUI
import Firebase

class NewPostModel : ObservableObject{
    
    @Published var postTxt = ""
    @Published var postCategory = ""
    @Published var positionWantedTxt = ""
    // Image Picker...
    @Published var picker = false
    @Published var img_Data = Data(count: 0)
    
    // disabling all controls while posting...
    @Published var isPosting = false
    @Published var applied_by = [String]()
    
    let uid = Auth.auth().currentUser!.uid
    
    func post(updateId: String,present : Binding<PresentationMode>){
        
        // posting Data...
        
        isPosting = true
        
        if updateId != ""{
            
            // Updating Data...
            
            ref.collection("Projects").document(updateId).updateData([
            
                "title": postTxt,
                "category": postCategory
            ]) { (err) in
                
                self.isPosting = false
                if err != nil{return}
                
                present.wrappedValue.dismiss()
            }
            
            return
        }
        
        if img_Data.count == 0{
            
            ref.collection("Projects").document().setData([
                
                "title": self.postTxt,
                "category": self.postCategory,
                "url": "",
                "ref": ref.collection("Users").document(self.uid),
                "time": Date(),
                "userString": uid,
                "appliedBy": [String]()
//                "positionWanted": self.positionWantedTxt

                
            ]) { (err) in
                
                if err != nil{
                    self.isPosting = false
                    return
                }
                
                self.isPosting = false
                
                
                // closing View When Succssfuly Posted...
                present.wrappedValue.dismiss()
            }
            
        }
        else{
            
            UploadImage(imageData: img_Data, path: "post_Pics") { (url) in
                
                ref.collection("Projects").document().setData([
                    
                    "title": self.postTxt,
                    "category": self.postCategory,
                    "url": url,
                    "ref": ref.collection("Users").document(self.uid),
                    "time": Date(),
                    "userString": self.uid,
                    "appliedBy": [String]()
//                    "positionWanted": self.positionWantedTxt
                    
                    
                ]) { (err) in
                    
                    if err != nil{
                        self.isPosting = false
                        return
                    }
                    
                    self.isPosting = false
                    // closing View When Succssfuly Posted...
                    present.wrappedValue.dismiss()
                }
            }
        }
    }
}
