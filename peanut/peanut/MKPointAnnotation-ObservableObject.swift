//
//  MKPointAnnotation-ObservableObject.swift
//  test
//
//  Created by Eric Zhou on 10/23/21.
//

import Foundation
import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? ""
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? ""
        }
        set {
            subtitle = newValue
        }
    }
}
