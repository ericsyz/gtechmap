//
//  MapView.swift
//  test
//
//  Created by Eric Zhou on 10/23/21.
//

import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    var annotations: [MKPointAnnotation]
    
    var locationManager = CLLocationManager()
     func setupManager() {
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       locationManager.requestWhenInUseAuthorization()
       locationManager.requestAlwaysAuthorization()
     }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()

        let mapView = MKMapView(frame: UIScreen.main.bounds)
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.776780, longitude: -84.397983),
            span: MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017))
       
        mapView.setRegion(region, animated: true)
        mapView.delegate = context.coordinator
        
        let pin = MKPointAnnotation()
        pin.title = "CULC"
        pin.subtitle = "Study Center"
        pin.coordinate = CLLocationCoordinate2D(latitude: 33.774684, longitude: -84.396446)
        mapView.addAnnotation(pin)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if (annotations.count != view.annotations.count) {
            view.removeAnnotations(view.annotations)
             view.addAnnotations(annotations)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if (annotationView == nil) {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let placemark = view.annotation as? MKPointAnnotation else {
                return
            }
            
            parent.selectedPlace =  placemark
            parent.showingPlaceDetails = true
        }
        
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Bob"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 33.774684, longitude: -84.396446)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
    }
}
