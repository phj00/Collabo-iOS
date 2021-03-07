import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PostRow: View {
    
    var post : PostModel
    @ObservedObject var postData : PostViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            HStack(spacing: 10){
                
                
                
                
                Text(post.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                
                
                
                
                
                Button(action: { if postData.appliedStatus == false {postData.applyTo(postId: post.id)} else if postData.appliedStatus == true {postData.unapply(postId: post.id)}}) {
                    if postData.appliedStatus == false {
                        Text("Apply")
                            .font(.caption)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                    } else if postData.appliedStatus == true {
                        Text("Un-Apply")
                            .font(.caption)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                    }
                }
                
                Spacer(minLength: 0)
                
                
                
                // displaying only posted user...
                
                if post.user.uid == uid{
                    
                    Menu(content: {
                        
                        Button(action: {postData.editPost(id: post.id)}) {
                            
                            Text("Edit")
                        }
                        
                        Button(action: {postData.deletePost(id: post.id)}) {
                            
                            Text("Delete")
                        }
                        
//                        Button(action: {postData.getReachOut(id: post.id)}) {
//
//                            Text("List of Reach out's")
//
//                        }
                        
                    }, label: {
                        
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    })
                }
            }
            
            HStack(spacing: 10){
                
                WebImage(url: URL(string: post.user.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                
                Text(post.user.username)
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                
            }
            
            if post.pic != ""{
                
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
                
                Button(action: { if postData.savedContains(id: post.id) == false {postData.savePost(id: post.id)} else if postData.savedContains(id: post.id) == true {postData.unsavePost(id: post.id)}}) {
                    if postData.savedContains(id: post.id) == false {
                        Image(systemName: "bookmark")
                            .font(.title)
                            .foregroundColor(.white)
                    } else if postData.savedContains(id: post.id) == true {
                        Image(systemName: "bookmark.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer(minLength: 100)
                
                VStack(alignment: .trailing){
                    
                    Text(post.time,style: .time)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Text(post.category)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    
                }
                
            }
            .padding(.vertical, 5)
            
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
    }
    
}

