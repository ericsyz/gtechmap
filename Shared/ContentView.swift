//
//  ContentView.swift
//  Shared
//
//  Created by Eric Zhou on 10/23/21.
//

import SwiftUI
import MapKit


struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 33.776737,
            longitude: -84.398798
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.017,
            longitudeDelta: 0.017
        )
    )
    
    var annotationItems: [MyAnnotationItem] = [
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.774684, longitude: -84.396446)),
        ]

    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                 annotationItems: annotationItems) {item in
                 MapPin(coordinate: item.coordinate)
             }

            Button("zoom") {
                withAnimation {
                    region.span = MKCoordinateSpan(
                        latitudeDelta: 100,
                        longitudeDelta: 100
                    )
                }
            }
        }
    }
}
var clicks = 0
struct ContentView: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                Text("Test")
                    .font(.title).multilineTextAlignment(.leading).padding(20)
                Divider()
                Text("Hello, world!")
                    .padding()
                Button(action: {
                    clicks+=1
                    print(clicks)
                }) {
                    Text("Hi!")
                        .padding(.leading, 10.0)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

