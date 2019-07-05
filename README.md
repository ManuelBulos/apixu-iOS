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
Access all APIs (search, current, forecast, history) with a query.
```swift
    // Initialize with your own API Key
    let apixu: APIXU = APIXU(key: "yourAPIKey", debuggingEnabled: false)
    
    // New York coordinates
    let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
    
    // String for query
    let city: String = "New York"
    
    // Date in yyyy-MM-dd format
    let date: String = "2019-06-06"

    // Search with coordinates
    apixu.search(matching: .coordinate2D(coordinates)) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            // [APIXU.SearchResponse] object
            print(response.map({ $0.country })) // list of countries for the given coordinates
        case .failure(let error):
            self.showAlert(with: error) 
        }
    }
    
    // Search with string
    apixu.search(matching: .string(city)) { [weak self] (result) in
        guard let self = self else { return }
        switch result {
        case .success(let response):
            // [APIXU.SearchResponse] object
            print(response.map({ $0.country })) // list of countries for the given string
        case .failure(let error):
            self.showAlert(with: error) 
        }
    }
    
    // Current (also works using string instead of coordinates)
    apixu.current(matching: .coordinate2D(coordinates)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                    self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Current object
                    print(response.current)
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
    }
      
    // Forecast (also works using string instead of coordinates)
    apixu.forecast(matching: .coordinate2D(coordinates), days: 5) { [weak self] (result) in
        guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                    self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Forecast object
                    print(response.forecast)
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
    }
    
    // History (also works using string instead of coordinates)
    apixu.history(matching: .coordinate2D(coordinates), date: date) { [weak self] (result) in
        guard let self = self else { return }
            switch result {
            case .success(let response):
                if let errorMessage = response.error?.message {
                    self.showAlert(with: errorMessage)
                } else {
                    // APIXU.Forecast object
                    /* History weather API method returns historical weather 
                    for a date on or after 1st Jan, 2015. 
                    The data is returned as a Forecast Object.*/
                    print(response.forecast)
                }
            case .failure(let error):
                self.showAlert(with: error)
            }
    }
```

## Query type
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

## Models
[SearchResponse](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Search/APIXUSearchResponse.swift)

[Response](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Response/APIXUResponse.swift)

[Location](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Response/APIXULocation.swift)

[ErrorCode](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Response/APIXUErrorCode.swift)

[Current](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Current/APIXUCurrent.swift)

[Condition](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Response/APIXUCondition.swift)

[Forecast](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Forecast/APIXUForecast.swift)

[ForecastDay](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Forecast/APIXUForecastday.swift)

[Day](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Forecast/APIXUDay.swift)

[Astro](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Forecast/APIXUAstro.swift)

[Hour](https://github.com/ManuelBulos/apixu-iOS/blob/master/Models/Forecast/APIXUHour.swift)


##

## Documentation
Official docs: https://www.apixu.com/doc/

## Author

manuelbulos, manuelbulos@gmail.com

## License

APIXU is available under the MIT license. See the LICENSE file for more info.
