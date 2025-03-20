//
//  ContentView.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 13/03/2025.
//

import SwiftUI
import MapKit


class User: ObservableObject, Identifiable {
    let id = UUID()
    @Published var prenom:String
    @Published var nom:String
    @Published var mail:String
    @Published var motDePasse:String
    @Published var image:String
    @Published var distance:Double
    @Published var enLigne:Bool
    @Published var typeUser:TypeCompte //permet de définir si c'est un pro ou un particulier
    @Published var conversations:[Conversation]
    
    init(prenom: String, nom: String, mail:String,motDePasse:String, image:String,distance: Double = 25, enLigne: Bool, typeUser: TypeCompte, conversations : [Conversation]) {
        self.prenom = prenom
        self.nom = nom
        self.mail = mail
        self.motDePasse = motDePasse
        self.image = image
        self.distance = distance
        self.enLigne = enLigne
        self.typeUser = typeUser
        self.conversations = []
    }
}

class TypeCompte: ObservableObject,Identifiable{
    let id = UUID()
    @Published var estPro:Bool
    @Published var estCertif:Bool
    @Published var domaine:String
    @Published var avisClients:[AvisClient]
    @Published var position:CLLocationCoordinate2D
    
    init(estPro: Bool, estCertif: Bool, domaine: String, avisClients: [AvisClient] = [], position: CLLocationCoordinate2D) {
            self.estPro = estPro
            self.estCertif = estCertif
            self.domaine = domaine
            self.avisClients = avisClients
            self.position = position
    }
}



/*class Message: ObservableObject, Identifiable{
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
}*/


struct BaseStructsView: View {
    var body: some View {
        VStack {
            Text("Hello")
        }
    }
}

#Preview {
    BaseStructsView()
}

