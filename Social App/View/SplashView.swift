import SwiftUI

struct SplashView : View {
    
    @State var show = false
    
    var body : some View{
        
        ZStack{
            
            Color.white.edgesIgnoringSafeArea(.all)
            
          ZStack(){
            
            //Static Collabo text
              VStack(alignment: .leading, spacing: 10){
                Text("Collabo")
                    .foregroundColor(Color.black.opacity(0.4))
                    .font(.system(size: 40))
                
                Text("Made By Students,\nFor Students")
                    .foregroundColor(Color.black.opacity(0.4))
                    .font(.system(size: 25))
              }
            
            // Animated Collabo text
              VStack(alignment: .leading, spacing: 10){
                Text("Collabo")
                    .foregroundColor(.black)
                    .font(.system(size: 40))
                    .mask(
                        Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30))
                        .offset(x: self.show ? 180 : -130)
                        
                    )
                Text("Made By Students,\nFor Students")
                    .foregroundColor(.black)
                    .font(.system(size: 25))
                    .mask(
                        Capsule()
                        .fill(LinearGradient(gradient: .init(colors: [.clear,.black,.clear]), startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.init(degrees: 30))
                        .offset(x: self.show ? 180 : -130)
                        
                    )
              }
            }
        }
        .frame(width: .infinity, height: .infinity, alignment: .topLeading)
        .onAppear {
            
            withAnimation(Animation.default.speed(0.15).delay(0).repeatForever(autoreverses: false)){
                
                self.show.toggle()
            }
        }
    }
}

