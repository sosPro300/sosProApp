//
//  MainView.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 14/03/2025.
//
import SwiftUI
import MapKit

var proA = User(prenom: "Marie", nom: "Dupont", mail : "marie@gmail.com", motDePasse : "marie", image:"proAserruriere", distance: 50, enLigne: true, typeUser: TypeCompte(estPro: true, estCertif:true, domaine: "Serrurière", avisClients: listeAvisSerrure, position: CLLocationCoordinate2D(latitude: 48.8577, longitude: 2.43340)),conversations:[])
var proB = User(prenom: "Laura", nom: "Léni", mail : "laura@gmail.com", motDePasse : "laura23", image:"proBplombiere", distance: 50, enLigne: true, typeUser: TypeCompte(estPro: true,estCertif:false, domaine: "Plombière", avisClients: listeAvisPlomb, position: CLLocationCoordinate2D(latitude: 48.84293, longitude: 2.43913)),conversations:[])
var proC = User(prenom: "Paul", nom: "Dubois", mail: "paul@icloud.com", motDePasse: "paul23", image: "proCplombier", distance: 50, enLigne: false, typeUser: TypeCompte(estPro: true, estCertif: true, domaine: "Plombier", avisClients: [], position: CLLocationCoordinate2D(latitude: 48.40068, longitude: 2.29383)), conversations: [])
var proD = User(prenom: "Barbara", nom: "Cora",mail: "barbara@gmail.com", motDePasse: "barbara23", image: "proEelectricienne", distance: 23.0, enLigne: false, typeUser: TypeCompte(estPro: true, estCertif:true, domaine: "Electricienne", avisClients: listeAvisElec, position: CLLocationCoordinate2D(latitude: 39.51967, longitude: 106.42758)), conversations: [])

var userA = User(prenom: "Léa", nom: "Marquet", mail : "lea@gmail.com", motDePasse : "lea",  image:"userA", distance: 25, enLigne: true, typeUser: TypeCompte(estPro: false,estCertif:false, domaine: "", avisClients: [], position: CLLocationCoordinate2D(latitude: 0, longitude: 0)),conversations:[])
var userB = User(prenom: "Jean-Pierre", nom: "Lambert", mail : "jeanpierre@icloud.com", motDePasse : "wilson", image:"userB", distance: 10, enLigne: true, typeUser: TypeCompte(estPro: false,estCertif:false, domaine: "", avisClients: [], position: CLLocationCoordinate2D(latitude: 0, longitude: 0)),conversations:[])
var userC = User(prenom: "Charles", nom: "Frank", mail : "charles@gmail.com", motDePasse : "charles", image:"userC", distance: 48, enLigne: true, typeUser: TypeCompte(estPro: false,estCertif:false, domaine: "", avisClients: [], position: CLLocationCoordinate2D(latitude: 0, longitude: 0)),conversations:[])


var listeUsers: [User] = [userA, userB, userC]
var listePros : [User] = [proA, proB, proC, proD]

var userDefault = User(prenom: "Utilisateur",  nom: "Non inscrit", mail : "default", motDePasse : "default", image: "", distance:25, enLigne: false, typeUser: TypeCompte(estPro: false, estCertif: false, domaine: "", avisClients: [], position: CLLocationCoordinate2D(latitude: 0, longitude: 0)), conversations: [])

struct MainView: View {
    @State var loggedUser = userDefault
    init() {
        UITabBar.appearance().backgroundColor = UIColor.accent
        UITabBar.appearance().unselectedItemTintColor = UIColor.tab
    }
    var body: some View {
        TabView {
            Mapped(loggedUser:loggedUser).tabItem {
                Label("Trouver un pro", systemImage: "mappin.and.ellipse.circle")
            }
            SgmentedMessagerie().tabItem {
                Label("Messagerie", systemImage: "message.fill")
            }
            VoirMonProfil(monProfil:$loggedUser).tabItem {
                Label("Mon profil", systemImage: "person.circle")
            }
        }.tint(.gray)
    }
}

#Preview {
    MainView()
}
