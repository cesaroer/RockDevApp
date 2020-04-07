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
    @IBOutlet weak var adressLbl: UILabel!
    @IBOutlet weak var pinImageView: UIImageView!
    //Variable en la que asignamos el gestor de localizacion
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    //Variable que tiene nuestra ubicacion en primera instanci
    var previousLocation:CLLocation?
    //variables para resetear el mapa y pintar la ruta
    let geoCoder = CLGeocoder()
    var directionsArray:[MKDirections] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        view.backgroundColor = UIColor.myRed
        //Ocultamos el pin al inicio y lo mostraremos cuando el usuario de tap en empezar
        pinImageView.isHidden = true
        mapView.delegate = self
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    
    
//MARK: Actions Btns
    
    @IBAction func startBtnTapped(_ sender: Any) {
        //Activamos nuestra funcion en ViewDidAppear para poder verificar los servicios una vez que se presente la vista.
        checkLocationServices()
        //mostramos el pin
        pinImageView.isHidden = false

    }
    @IBAction func irBtnTapped(_ sender: Any) {
        getDirections()
    }
    
//MARK: Funcion para obtener la direccion hacia un lugar
    func getDirections() {
        guard let location  = locationManager.location?.coordinate else {
            return
        }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections( request: request)
        resetMapView(directins: directions)
        
        directions.calculate { [unowned self] (response, error) in
            guard let response = response else {return}
            
            for route in response.routes{
                //let steps =  route.steps
                print("ESTAS:SON:LAS:ISNTRUCCIONES:")
                for step in route.steps{
                    print(step.instructions)
                }
               
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
//MARK: Funcion para configurar la ruta en pantalla
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate = getCenterLocation(MapView: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
        let request  = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
//MARK: Funcion para resetear el map view cuando generamos rutas
    func resetMapView(directins: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directins)
        let  _ = directionsArray.map { $0.cancel()}
        directionsArray.removeAll()
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
            startTrackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            //Si no tenemos autorizacion, pedimos que nos deje usar ubicacion
            locationManager.requestWhenInUseAuthorization()
            self.checkLocationAuthorization()
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
    
//MARK: Funcion para obtener las coordenadas al mover el Pin
    func getCenterLocation(MapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
//MARK: En esta funcion englobaremos las funciones para mejorar la limpieza de codigo
    
    func startTrackingUserLocation() {
        print("ESTAMOS_EN_WHEN_IN_USE")
        //mostramos la localizacion del usuario, hacemos un acercamiento a el y mantenemos actualizada la localizacion
        mapView.showsUserLocation = true
        centerViewOnUsersLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(MapView: mapView)
    }
    

    
    

}

extension MapViewController: CLLocationManagerDelegate{
    
 /*   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Con esta funcion vamos a actualizar la ultima ubicacion dle usuario, a medida que se mueva si es que lo hace, si no no hacemos nada.
        guard let location = locations.last else {return}
        let center  = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    } */
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Checamos Si el usuario cambia autorizacion en la localizacion o si en un principio no dio permiso y ahora se lo pedimos.
        checkLocationAuthorization()
    }
    
    
    
}

extension MapViewController: MKMapViewDelegate {

//MARK: Funcion para saber si la localizacion al mover el mapa cambio
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

        print("Estamos_EN_GEOCODER")
        let center = getCenterLocation(MapView: mapView)


        //Verificamos si la localizacion previa es nula
        guard let previousLocation = self.previousLocation else {return}

        //Si la distancia es mayor a 20 metros empezamos la funcion, de lo contrario no hacemos nada
        guard center.distance(from: previousLocation) > 20 else {return}
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        
        //Dentro de esta funcion tendremos la direccion a travez de las coordenadas
        geoCoder.reverseGeocodeLocation(center) { [weak self](placemarks, error) in
            guard let self = self else{return}
            if let _ = error {
                print("estamosEnErrorGeoCodeReverse")
                return
            }

            guard let placemark = placemarks?.first else{
                print("ProbelamConLaDataRecividaDeGeocoder")

                return
            }

            //Obtenemos la direccion y numero de calle
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            print("ESTA_ES_LA_UBI:_ \(streetName) \(streetNumber)")
            
            //Asignamos el hilo principal la direccion por que estamos en un closure y los closures son procesos asincronos
            DispatchQueue.main.async {
                self.adressLbl.text = "\(streetName) \(streetNumber)"
            }
        }
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline )
        renderer.strokeColor = .blue
        
        return renderer
    }
}
