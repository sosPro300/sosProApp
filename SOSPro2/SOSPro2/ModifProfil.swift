//
//  ModifierProfil.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 19/03/2025.
//
import SwiftUI

struct ModifProfil: View {
    @State var profil:User
    @State private var texte: String = "" // Pour mes champs de text
    @Environment(\.dismiss) var dissmissModal
    let comptes = ["Professionnel", "Particulier"]
    
   
    var body: some View {
        ZStack {
//            Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack{
                
                HStack (spacing:10){
                    Image(profil.image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 200, height: 200)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading) // Aligner à gauche
                    
                    
                    Button {
                        
                    } label: { Text("Modifier la photo")
                            .bold()
                        
                    }//fin button 1
                    .padding(.trailing,30)
                    
                    
                }//fin HStack
                HStack /*nom*/ {
                    Text ("Nom:")
                    TextField(profil.nom, text: $texte)  // Champ de texte
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Style arrondi
                        .padding([.leading, .trailing]) // Ajoute du padding à gauche et à droite du champ
                }//Fin hstak nom
                .padding(.horizontal)
                HStack /*prenom*/ {
                    Text ("Prénom:")
                    TextField(profil.prenom, text: $texte)  // Champ de texte
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Style arrondi
                        .padding([.leading, .trailing])
                }//Fin hstak prenom
                .padding(.horizontal)
                HStack /*mail*/ {
                    Text ("Adresse mail:")
                    TextField(profil.mail, text: $texte)  // Champ de texte
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Style arrondi
                        .padding([.leading, .trailing])
                }//Fin hstak mail
                .padding(.horizontal)
                HStack /*passe*/ {
                    Text ("Mot de passe:")
                    TextField("*********", text: $texte)  // Champ de texte
                        .textFieldStyle(RoundedBorderTextFieldStyle()) // Style arrondi
                        .padding([.leading, .trailing])
                }//Fin hstak pass
                .padding(.horizontal)
                
                if profil.typeUser.estPro {
                    VStack {
                        HStack {
                            Text ("Domaine:")
                            TextField("Plombiere", text: $texte)  // Champ de texte
                                .textFieldStyle(RoundedBorderTextFieldStyle()) // Style arrondi
                                .padding([.leading, .trailing])
                        }.padding(.horizontal)
                        Text ("Certifications:")
                        HStack{
                            Button {
                             
                            } label: {
                                Image(systemName:"plus.circle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundStyle(.blue)
                                Text("Envoyer le fichier")
                                    .foregroundStyle(.gray)
                                    .bold()
                            }.padding(10)
                             .background(Color.gray.opacity(0.2))
                             .cornerRadius(10)
                            Text("Format accepté: PDF")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }.padding()
                        Text ("(Envoyer vos diplomes pour certification)")
                            .font(.body)
                            .foregroundStyle(.gray)
                            .padding(.horizontal)
                        Spacer()
                        HStack{
                            Text ("Diplôme de Plombier vérifié:")
                                .font(.body)
                                .foregroundStyle(.gray)
                            Image(systemName: "checkmark.seal.fill")
                        }
                    }
                }

                
                Button {
                    dissmissModal()
                } label: { Text("Enregistrer les modifications")
                        .bold()
                        .padding()
                        .background(Color.accent)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }//fin button 3
                .padding()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Supprimer mon compte")
                        .foregroundStyle(.red)
                        .bold().offset(y:-40)
                    
                }.padding(.top,50)//fin button 4
                
                
            }// fin première Vstack
            .padding()
            
            Spacer ()
        }
    }// fin body
}

#Preview {
    ModifProfil(profil:userA)
}
