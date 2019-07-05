import Foundation

extension APIXU {
    public struct Current: Codable {
        public let lastUpdatedEpoch: Int?
        public let lastUpdated: String?
        public let tempC: Double?
        public let tempF: Double?
        public let isDay: Int?
        public let condition: Condition?
        public let windMph: Double?
        public let windKph: Double?
        public let windDegree: Int?
        public let windDirection: String?
        public let pressureMb: Double?
        public let pressureIn: Double?
        public let precipMm: Double?
        public let precipIn: Double?
        public let humidity: Int?
        public let cloud: Int?
        public let feelslikeC: Double?
        public let feelslikeF: Double?
        public let visKm: Double?
        public let visMiles: Double?
        public let uv: Double?
        public let gustMph: Double?
        public let gustKph: Double?

        enum CodingKeys: String, CodingKey {
            case lastUpdatedEpoch = "last_updated_epoch"
            case lastUpdated = "last_updated"
            case tempC = "temp_c"
            case tempF = "temp_f"
            case isDay = "is_day"
            case condition = "condition"
            case windMph = "wind_mph"
            case windKph = "wind_kph"
            case windDegree = "wind_degree"
            case windDirection = "wind_dir"
            case pressureMb = "pressure_mb"
            case pressureIn = "pressure_in"
            case precipMm = "precip_mm"
            case precipIn = "precip_in"
            case humidity = "humidity"
            case cloud = "cloud"
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case visKm = "vis_km"
            case visMiles = "vis_miles"
            case uv = "uv"
            case gustMph = "gust_mph"
            case gustKph = "gust_kph"
        }
    }
}
