import SwiftUI

struct NewPost: View {
    @StateObject var newPostData = NewPostModel()
    @Environment(\.presentationMode) var present
    @Binding var updateId : String
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 15){
                
                Button(action: {
                    self.updateId = ""
                    present.wrappedValue.dismiss()
                    
                }) {
                    
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(Color("blue"))
                }
                
                Spacer(minLength: 0)
                
                if updateId == ""{
                    
                    // Only FOr New Projects....
                    Button(action: {newPostData.picker.toggle()}) {
                        
                        Image(systemName: "photo.fill")
                            .font(.title)
                            .foregroundColor(Color("blue"))
                    }
                }
                
                Button(action: {newPostData.post(updateId: updateId,present: present)}) {
                    
                    Text("Post")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background(Color("blue"))
                        .clipShape(Capsule())
                }
                .disabled(newPostData.postTxt == "" ? true : false)
                .opacity(newPostData.postTxt == "" ? 0.5 : 1)
            }
            .padding()
            .opacity(newPostData.isPosting ? 0.5 : 1)
            .disabled(newPostData.isPosting ? true : false)
            
            Text("     Category:")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            TextEditor(text: $newPostData.postCategory)
                .cornerRadius(15)
                //.background(Color(.clear))
                .padding()
                .opacity(newPostData.isPosting ? 0.5 : 1)
                .disabled(newPostData.isPosting ? true : false)
            
            Text("     Project Title:")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            TextEditor(text: $newPostData.postTxt)
                .cornerRadius(15)
                //.background(Color(.clear))
                .padding()
                .opacity(newPostData.isPosting ? 0.5 : 1)
                .disabled(newPostData.isPosting ? true : false)
            
//            Text("     Positions Wanted:")
//                .font(.caption)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//
//            TextEditor(text: $newPostData.positionWantedTxt)
//                .cornerRadius(15)
//                //.background(Color(.clear))
//                .padding()
//                .opacity(newPostData.isPosting ? 0.5 : 1)
//                .disabled(newPostData.isPosting ? true : false)
            
            
            
            // Dispalying Image if its selected...
            
            if newPostData.img_Data.count != 0{
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    if UIImage(data: newPostData.img_Data)!.size.width>UIImage(data: newPostData.img_Data)!.size.height{
                        Image(uiImage: UIImage(data: newPostData.img_Data)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width / 2)
                            .cornerRadius(15)
                    }else{
                        Image(uiImage: UIImage(data: newPostData.img_Data)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width / 2.5)
                            .cornerRadius(15)
                    }
                    
                    // Cancel Button...
                    
                    Button(action: {newPostData.img_Data = Data(count: 0)}) {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color("blue"))
                            .clipShape(Circle())
                    }
                }
                .padding()
                .opacity(newPostData.isPosting ? 0.5 : 1)
                .disabled(newPostData.isPosting ? true : false)
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $newPostData.picker) {
            
            ImagePicker(picker: $newPostData.picker, img_Data: $newPostData.img_Data)
        }
    }
}
