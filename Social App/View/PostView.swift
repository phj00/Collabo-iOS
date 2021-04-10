import SwiftUI

struct PostView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var postData = PostViewModel()
    @StateObject var profileData = ProfileViewModel()
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("Postings")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
                Button(action: {postData.newPost.toggle()}) {
                    
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                        .foregroundColor(Color("blue"))
                }
            }
            .padding()
            .padding(.top,edges!.top)
            // Top Shadow Effect...
            .background(Color("bg"))
            .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            
            if postData.Postings.isEmpty{
                
                Spacer(minLength: 0)
                
                if postData.noPostings{
                    
                    Text("No Posts to View")
                }
                else{
                    
                    Text("No Posts to View")
                }
                
                Spacer(minLength: 0)
            }
            else{
                
                ScrollView{
                    
                    VStack(spacing: 15){
                        
                        ForEach(postData.Postings){post in
                            
                            PostRow(post: post,postData: postData, profileData: profileData)
                        }
                    }
                    .padding()
                    .padding(.bottom,55)
                }
            }
        }
        .fullScreenCover(isPresented: $postData.newPost) {
            
            NewPost(updateId : $postData.updateId)
        }
        .fullScreenCover(isPresented: $profileData.currentView) {
            
            ProfileView(userString : profileData.tempUserString, profileData: profileData)
            
        }
    }
}

