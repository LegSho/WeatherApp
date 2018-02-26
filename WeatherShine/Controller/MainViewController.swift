//
//  MainVC.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/3/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherConditionPicture: UIImageView!
    @IBOutlet weak var windSpeedPicture: UIImageView!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var windSpeedUnit: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var tempUnitLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var introductionImg: UIImageView!
    
    var locationManager = CLLocationManager()
    var authorizationStatus = CLLocationManager.authorizationStatus()
    
//    var favouriteCities: [City] = []
    var tempUnit: String!
    var windUnit: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLayoutSubviews()
        locationManager.delegate = self
        
        configureLocation { (success) in
            if success {
                self.authorisation()
            }
        }
    /* ova f-ja configureLocation i authorisation rade i da pronadje lokaciju u startu kao zahtev permission-a ali ispuni tek kad ponovo se vratim u MainViewController a i verovatno mi je do logike nesto ali kad odem na "DON'T ALLOW" on ipak prikaze current location.
    */
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        orientateDevice()
        scrollOrientation()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLayoutSubviews()
        collectionView.reloadData()
        scrollOrientation()
        orientateDevice()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func authorisation(){
        if authorizationStatus != .denied {
            DispatchQueue.main.async {
                let dataFunction = DataFunctions()
                dataFunction.getCurrentLocation()
            }
        }
        DispatchQueue.main.async {
            let dataFunction = DataFunctions()
            dataFunction.deleteData()
        }
    }
    
    func temperaturePresentation(temperatureInFahrenheit temp: Double) {
        if let userChoise = UserDefaults.standard.value(forKey: "tempUnit") as? Int {
            if cityNameLbl.text == "" {
                tempUnitLbl.isHidden = true
            }
            tempUnitLbl.isHidden = false
            let temperature = temp
            if userChoise == 0 {
                tempUnit = "°C"
                tempUnitLbl.text = tempUnit
                let result = String(format: "%.0f", (temperature-32) * 5/9)
                self.temperatureLbl.text = result
            } else {
                tempUnit = "°F"
                tempUnitLbl.text = tempUnit
                let result = String(format: "%.0f", temperature)
                self.temperatureLbl.text = result
            }
        }
    }
    
    func windSpeedVelocityPresentation(speed: Double){
        if let userChoise = UserDefaults.standard.value(forKey: "windSpeedUnit") as? Int {
            if windSpeedLbl.text == "" {
                windSpeedUnit.isHidden = true
            }
            windSpeedUnit.isHidden = false
            let windSpeed = speed
            if userChoise == 0 {
                windUnit = "m/s"
                windSpeedUnit.text = windUnit
                let result = String(format: "%.0f", windSpeed)
                self.windSpeedLbl.text = result
            } else {
                windUnit = "km/h"
                windSpeedUnit.text = windUnit
                let result = String(format: "%.0f", (windSpeed * 3.6))
                self.windSpeedLbl.text = result
            }
        }
    }
    
    @IBAction func addNewLocationPressed(_ sender: Any) {
        guard let LVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toLocationViewController) as? LocationsViewController else { return }
        transitionFromLeft(LVC)
    }
    
    @IBAction func userSettingsBtnPressed(_ sender: Any) {
        guard let USVC = storyboard?.instantiateViewController(withIdentifier: SegueConstants.toUserSettingViewController) as? UserSettingsViewController else { return }
        transitionFromRight(USVC)
    }

    func setupView(){
        let function = Functions()
        function.currentDate { (date) in
            self.dateLbl.text = date
        }
        let dataFunction = DataFunctions()
        let favouriteCities = dataFunction.fetchData()
        function.hideOrUnhideFirstImg(favouriteCities: favouriteCities, image: introductionImg)
        print("Number of saved cities:",favouriteCities.count)
        print("Current city:", favouriteCities.last?.name ?? "Current city didn't find.")
        
        self.cityNameLbl.text = favouriteCities.last?.name
        function.hideOrUnhideFirstImg(favouriteCities: favouriteCities, image: introductionImg)
        
        guard let temperature = favouriteCities.last?.temperature else { return }
        temperaturePresentation(temperatureInFahrenheit: temperature)
        
        guard let wind = favouriteCities.last?.windSpeed else { return }
        windSpeedVelocityPresentation(speed: wind)
        
        guard let direction = favouriteCities.last?.windDirection else { return }
        function.windDirectionPresentation(angle: direction, windSpeedPicture: windSpeedPicture)
        
        if let icon = favouriteCities.last?.weatherCondition {
            self.weatherConditionPicture.image = UIImage(named: "\(icon)")
            if icon == "clear-day" {
                backgroundImg.image = UIImage(named: "ClearDay")
            } else if icon == "clear-night" {
                backgroundImg.image = UIImage(named: "ClearNight")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "partly-cloudy-day" {
                backgroundImg.image = UIImage(named: "PartlyCloudyDay")
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "partly-cloudy-night" {
                backgroundImg.image = UIImage(named: "PartlyCloudyNight")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "cloudy" {
                backgroundImg.image = UIImage(named: "CloudyDay")
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "fog" {
                backgroundImg.image = UIImage(named: "Foggy")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else if icon == "rain" {
                backgroundImg.image = UIImage(named: "Rainy")
                cityNameLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                dateLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                temperatureLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                tempUnitLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedUnit.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                windSpeedLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else if icon == "snow" {
                backgroundImg.image = UIImage(named: "SnowDay")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "sleet" {
                backgroundImg.image = UIImage(named: "SleetDay")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else if icon == "wind" {
                backgroundImg.image = UIImage(named: "Windy")
                cityNameLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                dateLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                temperatureLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                tempUnitLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedLbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                windSpeedUnit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
}

/*
 Najveci problem mi predstavlja taj sto ne uspevam da provalim kako bih sve ove fetch-ovane podatke mogao da kad se app upali ponovo, svi podaci update-uju (temperatura, brzina vetra i pravac, stanje vremena).
 */


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataFunction = DataFunctions()
        let listOfCities = dataFunction.fetchData()
        var reversedCities: [City] = []
        let currentCity = listOfCities.last?.name
        let favouriteCitiesReversed : [City] = listOfCities.reversed()
        for city in favouriteCitiesReversed {
            if city.name != currentCity {
                reversedCities.append(city)
            }
        }
        print(favouriteCitiesReversed.count)
        return reversedCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifiers.collectionCellID, for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        let dataFunction = DataFunctions()
        let listOfCities = dataFunction.fetchData()
        
        let currentCity = listOfCities.last?.name
        let favouriteCitiesReversed : [City] = listOfCities.reversed()
        var reversedCities: [City] = []
        for city in favouriteCitiesReversed {
            if city.name != currentCity {
                reversedCities.append(city)
            }
        }
        let city = reversedCities[indexPath.row]
        cell.configureCell(city: city, tempUnit: tempUnit, windSpeedUnit: windUnit)
        return cell
    }
    
    func scrollOrientation(){
        if UIDevice.current.orientation.isPortrait {
            UserDefaults.standard.set(true, forKey: "orientation")
        } else {
            UserDefaults.standard.set(false, forKey: "orientation")
        }
    }
    
    func orientateDevice(){
        let orientation = UserDefaults.standard.value(forKey: "orientation") as! Bool
        if orientation {
            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            scroll?.scrollDirection = .vertical
            collectionView.reloadData()
        } else {
            let scroll = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            scroll?.scrollDirection = .horizontal
            collectionView.reloadData()
        }
    }
    
/* Pokusavao sam svasta pronaci da mi se sa orijentacijom istovremeno promeni i pravac scroll-ovanja collectionView-a ali to se dogodi tek po izlasku iz i ponovnom vracanju u MainVC.
 */
}




