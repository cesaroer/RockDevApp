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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        view.backgroundColor = UIColor.myRed

    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
    
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
            mapView.showsUserLocation = true
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }

}

extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //well be back here
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Well be back here
    }
    
    
    
}
