//
//  MapViewController.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    //Variable en la que asignamos el gestor de localizacion
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        view.backgroundColor = UIColor.myRed
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    
    
//MARK: Actions Btns
    
    @IBAction func startBtnTapped(_ sender: Any) {
        //Activamos nuestra funcion en ViewDidAppear para poder verificar los servicios una vez que se presente la vista.
        checkLocationServices()
    }
    

    
//MARK: Funcion para configurar el locationmanager
    func setUpLocationMaganer() {
        //Configuramos delegado y precisión
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    
//MARK: Funcion para saber si la localizacion esta habilitada
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            //iniciamos LocationManager
            setUpLocationMaganer()
            //checamos que permisos tenemos de localizacion
            DispatchQueue.main.async {
                self.checkLocationAuthorization()
            }
        }else{
            //Mostramos alerta para que el usuario active su ubicacion
            let alert = UIAlertController(title: "Ubicación no activa", message: "Activa tu Ubicacion para poder ingresar a esta funcionalidad", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (ok) in
                    self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
//MARK: Funcion para saber si tenemos permisos de Localizacion
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            print("ESTAMOS_EN_WHEN_IN_USE")
            //mostramos la localizacion del usuario, hacemos un acercamiento a el y mantenemos actualizada la localizacion
            mapView.showsUserLocation = true
            centerViewOnUsersLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            //Si no tenemos autorizacion, pedimos que nos deje usar ubicacion
            locationManager.requestWhenInUseAuthorization()
            self.checkLocationAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    
//MARK: Funcion para configurar el mapa en la localizacion del usuario
    func centerViewOnUsersLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            print("Centramos_la_regin")
            mapView.setRegion(region, animated: true)
        }
    }
    

}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Con esta funcion vamos a actualizar la ultima ubicacion dle usuario, a medida que se mueva si es que lo hace, si no no hacemos nada.
        guard let location = locations.last else {return}
        let center  = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Checamos Si el usuario cambia autorizacion en la localizacion o si en un principio no dio permiso y ahora se lo pedimos.
        checkLocationAuthorization()
    }
    
    
    
}
