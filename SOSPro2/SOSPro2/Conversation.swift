//
//  Conversation.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 19/03/2025.
//
import SwiftUI

struct LaConversation: View {
    @State private var message: String = ""
    var userPro: User
    @State var isModal = false
    var body: some View {
        VStack {
            HStack(spacing:50) {
                //a changer
                Image("\(userPro.image)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 110)
//
                VStack (spacing: 5){ //marie,cert et plombière, butt
                    HStack (spacing:8){ // marie et cert
                        Text(userPro.prenom + " " + userPro.nom)
                            .bold()
                            .font(.title2)
                        //Circle().frame(width: 9).foregroundStyle(userPro.enLigne ? .green : .red)
                        //if userPro.typeUser.estCer
                        
                    }//Fin hstack marie, cert
                    
                    // changement
                    HStack {
                        Text (userPro.typeUser.domaine)
                        if userPro.typeUser.estCertif {
                            Image(systemName: "checkmark.seal.fill").resizable().frame(width: 15, height: 15)
                        }
                    }
                }
            }
            HStack  { // des deux button
                Button {
                    isModal = true
                } label: {Text("Laisser un avis")
                        .bold()
                        .padding(10)
                        .background(Color.accent)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.footnote)
                        .offset(x:-50)
                }//fin button1
             
                //button archive:
               Button {} label: {Text("Archiver")
                        .bold().padding(10)
                        .background(Color.accent).foregroundColor(.white)
                        .cornerRadius(10).font(.footnote)
                        .offset(x:50)
                }//fin button archive
            }
            //.padding(.top, 40)
            //.padding(.horizontal)

            Divider()
                .background(Color.gray)
                .padding(.top)

            
            Spacer()
            HStack (spacing: 0){   /*envoi message*/
                Button {
                    
                } label: {
                    Image(systemName:"plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.accent)
                        .bold()
                }//fin Button 
                TextField("Écrire un message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Ajoute un style
                    .padding()
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundStyle(.accent)
                    .bold()
            }
            .padding()
        
    }.sheet(isPresented: $isModal) {
        LaisserAvis(pro:userPro)
    }//fin Vstack principale
    }//fin body
}//fin structure

#Preview {
    LaConversation(userPro: proA)
}
