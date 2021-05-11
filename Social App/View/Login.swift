import SwiftUI

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    @StateObject var createAccountData = CreateAccountViewModel()
    
    var body: some View {
        VStack{
//            Logo?
//            ZStack{
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width: 150, height: 150)
//                    .padding(.top, 40)
//                Text("App Logo")
//                    .foregroundColor(Color.white)
//            }
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Welcome to Collabo")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 60, alignment: .center)
                .multilineTextAlignment(.center)
                
            Text("Sign into your existing account.")
                .foregroundColor(.black)
                .padding(40)
          
            TextField("E-Mail", text: $loginData.email)
                .frame(width: UIScreen.main.bounds.width - 40)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .foregroundColor(.black)
                .underlineTextField()
            
            SecureField("Password", text: $loginData.password)
                .frame(width: UIScreen.main.bounds.width - 40)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.default)
                .foregroundColor(.black)
                .underlineTextField()
            
            if(loginData.emailNotRegistered){
                Text("Error: Please check your e-mail and password.")
                    .padding()
                    .foregroundColor(.red)
            }
            
            
            if loginData.isLoading{
                ProgressView()
                    .padding()
            }
            else{
                Button(action: loginData.logIn, label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color("blue"))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                })
                .disabled(loginData.email == "" || loginData.password == "" ? true : false)
            }
            
            Spacer(minLength: 0)
            
            Text("Don't have an account yet?")
                .foregroundColor(.black)
            
            Button(action: createAccountData.createNewAccount, label: {
                Text("Create an account here")
                    .foregroundColor(.blue)
                    .italic()
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.white)
                    .clipShape(Capsule())
            })
            
            
        }
        .background(Color.white.ignoresSafeArea(.all, edges: .all))
        
        .fullScreenCover(isPresented: $createAccountData.doCreateAccount, content: {
            
            CreateAccount(isPresented: $createAccountData.doCreateAccount)

        })

    }
    
    func toggleDoCreateAccount() {
        
        createAccountData.doCreateAccount = false
        
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}


