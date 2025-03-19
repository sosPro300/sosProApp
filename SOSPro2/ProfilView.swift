//
//  ProfilView.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 14/03/2025.
//

import SwiftUI
import MapKit

struct AvisClient: Identifiable{
    let id = UUID()
    var user : User
    var note: Int
    var commentaire: String
    var dateAvis: Date
}
var listeAvisPlomb: [AvisClient] = [AvisClient(user: userA, note: 4, commentaire: "Super service ! Mon lavabo fuyait et la plombière est arrivée en moins d'une heure. Travail très sérieux et rapide.",dateAvis:Date.now),
                               AvisClient(user: userB, note: 4, commentaire: "La plombière a été réactive pour déboucher ma canalisation. Un peu cher, mais la qualité du service est au rendez-vous.",dateAvis:Date.now),
                               AvisClient(user: userC, note: 3, commentaire: "Le service était bon, mais j'ai trouvé l'attente un peu longue. Une fois sur place, la réparation était de bonne qualité.",dateAvis:Date.now)]

var listeAvisSerrure: [AvisClient] = [AvisClient(user: userC, note: 4, commentaire: "Super service ! Ma serrure était bloquée et la serrurière est arrivée en moins d'une heure. Travail rapide et très professionnel.",dateAvis:Date.now),
                                AvisClient(user: userA, note: 5, commentaire: "La serrurière a été très réactive pour changer ma serrure. Un peu plus cher que prévu, mais la qualité du travail en valait la peine.",dateAvis:Date.now),
                                AvisClient(user: userB, note:3, commentaire: "Le service était satisfaisant, mais j'ai trouvé l'attente un peu longue. Une fois sur place, l'installation a été faite avec soin et précision.",dateAvis:Date.now)]

var listeAvisElec: [AvisClient] = [AvisClient(user: userC, note: 5, commentaire: "Service impeccable ! Mon éclairage ne fonctionnait plus et l'électricienne est arrivée rapidement. Travail soigné et efficace.",dateAvis:Date.now),
                                  AvisClient(user: userA, note: 4, commentaire: "L'électricienne a été très prompte à diagnostiquer le problème de mon tableau électrique. Un tarif un peu élevé, mais le service est de qualité.",dateAvis:Date.now),
                                  AvisClient(user: userB, note: 3, commentaire: "Le service était bon, mais le délai d'attente était un peu plus long que prévu. Cependant, une fois là, la réparation a été réalisée avec beaucoup de compétence.",dateAvis:Date.now)]

func addAvisClient(pro:User,avis: AvisClient) {
    pro.typeUser.avisClients.append(avis)
}

#Preview {
    VoirProfilPro(profilView:proA)
}

struct VoirProfilPro: View {
    @StateObject var profilView:User
    var body: some View {
        NavigationStack {
            HStack(spacing:15) {
                Image(profilView.image)
                    .resizable().scaledToFill().imageScale(.large).clipShape(Circle())
                    .foregroundStyle(.accent).frame(width:130, height:130)
                    .padding(.trailing,40)
                VStack(alignment: .leading) {
                    HStack (spacing: 0){
                        Text("\(profilView.prenom) \(profilView.nom)").font(.title2)
                            /*Circle()
                            .fill(profilView.enLigne ? .green : .red)
                            .frame(width:9).padding(9)*/
                    }
                    HStack(spacing:1){
                        Circle()
                            .fill(profilView.enLigne ? .green : .red)
                            .frame(width:9).padding(9)
                        Text(profilView.enLigne ? "Disponible" : "Indisponible").font(.caption).bold()
                    }
                    HStack {
                        Text("\(profilView.typeUser.domaine)").font(.headline).padding(.bottom,20)
                        if profilView.typeUser.estCertif {
                            Image(systemName: "checkmark.seal.fill").resizable().offset(x:0,y:-10)
                                .frame(width:15, height:15)
                        }
                    }
                }
            }
            NavigationLink(destination:LaConversation(userPro:profilView)) {
                Text("Contacter ce professionnel")
            }.padding(.vertical,10).padding(.horizontal,35)
                .background(.accent).clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white).bold().padding(.top,20)//.offset(x:40)
            VStack {
                Text("Avis d'autres clients :\r").padding(.top,80).font(.headline).offset(x:-100).underline()
                VoirAvis(profil:profilView)
                Spacer()
            }
        }
    }
}
struct VoirAvis : View {        //affichage des avis clients
    @StateObject var profil:User
    var body: some View {
        if profil.typeUser.avisClients.isEmpty {
            Text("Aucun avis laissé par d'autres utilisateurs").padding(50).font(.footnote).foregroundStyle(.separator)
        }
        let noteMax:Int = 5
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(profil.typeUser.avisClients) { forAvis in
                    ZStack (alignment:.top){
                        RoundedRectangle(cornerRadius: 15).strokeBorder(Color.black, lineWidth: 1).foregroundStyle(.separator.opacity(0.5))
                        VStack(spacing:20) {
                            HStack {
                                Image(forAvis.user.image).resizable().scaledToFill().clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                Text("\(forAvis.user.prenom)").font(.headline)
                                    .padding(.horizontal,40)
                                HStack {
                                    ForEach(0..<forAvis.note) {_ in
                                        Image(systemName:"star.fill").foregroundStyle(.yellow)
                                            .padding(.horizontal,-5)
                                    }
                                    ForEach(forAvis.note..<noteMax) {_ in
                                        Image(systemName:"star.fill")
                                            .padding(.horizontal,-5)
                                    }
                                }
                            }
                            Text("\(forAvis.commentaire)").font(.subheadline).foregroundColor(.gray)
                        }.padding()
                    }.frame(width: 390, height: 250).padding(.horizontal,5)
                }
            }
        }
    }
}
