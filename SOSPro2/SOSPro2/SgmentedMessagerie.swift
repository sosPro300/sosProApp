//
//  SgmentedMessagerie.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 20/03/2025.
//

import SwiftUI

struct SgmentedMessagerie: View {
    @State private var monMessage = "Récents"
    let mesMessages = ["Récents", "Archivés"]
    @State private var count : Int = 0
    //@StateObject var profil: User
    var body: some View {
       
        VStack {
            
            Picker("Archiver", selection: $count) {
                //            ForEach(mesMessages, id: \.self) { option in
                Text("Récents").tag(0)
                Text("Archivés").tag(1)
                //            }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if count == 0 {
                Messagerie()
            } else {
                Spacer()
                Text("Aucun message archivé")
            }
            Spacer()
            
        }
        
        //.pickerStyle(MenuPickerStyle()) en menu déroulant
        
        //ma condition
//        if monMessage == mesMessages [0] { Messagerie()}
//        else { Text ("Aucun message archivé")
//                .frame(height: 700)
//        }
            
        
    }
}

/*#Preview {
    SgmentedMessagerie()
}*/

