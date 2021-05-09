import SwiftUI

struct Register: View {
    
    @StateObject var registerData = RegisterViewModel()
    @Binding var isPresented : Bool
    
    var body: some View {
        VStack{
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Complete Your Account")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 60, alignment: .center)
                .multilineTextAlignment(.center)
            
            ZStack{
                
                if registerData.image_Data.count == 0{
                    
                    Image(systemName: "person")
                        .font(.system(size: 65))
                        .foregroundColor(.black)
                        .frame(width: 115, height: 115)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                else{
                    
                    Image(uiImage: UIImage(data: registerData.image_Data)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 115, height: 115)
                        .clipShape(Circle())
                }
                
            }
            .padding(.top)
            .onTapGesture(perform: {
                registerData.picker.toggle()
            })
            
            VStack(alignment: .leading, spacing: 0.0) {
                Text("Full Name")
                    .foregroundColor(Color.black)
                    .padding(.leading, 10.0)
                TextField("", text: $registerData.name)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .foregroundColor(.black)
                    .underlineTextField()
            }
            
            VStack(alignment: .leading) {
                Text("School/Institution")
                    .foregroundColor(Color.black)
                    .padding(.leading, 10.0)
                TextField("", text: $registerData.school)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .underlineTextField()
            }
            
            VStack(alignment: .leading) {
                Text("Bio")
                    .foregroundColor(Color.black)
                    .padding(.leading, 10.0)
                TextField("", text: $registerData.bio)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
                    .underlineTextField()
            }
            
            if registerData.isLoading{
                
                ProgressView()
                    .padding()
            }
            else{
                
                Button(action: {
                    registerData.register()
                    isPresented = false
                }, label: {
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color("blue"))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                })
                .disabled(
                    //registerData.image_Data.count == 0 ||
                    registerData.name == "" || registerData.bio == "" ? true : false)
                .opacity(
                    //registerData.image_Data.count == 0 ||
                      registerData.name == "" || registerData.bio == "" ? 0.5 : 1)
            }
            
            Spacer(minLength: 0)
        }
        .background(Color.white)
        .sheet(isPresented: $registerData.picker, content: {
            ImagePicker(picker: $registerData.picker, img_Data: $registerData.image_Data)
        })
        .sheet(isPresented: $registerData.isRegistered, content: {
            Home()
        })
        .preferredColorScheme(.dark)
    }
}

struct Register_Previews: PreviewProvider {
    @StateObject static var createAccountDataP = CreateAccountViewModel()
    static var previews: some View {
        Register(isPresented: $createAccountDataP.registerUser)
    }
}
