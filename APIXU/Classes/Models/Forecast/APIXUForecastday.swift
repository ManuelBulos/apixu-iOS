import Foundation

extension APIXU {
    public struct Forecastday: Codable {
        public let date: String?
        public let dateEpoch: Int?
        public let day: Day?
        public let astro: Astro?
        public let hour: [Hour]?

        enum CodingKeys: String, CodingKey {
            case date = "date"
            case dateEpoch = "date_epoch"
            case day = "day"
            case astro = "astro"
            case hour = "hour"
        }
    }
}
