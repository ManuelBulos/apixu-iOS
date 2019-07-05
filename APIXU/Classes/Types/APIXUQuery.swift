import Foundation
import CoreLocation

extension APIXU {
    public enum Query {
        /// Latitude, Longitude
        case coordinateString(String, String)

        /// CLLocationCoordinate2D
        case coordinate2D(CLLocationCoordinate2D)

        /// City, zip, metar code, ip
        case string(String)

        /// Returns formatted string
        var value: String {
            switch self {
            case .coordinateString(let latitude, let longitude): return "\(latitude),\(longitude)"
            case .coordinate2D(let coordinates): return "\(String(coordinates.latitude)), \(String(coordinates.longitude))"
            case .string(let value): return value
            }
        }
    }
}
