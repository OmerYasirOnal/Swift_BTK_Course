//
//  ViewController.swift
//  HaritalarUygulamasi
//
//  Created by Ömer Yasir Önal on 17.02.2024.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var isimTextField: UITextField!
    
    @IBOutlet weak var notTextField: UITextField!
    var initialLocationSet = false
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var secilenLatitude = Double()
    var secilenLongitude = Double()
    
    var secilenIsım : String = ""
    var secilenId : UUID?
    @IBOutlet weak var saveButton: UIButton!
    
    var annotionTitle = ""
    var annotionSubtitle = ""
    var annotionLongitude = Double()
    var annotionLatitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        mapView.showsUserLocation = true

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(konumSec(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if secilenIsım != ""{

            if let uuidString = secilenId?.uuidString {
                
                saveButton.isHidden = true
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Yer")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false
                
                do{
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0 {
                        for sonuc in sonuclar as! [NSManagedObject]{
                            
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                annotionTitle = isim
                                
                                if let not = sonuc.value(forKey: "not") as? String{
                                    annotionSubtitle = not
                                    
                                    if let latitude = sonuc.value(forKey: "latitude") as? Double{
                                        annotionLatitude = latitude
                                        
                                        if let longitude = sonuc.value(forKey: "longitude") as? Double{
                                            annotionLongitude = longitude
                                            
                                            let annotion = MKPointAnnotation()
                                            annotion.title = annotionTitle
                                            annotion.subtitle = annotionSubtitle
                                            let coordinate = CLLocationCoordinate2D(latitude: annotionLatitude, longitude: annotionLongitude)
                                            annotion.coordinate = coordinate
                                            
                                            mapView.addAnnotation(annotion)
                                            
                                            isimTextField.text = annotionTitle
                                            notTextField.text = annotionSubtitle
                                            
                                            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                            let region = MKCoordinateRegion(center: coordinate, span: span)
                                            
                                            mapView.setRegion(region, animated: true)
                                            
                                        }
                                    }
                                }
                            }
                           
                            
                                
                        }
                    }
                }
                    catch{
                    print("Hata var")
                }
                
            }
            
        }else{
            saveButton.isHidden = false
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseId = "benimAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .red
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
            
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if secilenIsım != ""{
            
            let requestLocation = CLLocation(latitude: annotionLatitude, longitude: annotionLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarkDizisi, hata) in
                
                if let placeMarks = placemarkDizisi {
                    if placeMarks.count > 0{
                        let yeniPlaceMark = MKPlacemark(placemark: placeMarks[0])
                        let item = MKMapItem(placemark: yeniPlaceMark)
                        item.name = self.annotionTitle
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        item.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
             view.endEditing(true)
         }
    
    @objc func konumSec(gestureRecognizer: UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            
            let dokunulanNokta = gestureRecognizer.location(in: mapView)
            let dokunulanKordinat = mapView.convert(dokunulanNokta, toCoordinateFrom: mapView)
            
            secilenLatitude = dokunulanKordinat.latitude
            secilenLongitude = dokunulanKordinat.longitude
            
            let annotion = MKPointAnnotation()
            annotion.coordinate = dokunulanKordinat
            annotion.title = isimTextField.text
            annotion.subtitle = notTextField.text
            mapView.addAnnotation(annotion)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if annotionTitle == ""{
            guard let location = locations.first, !initialLocationSet else { return }
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            initialLocationSet = true
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if manager.authorizationStatus == .authorizedWhenInUse {
                mapView.showsUserLocation = true
            }
        }

    @IBAction func kaydetTiklandi(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let yeniYer = NSEntityDescription.insertNewObject(forEntityName: "Yer", into: context)
        
        yeniYer.setValue(isimTextField.text, forKey: "isim")
        yeniYer.setValue(notTextField.text, forKey: "not")
        yeniYer.setValue(secilenLatitude, forKey: "latitude")
        yeniYer.setValue(secilenLongitude, forKey: "longitude")
        yeniYer.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("kayıt edildi")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "verilerGirildi"), object: nil)
                   navigationController?.popViewController(animated: true)
            
        } catch {
            print("hata")
        }
        
        

    }
    
}

