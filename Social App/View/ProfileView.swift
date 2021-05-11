import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ProfileView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = SettingsViewModel()
    @StateObject var postData = PostViewModel()
    @StateObject var profileData : ProfileViewModel
    @StateObject var connectionData : ConnectionsViewModel
    @StateObject var applyData : ApplyViewModel

    @State var userString: String

    var body: some View {
        
        ScrollView{
            VStack{
                HStack{
                    Button(action: {
                        profileData.currentView.toggle();
                        profileData.setUserString(userString: "")
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.title)
                            .foregroundColor(Color("blue"))
                }
                    Text(profileData.userInfo.username)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                }
                .padding()
                .padding(.top,edges!.top)
                // Top Shadow Effect...
                .background(Color("bg"))
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
                ZStack{
                    
                    WebImage(url: URL(string: profileData.userInfo.pic))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                }
                .padding(.top,25)
                
                HStack(spacing: 15){
                    
                    Text("School: " + profileData.userInfo.school)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                
                HStack(spacing: 15){
                    
                    Text(profileData.userInfo.bio)
                        .foregroundColor(.white)
                        .italic()
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                HStack(spacing: 15){
                    Button(action: {connectionData.getAllFollowing(userString: profileData.uid); connectionData.temp.toggle();
                    }, label: {
                        Text("Connections")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(Color("blue"))
                            .clipShape(Capsule())
                            .padding()
                            .padding(.top,10)
                    } )
                }
                
                if (profileData.uid != profileData.userInfo.uid) {
                    Button(action: { if profileData.connectionContains(userString: profileData.userInfo.uid) == false {profileData.connectTo(userString: profileData.userInfo.uid)} else if profileData.connectionContains(userString: profileData.userInfo.uid) == true {profileData.disconnectFrom(userString: profileData.userInfo.uid)}}) {
                        if profileData.connectionContains(userString: profileData.userInfo.uid) == false {

                            Text("Add connection")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 100)
                                .background(Color("blue"))
                                .clipShape(Capsule())
                                .padding(.top,10)
                        } else if profileData.connectionContains(userString: profileData.userInfo.uid) == true {
                            Text("Connected!")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 100)
                                .background(Color("blue"))
                                .clipShape(Capsule())
                                .padding(.top,10)
                        }
                    }
                } else {
                    Button(action: settingsData.logOut, label: {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(Color("blue"))
                            .clipShape(Capsule())
                    })
                    .padding()
                    .padding(.top,10)
                }
                
                VStack{
//                    Auth.auth().currentUser!.uid
                    ScrollView{
                        
                        VStack(spacing: 15){
                            
                            Text(profileData.userInfo.username + "'s posts")
                                .foregroundColor(.white)
                            
                            ForEach(postData.Postings){post in
    
                                if(post.userString == profileData.userInfo.uid){
                                    
                                    PostRow(post: post,postData: postData, profileData: profileData, applyData: applyData)
                                    
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom,55)
                    }
                    
                }
                
                Spacer(minLength: 0)
                
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $connectionData.temp) {
            ConnectionsView(connectionData: connectionData, profileData: profileData)
        }
    }
}
