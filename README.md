# APIXU

[![CI Status](https://img.shields.io/travis/manuelbulos/APIXU.svg?style=flat)](https://travis-ci.org/manuelbulos/APIXU)
[![Version](https://img.shields.io/cocoapods/v/APIXU.svg?style=flat)](https://cocoapods.org/pods/APIXU)
[![License](https://img.shields.io/cocoapods/l/APIXU.svg?style=flat)](https://cocoapods.org/pods/APIXU)
[![Platform](https://img.shields.io/cocoapods/p/APIXU.svg?style=flat)](https://cocoapods.org/pods/APIXU)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 10 *

## Installation

APIXU is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'APIXU'
```

## Usage
Access all APIs (search, current, forecast, history) with a query object.
```swift
    // Initialize with your own API Key
    let apixu: APIXU = APIXU(key: "yourAPIKey", debuggingEnabled: false)

    apixu.search(matching: .coordinate2D(coordinates)) { (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            // [APIXU.SearchResponse]
            print(response.map({ $0.country })) // list of countries for the given coordinates
        case .failure(let error):
            self.showAlert(with: error) 
        }
    }
    
    apixu.search(matching: .string("New York")) { (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            // [APIXU.SearchResponse]
            print(response.map({ $0.country })) // list of countries for the given string
        case .failure(let error):
            self.showAlert(with: error) 
        }
    }
```

## Query object
```swift
    public enum Query {
        /// Latitude, Longitude
        case coordinateString(String, String)

        /// CLLocationCoordinate2D
        case coordinate2D(CLLocationCoordinate2D)

        /// City, zip, metar code, ip
        case string(String)
    }
```

## Example (ViewController.swift)
```swift
import UIKit
import APIXU
import CoreLocation

class ViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!

    // MARK: - Properties

    // Initialize with your own API Key
    private let apixu: APIXU = APIXU(key: "", debuggingEnabled: false)

    // Updates userCoordinates
    private let locationManager: CLLocationManager = CLLocationManager()

    // userCoordinates updates only if it's more than 5000 meters away from last location
    private let maximumDistance: Double = 5000

    private var userCoordinates: CLLocationCoordinate2D? {
        didSet {
            guard let coordinates = userCoordinates else { return }
            getCurrent(for: coordinates)
        }
    }

    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // Search
    private func performSearch(for coordinates: CLLocationCoordinate2D) {
        apixu.search(matching: .coordinate2D(coordinates)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
            // [APIXU.SearchResponse]
            print(response.map({ $0.country }))
            case .failure(let error):
            self.showAlert(with: error) 
            }
        }
    }

    // Current
    private func getCurrent(for coordinates: CLLocationCoordinate2D) {
        apixu.current(matching: .coordinate2D(coordinates)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                    self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Current
                    guard let current = response.current else { return }
                    self.handleCurrent(current)
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }

    // Forecast
    private func getForecast(for coordinates: CLLocationCoordinate2D) {
        apixu.forecast(matching: .coordinate2D(coordinates), days: 5) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                    self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Forecast
                    print(response.forecast?.forecastday?.first?.day?.avgTempC ?? String())
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }

    // History
    private func getHistory(for coordinates: CLLocationCoordinate2D, from date: String) {
        apixu.history(matching: .coordinate2D(coordinates), date: date) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Response
                    print(response)
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
        }
    }

    private func handleCurrent(_ current: APIXU.Current) {
        guard let temperature: Double = current.tempC else { return }
        guard let condition: String = current.condition?.text else { return }
        self.temperatureLabel.text = "\(String(format: "%.0f", temperature))º"
        self.conditionLabel.text = condition

        guard let realURLString = current.condition?.icon?.dropFirst(2) else { return }
        guard let conditionIconURL = URL(string: "https://\(realURLString)") else { return }

        URLSession.shared.dataTask(with: conditionIconURL) { (data, _, error) in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.conditionImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newCoordinates = locations.last?.coordinate else { return }
        if let oldCoordinates = userCoordinates {
            let newLocation = CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude)
            let oldLocation = CLLocation(latitude: oldCoordinates.latitude, longitude: oldCoordinates.longitude)
            if oldLocation.distance(from: newLocation) > maximumDistance { userCoordinates = newCoordinates }
        } else {
            userCoordinates = newCoordinates
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        verifyAuthorization(status: status, manager: manager)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(with: error)
    }

    private func verifyAuthorization(status: CLAuthorizationStatus, manager: CLLocationManager) {
        DispatchQueue.main.async { [weak self] in
            if CLLocationManager.locationServicesEnabled() &&
                status == .authorizedAlways ||
                status == .authorizedWhenInUse {
                manager.startUpdatingLocation()
            } else if status == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else {
                guard let self = self else { return }
                self.showSettingsAlert()
            }
        }
    }
}

// MARK: - Alerts

extension ViewController {
    func showSettingsAlert() {
        let alert = UIAlertController(title: "Location Services disabled",
        message: "Please enable Location Services in Settings", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)")
                })
            }
        }
        alert.addAction(settingsAction)
        present(alert, animated: true)
    }

    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func showAlert(with error: Error) {
        showAlert(with: error.localizedDescription)
    }
}
```

## Author

manuelbulos, manuelbulos@gmail.com

## License

APIXU is available under the MIT license. See the LICENSE file for more info.
