import SwiftUI

struct ContentView: View {
    @AppStorage("current_status") var status = false
//    @State var showSplash = true
    var body: some View {
      ZStack{
        NavigationView{
            
            VStack{
                //Login()
                
                if status{Home()}
                else{Login()}
            }
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
        }
        //Animated Launch/Splash Screen w/ errors
//        SplashView()
//          .opacity(showSplash ? 1 : 0)
//          .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//              withAnimation() {
//                self.showSplash = false
//              }
//            }
//        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color.black.opacity(0.06))
            .padding(10)
    }
}
