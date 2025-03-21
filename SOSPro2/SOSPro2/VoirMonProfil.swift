//
//  VoirMonProfilPro.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 15/03/2025.
//

import SwiftUI
import MapKit

struct VoirMonProfil: View {
    @Binding var monProfil:User
    @State var isModal = false
    var body: some View {
        NavigationStack {
            VStack(spacing:50) {
                HStack {
                    if monProfil.image == "" {
                        Image(systemName: "person.crop.circle.dashed").resizable().imageScale(.large).clipShape(Circle())
                            .foregroundStyle(.accent).frame(width:100, height:100)
                            .padding(.trailing,50).offset(x:-10)
                    }else {
                        Image(monProfil.image).resizable().scaledToFill().imageScale(.large).clipShape(Circle())
                            .foregroundStyle(.accent).frame(width:100, height:100)
                            .padding(.trailing,50).offset(x:-10)
                    }
                    VStack(alignment: .leading) {
                        VStack {
                            HStack (spacing: 0){
                                Text("\(monProfil.prenom) \(monProfil.nom)").font(.title2)
                            }
                            if monProfil.typeUser.estPro {
                                HStack {
                                    Text("\(monProfil.typeUser.domaine)").font(.headline).padding(.bottom,20)
                                    if monProfil.typeUser.estCertif {
                                        Image(systemName: "checkmark.seal.fill").resizable().offset(x:0,y:-10)
                                            .frame(width:15, height:15)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.bottom,10)
                VStack {
                    if monProfil.typeUser.estPro {
                        ChangerStatut(profil:monProfil)
                    }
                    if monProfil.id != userDefault.id {
                        Button {
                            isModal = true
                        }label:{
                            Text("Modifier profil").padding(.vertical,10).padding(.horizontal,35)
                                .background(.accent).clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(.white).bold()
                        }
                    }
                }.offset(x:80,y:-50)
                    VStack {
                        if monProfil.typeUser.estPro {
                            VStack {
                                Text("Avis d'autres clients :\r").font(.headline).underline().offset(x:-100)
                                VoirAvis(profil: monProfil)
                            }
                        }
                        else {
                            MoveDistance(profil: monProfil)
                            if monProfil.id == userDefault.id {
                                VStack(alignment:.center,spacing: 40) {
                                    Spacer()
                                    NavigationLink(destination: CreerCompte(loggedUser:$monProfil)) {
                                        Text("Créer un compte")
                                    }
                                    .foregroundStyle(.white).font(.headline)
                                    .padding(15)
                                    .background(.accent)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    NavigationLink(destination: LoginCompte(loggedUser:$monProfil)) {
                                        Text("Connexion")
                                    }
                                    .foregroundStyle(.green).font(.headline)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    Spacer()
                                }
                            }
                        }
                        if monProfil.id != userDefault.id {
                            Button {
                                monProfil = userDefault
                            }label:{
                                Text("Déconnexion")
                            }.foregroundStyle(.red).font(.headline).padding(20)
                        }
                    }
            }.sheet(isPresented: $isModal) {
                ModifProfil(profil:monProfil)
            }
        }
    }
}

struct MoveDistance: View {
    @StateObject var profil: User
    var body: some View {
        VStack(spacing:20){
            Text("Distance maximale des professionnels affichés sur la carte :").font(.callout).bold().multilineTextAlignment(.center)
            Text("\(profil.distance,specifier: "%.0f") km")
                .foregroundStyle(.accent).font(.title2)
            HStack() {
                Text("1").foregroundStyle(.accent).font(.headline)
                Slider(value:$profil.distance, in: 1...50, step: 1).frame(width:300)
                Text("50").foregroundStyle(.accent).font(.headline)
            }
        }
    }
}

struct ModifierProfil: View {
    @StateObject var profil:User
    var body: some View {
            Button {
                //ModifProfil()
            }label:{
                Text("Modifier profil").padding(.vertical,10).padding(.horizontal,35)
                    .background(.accent).clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white).bold()
            }
    }
}

struct ChangerStatut: View {        //statut en ligne/hors-ligne
    @StateObject var profil:User
    var body: some View {
        Button {
            profil.enLigne.toggle()
            print(profil.enLigne)
        }label:{
            Text(profil.enLigne ? "Passer hors-ligne" : "Passer en ligne")
            profil.enLigne ? Image(systemName: "globe") : Image(systemName: "globe")
            
        }
        .padding(.vertical,10).padding(.horizontal,6)
        .background(.separator.opacity(0.5)).clipShape(RoundedRectangle(cornerRadius: 20))
        .foregroundStyle(profil.enLigne ? .green : .gray).bold()
    }
}
/*#Preview {
    VoirMonProfil(monProfil:userA)
}*/
