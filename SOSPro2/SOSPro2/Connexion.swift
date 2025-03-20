//
//  Connexion.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 15/03/2025.
//

import SwiftUI
import MapKit

//var loggedUser = userDefault
var infoChecker:Bool = false

var accentGradient : LinearGradient = LinearGradient(colors: [.gray,.accent], startPoint: .topLeading, endPoint: .bottomTrailing)

struct LoginCompte: View {
    @Binding var loggedUser : User
    
    @State var mail: String = ""
    @State var password: String = ""
    
    @State var showPassword: Bool = false
    @State var errorText = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(spacing:80) {
            Text("Connexion").font(.largeTitle).fontWeight(.bold).foregroundStyle(accentGradient)
            Image(systemName:"person.circle.fill").resizable().frame(width:130,height:130).foregroundStyle(accentGradient)
            VStack(spacing:15){
                TextField("Mail",text: $mail, prompt:Text("Votre adresse mail :").foregroundStyle(accentGradient))
                    .padding(10)
                    .textInputAutocapitalization(.never).disableAutocorrection(true)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.accent, lineWidth: 2)
                    }.padding(.horizontal)
                HStack {
                    if showPassword {
                        TextField("Password",text: $password, prompt: Text("Mot de passe :").foregroundStyle(accentGradient)).textInputAutocapitalization(.never).disableAutocorrection(true)
                    } else {
                        SecureField("Password", text: $password, prompt: Text("Mot de passe :").foregroundStyle(accentGradient)).textInputAutocapitalization(.never).disableAutocorrection(true)
                    }
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(showPassword ? .accent : .gray)
                    }
                }.padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.accent, lineWidth: 2)
                    }.padding(.horizontal)
                Text(errorText).font(.caption).foregroundColor(.gray)
                Spacer()
                Button {
                    CheckUser(mail: mail, pwd: password)
                    if  loggedUser.id == userDefault.id {
                        errorText = "Veuillez vérifier vos identifiants"
                        password = ""
                    }
                    else {
                        errorText = "Connexion réussie"
                        mail = ""
                        password = ""
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Se connecter")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                }
                .frame(width:300,height:50).background(accentGradient)
                .cornerRadius(20).padding()
            }
        }
        
    }
    func CheckUser (mail:String,pwd:String){
        for user in listeUsers {
            if user.mail == mail && user.motDePasse == pwd {
                loggedUser = user
                break
            }
        }
        for userPro in listePros {
            if userPro.mail == mail && userPro.motDePasse == pwd {
                loggedUser = userPro
                break
            }
        }
    }
}


struct CreerCompte: View {
    @Binding var loggedUser : User

    @State var nomLog: String = ""
    @State var prenomLog: String = ""
    @State var domaineLog:String = ""
    
    @State var newMail: String = ""
    @State var confirmMail: String = ""
    
    
    @State var newPwd: String = ""
    @State var confirmPwd: String = ""
    
    @State var typeCompte:Bool = false
    @State var errorText = ""
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Picker("Type Compte", selection: $typeCompte) {
                Text("Particulier")
                    .tag(false)
                Text("Professionnel")
                    .tag(true)
            }
            .padding(.horizontal,25)
            .padding(.bottom,25)
            .pickerStyle(SegmentedPickerStyle())
            HStack(alignment: .top) {
                VStack() {
                    Image(systemName:"person.crop.circle.dashed")
                        .resizable().imageScale(.large)
                        .foregroundStyle(accentGradient).frame(width:100, height:100)
                        .padding(.leading,25).padding(.trailing,20)
                    Button{
                        
                    }label:{
                        Text("Charger une photo")
                    }
                    .foregroundStyle(.white).font(.caption)
                    .padding(9).background(.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                VStack(alignment:.leading,spacing: 9) {
                    TextField("Prenom", text: $prenomLog, prompt:Text(" Prénom :")
                        .font(.caption).foregroundStyle(.accent)).padding()
                        .frame(width: 240,height:35)
                        .disableAutocorrection(true)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accent, lineWidth: 2)
                        }
                    TextField("Nom :", text: $nomLog, prompt:Text(" Nom :")
                        .font(.caption).foregroundStyle(.accent)).padding()
                        .frame(width: 240,height:35)
                        .disableAutocorrection(true)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accent, lineWidth: 2)
                        }
                    TextField("Adresse mail :",text: $newMail, prompt:Text(" Votre adresse mail :")
                        .font(.caption).foregroundStyle(.accent)).padding()
                        .frame(width: 240,height:35)
                        .textInputAutocapitalization(.never).disableAutocorrection(true)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accent, lineWidth: 2)
                        }
                    TextField("Confirmer l'adresse mail :",text: $confirmMail, prompt:Text(" Confirmer l'adresse mail :")
                        .font(.caption).foregroundStyle(.accent)).padding()
                        .frame(width: 240,height:35)
                        .textInputAutocapitalization(.never).disableAutocorrection(true)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.accent, lineWidth: 2)
                        }
                }
            }
            if typeCompte == true {
                TextField("Domaine :",text: $domaineLog, prompt:Text(" Domaine :")
                    .font(.caption).foregroundStyle(.accent)).padding()
                    .frame(width: 240,height:35)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.accent, lineWidth: 2)
                    }.padding(.top,50)
                Text("Envoyez vos certifications au format PDF pour vérifier votre compte : ")
                    .font(.caption2).padding(.top,30)
                Button{
                    
                }label:{
                    Text("Charger des documents justificatifs (.pdf)")
                    Image(systemName:"checkmark.seal.text.page")
                }
                .foregroundStyle(.white).font(.subheadline)
                .padding(9).background(.accent)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            else {
               
            }
            Spacer()
            TextField("Mot de passe :",text: $newPwd, prompt:Text(" Mot de passe :")
                .font(.caption).foregroundStyle(.accent)).padding()
                .frame(width: 260,height:35)
                .textInputAutocapitalization(.never).disableAutocorrection(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.accent, lineWidth: 2)
                }
            TextField("Confirmer mot de passe :",text: $confirmPwd, prompt:Text(" Confirmer le mot de passe :")
                .font(.caption).foregroundStyle(.accent)).padding()
                .frame(width: 260,height:35)
                .textInputAutocapitalization(.never).disableAutocorrection(true)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.accent, lineWidth: 2)
                }
            Spacer()
            Text(errorText).font(.headline).foregroundStyle(.red).padding(.bottom,50)
            Button {
                testerInfos(mail: newMail, confirMailTest: confirmMail, pwd: newPwd, confirmPwdTest: confirmPwd)
                if infoChecker == false {
                    errorText = "Erreur, veuillez vérifier vos informations"
                } else {
                    errorText = ""
                    loggedUser = EnregistrerCompte()
                    presentationMode.wrappedValue.dismiss()
                }
            }label:{
                Text("Créer compte")
            }.foregroundStyle(.white).font(.headline)
                .padding(20)
                .frame(width: 300, height:50)
                .background(accentGradient)
                .clipShape(RoundedRectangle(cornerRadius:50)).offset(y:-80)
        }
    }
    func EnregistrerCompte() -> User {
        return User(prenom: prenomLog, nom: nomLog,mail:newMail, motDePasse:newPwd, image: "", enLigne: false, typeUser: TypeCompte(estPro: typeCompte, estCertif: false, domaine: domaineLog, avisClients: [], position: CLLocationCoordinate2D(latitude: 0, longitude: 0)), conversations: [])
    }
}

func testerInfos (mail:String,confirMailTest:String,pwd:String,confirmPwdTest:String) {
    if mail.isEmpty || pwd.isEmpty || confirMailTest.isEmpty || confirmPwdTest.isEmpty {
        infoChecker = false
    }
    else if mail == confirMailTest && pwd == confirmPwdTest {
        infoChecker = true
    }
    else {
        infoChecker = false
    }
}

/*#Preview {
    //CreerCompte(compteLog:userDefault)
    LoginCompte(isLogged:false)
}*/
