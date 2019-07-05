import Foundation

extension APIXU {
    public struct Forecast: Codable {
        public let forecastday: [Forecastday]?

        enum CodingKeys: String, CodingKey {
            case forecastday = "forecastday"
        }
    }
}
