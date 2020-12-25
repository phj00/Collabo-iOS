import SwiftUI
import SDWebImageSwiftUI
import Firebase

let savedStatus = false

struct PostRow: View {
    
    var post : PostModel
    @ObservedObject var postData : PostViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(spacing: 15){
            
            HStack(spacing: 10){
                
                WebImage(url: URL(string: post.user.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(post.user.username)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
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
                        
                    }, label: {
                        
                        Image("menu")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    })
                }
            }
            
            if post.pic != ""{
                
                WebImage(url: URL(string: post.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 250)
                    .cornerRadius(15)
            }
            
            HStack{
                
                Text(post.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            .padding(.top,5)
            
            HStack{
                
                // 12.25 Programmable button feature
                
                Button(action: { if postData.savedStatus == false {postData.savePost(id: post.id)} else {postData.unsavePost(id: post.id)}}) {
                    if postData.savedStatus == false {
                        Image(systemName: "square.and.arrow.down")
                            .font(.title)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "square.and.arrow.down.fill")
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
            .padding(.top,5)
            
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
    }
    
}

