//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Nestor Camela on 24/12/2025.
//

import CoreLocation

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined // Estado del permiso

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationAuthorization() {
        // Verifica el estado actual para no pedir repetidamente si ya fue denegado
        let status = manager.authorizationStatus
        if status == .notDetermined || status == .denied || status == .restricted {
            manager.requestWhenInUseAuthorization() // O .requestAlwaysAuthorization()
        }
    }

    // MARK: - CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation() // Inicia la actualización si se concede el permiso
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error getting location: \(error.localizedDescription)")
    }
}

