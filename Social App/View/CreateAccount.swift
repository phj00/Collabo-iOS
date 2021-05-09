import SwiftUI

struct CreateAccount: View {

    @StateObject var createAccountData = CreateAccountViewModel()
    @Binding var isPresented : Bool


    var body: some View {
        VStack{

            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Let's get Started")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width - 60, alignment: .center)
                .multilineTextAlignment(.center)
            
            Text("Start by entering your email and password.")
                .foregroundColor(.black)
                .padding(40)
            
            VStack(alignment: .leading) {
                Text("Email")
                    .padding(.leading, 10.0)
                
                TextField("E-Mail", text: $createAccountData.email)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .foregroundColor(.black)
                    .underlineTextField()
            }
            
            VStack(alignment: .leading) {
                Text("Password (6 or more characters)")
                    .padding(.leading, 10.0)
                SecureField("Set Password", text: $createAccountData.password)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .foregroundColor(.black)
                    .underlineTextField()
            }
            
            Spacer(minLength: 0)
            
            Text("By clicking Agree & Join, you agree to the Collabo")
//            Button(action: {}, label: {
                Text("User Agreement and Privacy Policy.")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .padding(.bottom)
//            })
            
            
            if(createAccountData.error){
                Text(createAccountData.errorMsg)
                    .padding()
                    .foregroundColor(.red)
            }


            if createAccountData.isLoading{
                ProgressView()
                    .padding()
            }
            else{
                Button(action: {
                    createAccountData.createAccount()
                }, label: {
                    Text("Agree & Join")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color("blue"))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                })
                .disabled(createAccountData.email == "" || createAccountData.password == "" ? true : false)
                .opacity(createAccountData.email == "" || createAccountData.password == "" ? 0.5 : 1)
            }


        }
        .background(Color.white.ignoresSafeArea(.all, edges: .all))
        
        .fullScreenCover(isPresented: $createAccountData.registerUser, content: {

            Register(isPresented: $createAccountData.registerUser)
        })
    }
}

struct CreateAccount_Previews: PreviewProvider {
    @StateObject static var createAccountDataP = CreateAccountViewModel()
    static var previews: some View {
        CreateAccount(isPresented: $createAccountDataP.doCreateAccount)
    }
}
