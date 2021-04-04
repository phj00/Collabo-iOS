import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var userString: String
    @StateObject var profileData : ProfileViewModel

    var body: some View {
        //ScrollView {
            VStack {
                HStack{
                    Text("Name: \(profileData.userInfo.username)")
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
            }
      //  }
//        ZStack{
//            WebImage(url: URL(string: "string")!)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 125, height: 125)
//                .clipShape(Circle())
//
//        }
        
//        HStack(spacing: 15){
//
//                    Text("profileData.username")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                }.padding()
//
//                HStack(spacing: 15){
//
//                    Text("profileData.School")
//                        .foregroundColor(.white)
//                }
//                .padding(.horizontal)
//                .padding(.bottom)
//
//                HStack(spacing: 15){
//
//                    Text("profileData.bio")
//                        .foregroundColor(.white)
//                        .italic()
//                }
//                .padding(.horizontal)
//                .padding(.bottom)
//
//                Text("Connect With Me!")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.vertical)
//                    .frame(width: UIScreen.main.bounds.width - 100)
//                    .background(Color("blue"))
//                    .clipShape(Capsule())
                
//                Button(action: profileData.connect, label: {
//                    Text("Connect With Me!")
//                        .foregroundColor(.white)
//                        .fontWeight(.bold)
//                        .padding(.vertical)
//                        .frame(width: UIScreen.main.bounds.width - 100)
//                        .background(Color("blue"))
//                        .clipShape(Capsule())
//                })
//                .padding()
//                .padding(.top,10)
    }
}
