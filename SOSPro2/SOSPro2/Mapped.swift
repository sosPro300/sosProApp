//
//  Mapped.swift
//  SOSPro2
//
//  Created by Apprenant 130 on 13/03/2025.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var user:User
    var name: String
    var domaine: String
    var coordinate: CLLocationCoordinate2D
    
    
}
func createLocations() -> [Location] {
    var locations: [Location] = [
        Location(user: proA, name: proA.nom, domaine: proA.typeUser.domaine, coordinate: proA.typeUser.position),
        Location(user: proB, name: proB.nom, domaine: proB.typeUser.domaine, coordinate: proB.typeUser.position)
    ]
    for pro in listePros {
        let newLocation = Location(user: pro, name: pro.nom, domaine: pro.typeUser.domaine, coordinate: pro.typeUser.position)
        locations.append(newLocation)
    }

    return locations
}
var proLocations = createLocations()

struct MarkerPro: View {
    let markPro:User
    
    var body: some View {
        ZStack {
            if markPro.typeUser.estCertif {
                Image(systemName: "checkmark.seal").resizable().offset(x:10,y:-10)
                    .frame(width:15, height:15)
            }else {
                
            }
            HStack (spacing:5){
                Text(markPro.typeUser.domaine).font(.caption2)
                Circle().frame(width: 6, height: 6).foregroundColor(markPro.enLigne ? .green : .red)
            }
                .padding(5)
                .background(.accent)//.background(markPro.enLigne ? .green : .red)
                .foregroundColor(.white)
                .clipShape(Capsule()).offset(y: -33)
            Image(systemName:"person.circle").resizable()
                .frame(width: 44, height: 44).foregroundStyle(.accent)//.foregroundStyle(markPro.enLigne ? .green : .red)
            
        }
    }
}
struct Mapped: View {
    @State var loggedUser: User
    @StateObject var viewModel = ContentViewModel()
    
    @State private var searchText: String = ""
    @State var suggestions: [String] = ["Plombier","Serrurier","Electricien"]
    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: proLocations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink(destination: VoirProfilPro(profilView: location.user)) {
                        if location.user.enLigne {
                            MarkerPro(markPro: location.user)
                        }
                    }
            }
            }.mapControls {
                MapUserLocationButton()
            }.edgesIgnoringSafeArea(.all)
            .searchable(text: $searchText, prompt: "Rechercher un professionnel")
            .searchSuggestions {
                ForEach(suggestions, id: \.self) { suggestion in
                    Text(suggestion).searchCompletion(suggestion)
                }
            }
                .onChange(of: loggedUser.distance) {
                    updateZoomLevel(newValue: loggedUser.distance/78)
                }
        }
            .onAppear {
            viewModel.checkIfLocationIsEnabled()
}
    }
    private func updateZoomLevel(newValue: Double) {
        viewModel.mapRegion.span = MKCoordinateSpan(latitudeDelta: newValue, longitudeDelta: newValue)
    }
}


final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
    @StateObject var profil = userDefault
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.85453, longitude: 2.43655), span: MKCoordinateSpan(latitudeDelta: (userDefault.distance/78), longitudeDelta: (userDefault.distance/78)))
    
    override init() {
        super.init()
        checkIfLocationIsEnabled()
    }
    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation() // Start updating location
        } else {
            print("Show an alert letting them know this is off")
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization() {
        guard let location = locationManager else { return }

        switch location.authorizationStatus {
        case .notDetermined:
            print("Location authorization is not determined.")
        case .restricted, .denied:
            print("Location permission denied or restricted.")
        case .authorizedAlways, .authorizedWhenInUse:
            if let userLocation = location.location {
                mapRegion.center = userLocation.coordinate // Update map center to user location
            }
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        mapRegion.center = userLocation.coordinate // Update the map region with the latest user location
    }
}
/*#Preview {
    Mapped()
}*/
