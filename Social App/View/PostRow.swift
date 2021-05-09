import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PostRow: View {
    
    var post : PostModel
    @ObservedObject var postData : PostViewModel
    @ObservedObject var profileData : ProfileViewModel
    @ObservedObject var applyData: ApplyViewModel
    let uid = Auth.auth().currentUser!.uid
    
    @State var showAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
//<<<<<<< HEAD
//            HStack(spacing: 10){
//
//                Text(post.title)
//                    .font(.system(size: 24))
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//
//                if postData.appliedContains(id: post.id) == false {
//                    Button(action: {applyData.currentView.toggle(); applyData.setPostId(postId: post.id); applyData.setPostPosition(title: post.title)}) {
//                        Text("Apply")
//                            .font(.caption)
//                            .font(.system(size: 16))
//                            .fontWeight(.bold)
//                    }
//                } else if postData.appliedContains(id: post.id) == true {
//                    Button(action: {self.showAlert.toggle()}){
//                        Text("Withdraw")
//                            .font(.caption)
//                            .font(.system(size: 16))
//                            .fontWeight(.bold)
//                    }
//                    .alert(isPresented: self.$showAlert) {
//                        Alert(title: Text("Withdraw Application"), message: Text("Are you sure you wish to withdraw this application?"), primaryButton: .default(Text("Withdraw"), action: {
//                            postData.withdrawApplication(postId: post.id)
//                        }), secondaryButton: .default(Text("Cancel")))
//                    }
//                }
//
//                Spacer(minLength: 0)
//
//                // displaying only posted user...
//
//                if post.user.uid == uid{
//=======
            ZStack{
                HStack{
                    Divider()
                }
                
                HStack(spacing: 10){
       // head
                    VStack(alignment: .leading){
                        Text(post.title)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        
                        //Need to pull out compant name here
                        Text(post.title)
                        .font(.caption)
                        .foregroundColor(.black)
                    }
//>>>>>>> main
                    
    //                Button(action: { if postData.appliedContains(id: post.id) == false {postData.applyTo(postId: post.id)} else if postData.appliedContains(id: post.id) == true {postData.withdrawApplication(postId: post.id)}}) {
    //                    if postData.appliedContains(id: post.id) == false {
    //
    //                        Text("Apply")
    //                            .font(.caption)
    //                            .font(.system(size: 16))
    //                            .fontWeight(.bold)
    //                    } else if postData.appliedContains(id: post.id) == true {
    //                        Text("Withdraw")
    //                            .font(.caption)
    //                            .font(.system(size: 16))
    //                            .fontWeight(.bold)
    //                    }
    //                }
                    
                    
                    Spacer(minLength: 150)
                    
                    
                    if postData.appliedContains(id: post.id) == false {
                        Button(action: {applyData.currentView.toggle(); applyData.setPostId(postId: post.id); applyData.setPostPosition(title: post.title)}) {
                            Text("Apply")
                                .font(.caption)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color("blue"))
    //                            .background(Color("blue"))
                                .cornerRadius(20)
                        }
                        .buttonStyle(PlainButtonStyle())
                    } else if postData.appliedContains(id: post.id) == true {
                        Button(action: {self.showAlert.toggle()}){
                            Text("Withdraw")
                                .font(.caption)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(Color("blue"))
    //                            .background(Color("blue"))
                                .cornerRadius(20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .alert(isPresented: self.$showAlert) {
                            Alert(title: Text("Withdraw Application"), message: Text("Are you sure you wish to withdraw this application?"), primaryButton: .default(Text("Withdraw"), action: {
                                postData.withdrawApplication(postId: post.id)
                            }), secondaryButton: .default(Text("Cancel")))
                        }
                    }
                    
                    
                    if post.user.uid == uid{
                        
                        Menu(content: {
                            
                            Button(action: {postData.editPost(id: post.id)}) {

                                Text("Edit")
                            }
                            
                            Button(action: {postData.deletePost(id: post.id)}) {
                                
                                Text("Delete")
                            }
                            
                            
                        }, label: {
                            
                            Image("menu")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                        })
                    }
                }
            }
            .frame(minHeight: 0,
                   maxHeight: 20)
            .padding(.vertical, 10)
            
//            HStack(spacing: 10){
//
//                Text(post.user.company)
//                    .fontWeight(.bold)
//                    .font(.system(size: 18))
//                    .foregroundColor(.white)
//
//            }
            
//            HStack(spacing: 10){
//
//                WebImage(url: URL(string: post.user.pic)!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//
//                //first toggle, then checkuser, then display user
//
//                Button(action: {
//                    profileData.currentView.toggle();
//                    profileData.showProf(userString: post.userString)
//                    profileData.setUserString(userString: post.userString)
//                }, label: {
//                    Text(post.user.username)
//                        .foregroundColor(.black)
//                        .fontWeight(.bold)
//                })
//
//            }
//
            if post.pic != ""  {
                
                WebImage(url: URL(string: post.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 325)
                    .cornerRadius(15)
                    .padding(.bottom,5)
            }
            
            HStack{

//                if post.pic != ""{
//                    Text(post.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .frame(maxHeight: 175)
//                        .lineLimit(7)
//                        .fixedSize(horizontal: false, vertical: true)
//
//                }else{
//                    Text(post.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .frame(maxHeight: 200)
//                        .lineLimit(10)
//                        .fixedSize(horizontal: false, vertical: true)
//
//                }


                
                Spacer(minLength: 0)
            }
            .padding(.vertical, 5)
            
            HStack{
                
                // 12.25 Programmable button feature
                
                // && post.id == 
                
                VStack(alignment: .leading){
                    
                    Text(post.time,style: .date)
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                    
                    Text(post.user.username)
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    
                }
                
                Spacer(minLength: 100)
                
                Button(action: { if postData.savedContains(id: post.id) == false {postData.savePost(id: post.id)} else if postData.savedContains(id: post.id) == true {postData.unsavePost(id: post.id)}}) {
                    if postData.savedContains(id: post.id) == false {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(.black)
                    } else if postData.savedContains(id: post.id) == true {
                        Image(systemName: "bookmark.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                
            }
            .frame(minHeight: 0,
                   maxHeight: 10)
            .padding(.vertical, 5)
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
    
}

