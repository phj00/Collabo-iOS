import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SettingsView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingsData = SettingsViewModel()
    @StateObject var postData = PostViewModel()
    @StateObject var profileData = ProfileViewModel()
    @StateObject var applyData = ApplyViewModel()
    @StateObject var connectionData = ConnectionsViewModel()
    var body: some View {
        
        ScrollView{
            VStack{
                HStack{
                    
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {connectionData.settingsConnections();
                            connectionData.temp.toggle()
                    }) {
                        
                        Image(systemName: "person.2.circle")
                            .font(.title)
                            .foregroundColor(Color("blue"))
                        
                    }
                    
                }
                .padding()
                .padding(.top,edges!.top)
                // Top Shadow Effect...
                .background(Color("bg"))
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
                
                if settingsData.userInfo.pic != ""{
                    
                    ZStack{
                        
                        WebImage(url: URL(string: settingsData.userInfo.pic)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                        
                        if settingsData.isLoading{
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("blue")))
                        }
                    }
                    .padding(.top,25)
                    .onTapGesture {
                        settingsData.picker.toggle()
                    }
                }
                
                HStack(spacing: 15){
                    
                    Text(settingsData.userInfo.username)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Edit Button...
                    
                    Button(action: {settingsData.updateDetails(field: "Name")}) {
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                
                HStack(spacing: 15){
                    
                    Text("School: " + settingsData.userInfo.school)
                        .foregroundColor(.white)
                    
                    // Edit Button...
                    
                    Button(action: {settingsData.updateDetails(field: "School")}) {
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                
                HStack(spacing: 15){
                    
                    Text(settingsData.userInfo.bio)
                        .foregroundColor(.white)
                        .italic()
                    
                    // Edit Button...
                    
                    Button(action: {settingsData.updateDetails(field: "Bio")}) {
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                // LogOut Button...
                
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
                
                VStack{
                    
                    ScrollView{
                        
                        VStack(spacing: 15){
                            
                            ForEach(postData.Postings){post in

    
                                if(post.userString == Auth.auth().currentUser!.uid){
                                    
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
            EmptyView().fullScreenCover(isPresented: $connectionData.temp) {
                ConnectionsView(connectionData: connectionData, profileData: profileData, applyData: applyData)
            }
            EmptyView().fullScreenCover(isPresented: $profileData.currentView) {
                
                ProfileView(profileData: profileData, connectionData: connectionData, applyData: applyData, userString : profileData.tempUserString)
                
            }
            .sheet(isPresented: $settingsData.picker) {
                
                ImagePicker(picker: $settingsData.picker, img_Data: $settingsData.img_data)
            }
            .onChange(of: settingsData.img_data) { (newData) in
                // whenever image is selected update image in Firebase...
                settingsData.updateImage()
            }
        }
    }
    
}
