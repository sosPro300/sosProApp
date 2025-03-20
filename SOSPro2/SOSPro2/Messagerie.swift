//
//  Conversation.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 19/03/2025.
//
import SwiftUI

struct Messagerie: View {
    //@State var maConversation : [Conversation] = [conversation1]
   // @State var listMessages: [Message] = [message1, message2, message3]
    //@State var profil: User
    var body: some View {
        VStack{
            NavigationStack {
                Text("Mes messages")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                List (listePros) { pro in
                    NavigationLink(destination: LaConversation(userPro: pro)) { //profil.conversations.user
                        VStack(alignment: .leading) {
                            HStack (alignment: .top) {
                                Image("\(pro.image)")
                                    .resizable().scaledToFill() //Remplit bien le cercle sans déformation
                                    .frame(width: 70, height: 70) //Définit une petite taille
                                    .clipShape(Circle())
                                VStack(alignment:.leading) {
                                    HStack {
                                        Text("\(pro.prenom) \(pro.nom)")
                                            .font (.title2)
                                            .bold()
                                        Circle().fill(pro.enLigne ? .green : .red).frame(width:8, height: 8)
                                    }
                                    Text ("\(Date.now.formatted(.dateTime.day().month().hour().minute()))").font(.caption)
                                        .padding(.trailing, 0)
                                }.offset(y:10)
                            }// hstack1
                            Text("Aperçu du dernier message reçu")//.padding()
                        }
                    }  //Fin navlink
                }      //fin list
            }// fin Vstack
        }//fin nav Stack
    }//Fin body
}//fin Structure

/*#Preview {
    Messagerie(profil:loggedUser)
}*/

class Conversation: ObservableObject, Identifiable{
    @Published var id: UUID?
    @Published var user: User
    @Published var messages: [Message]
    
    init(id: UUID? = nil, user: User, messages: [Message]) {
        self.id = id
        self.user = user
        self.messages = []
    }
}
var conv1 = Conversation(user: proA, messages: [message2,message1])
var conv2 = Conversation(user: proB, messages: [message4,message3])
var conv3 = Conversation(user: proC, messages: [])
var conv4 = Conversation(user: proA, messages: [])
var conv5 = Conversation(user: proA, messages: [])
class Message: ObservableObject, Identifiable{
    @Published var id: UUID?
    @Published var contenu: String
    @Published var dateEnvoi: Date
    @Published var heure: String
    
    init(id: UUID? = nil, contenu: String, dateEnvoi: Date, heure: String) {
        self.id = id
        self.contenu = contenu
        self.dateEnvoi = dateEnvoi
        self.heure = heure
    }
}


// Instances Message
var message1 = Message(contenu: "Bonjour...", dateEnvoi: Date(), heure: "10:00")
var message2 = Message(contenu: "Comment ça va ?", dateEnvoi: Date(), heure: "10:01")
var message3 = Message(contenu: "Hello!", dateEnvoi: Date(), heure: "11:00")
var message4 = Message(contenu: "Comment ça va ?", dateEnvoi: Date(), heure: "11:03")
var message5 = Message(contenu: "Bonjour!", dateEnvoi: Date(), heure: "12:00")
var message6 = Message(contenu: "Comment ça va ?", dateEnvoi: Date(), heure: "12:01")
