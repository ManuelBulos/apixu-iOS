import Foundation

extension APIXU {
    public struct Astro: Codable {
        public let sunrise: String?
        public let sunset: String?
        public let moonrise: String?
        public let moonset: String?

        enum CodingKeys: String, CodingKey {
            case sunrise = "sunrise"
            case sunset = "sunset"
            case moonrise = "moonrise"
            case moonset = "moonset"
        }
    }
}
