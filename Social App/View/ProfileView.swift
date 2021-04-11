import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var userString: String
    @StateObject var profileData : ProfileViewModel

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
                
                // Connect Button...
                Text("Connect With Me!")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("blue"))
                    .clipShape(Capsule())
                .padding()
                .padding(.top,10)
                
                Spacer(minLength: 0)
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
    }
}
