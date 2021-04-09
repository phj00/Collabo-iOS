import SwiftUI

struct CreateAccount: View {

    @StateObject var createAccountData = CreateAccountViewModel()
    @Binding var isPresented : Bool


    var body: some View {
        VStack{

            HStack{

                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)

                Spacer(minLength: 0)
            }
            .padding()

            TextField("E-Mail", text: $createAccountData.email)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .background(Color.black.opacity(0.06))
                .cornerRadius(15)
                .foregroundColor(.white)

            SecureField("Set Password", text: $createAccountData.password)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.default)
                .background(Color.black.opacity(0.06))
                .cornerRadius(15)
                .foregroundColor(.white)

            .padding()
            .padding(.top,10)

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
                    Text("Next")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("blue"))
                        .clipShape(Capsule())
                })
                .disabled(createAccountData.email == "" || createAccountData.password == "" ? true : false)
                .opacity(createAccountData.email == "" || createAccountData.password == "" ? 0.5 : 1)
            }

            Spacer(minLength: 0)


        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))

        .fullScreenCover(isPresented: $createAccountData.registerUser, content: {

            Register(isPresented: $createAccountData.registerUser)
        })
    }
}

