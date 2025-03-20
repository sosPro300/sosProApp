//
//  LaisserAvis.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 17/03/2025.
//

import SwiftUI
import MapKit

struct LaisserAvis: View {
    @State var pro:User
    @State var newCommentaire:String = ""
    @State var avisNote:Int = 0
    
    @State var rating:Int = 1
    @Environment(\.dismiss) var dissmissModal
    private let maxRating = 5
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Laisser un avis")
                        .font(.largeTitle).bold(true)
                    Spacer()
                    VStack {
                        Text("Laissez un commentaire ici pour les autres utilisateurs :")
                            .font(.caption).bold(true)
                        TextEditor(text: $newCommentaire)
                            .foregroundStyle(.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            .background(.separator).clipShape(RoundedRectangle(cornerRadius: 20))
                            .frame(height: 280)
                            .padding()
                            
                        Text("Noter l'intervention de ce professionnel (1 à 5) :")
                            .font(.subheadline).bold(true)
                            .padding(.top, 20)
                        ZStack { //Star Rating
                            RoundedRectangle(cornerRadius: 50).fill(.separator).frame(width: 220, height:50)
                            HStack(spacing:15) {
                                ForEach(1..<maxRating + 1) { value in
                                    Image(systemName: "star").font(.title)
                                        .symbolVariant(value <= avisNote ? .fill : .none)
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            if value != avisNote {
                                                avisNote = value
                                            } else {
                                                avisNote = 0
                                            }
                                        }
                                }.frame(width: 25, height: 25)
                            }
                        }.padding(.top, 20)
                        Spacer()
                    }
                    Button {
                        let newAvis = AvisClient(user: userA, note: avisNote, commentaire:newCommentaire, dateAvis: Date())
                        addAvisClient(pro: proA, avis: newAvis)
                        print(proA.typeUser.avisClients)
                        dissmissModal()
                    }label:{
                        Text("Envoyer avis")
                    }.foregroundStyle(.white).font(.headline)
                        .padding(15)
                        .frame(width: 300, height:40)
                        .background(.accent)
                        .clipShape(RoundedRectangle(cornerRadius: 20)).offset(y:-100)
                }
            }
        }
    }
}

#Preview {
    LaisserAvis(pro:proA)
}
