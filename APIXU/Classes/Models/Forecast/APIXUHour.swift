import Foundation

extension APIXU {
    public struct Hour: Codable {
        public let timeEpoch: Int?
        public let time: String?
        public let tempC: Double?
        public let tempF: Double?
        public let isDay: Int?
        public let condition: Condition?
        public let windMph: Double?
        public let windKph: Double?
        public let windDegree: Int?
        public let windDir: String?
        public let pressureMb: Double?
        public let pressureIn: Double?
        public let precipMm: Double?
        public let precipIn: Double?
        public let humidity: Int?
        public let cloud: Int?
        public let feelslikeC: Double?
        public let feelslikeF: Double?
        public let windchillC: Double?
        public let windchillF: Double?
        public let heatindexC: Double?
        public let heatindexF: Double?
        public let dewpointC: Double?
        public let dewpointF: Double?
        public let willItRain: Int?
        public let chanceOfRain: String?
        public let willItSnow: Int?
        public let chanceOfSnow: String?
        public let visKm: Double?
        public let visMiles: Double?
        public let gustMph: Double?
        public let gustKph: Double?

        enum CodingKeys: String, CodingKey {
            case timeEpoch = "time_epoch"
            case time = "time"
            case tempC = "temp_c"
            case tempF = "temp_f"
            case isDay = "is_day"
            case condition = "condition"
            case windMph = "wind_mph"
            case windKph = "wind_kph"
            case windDegree = "wind_degree"
            case windDir = "wind_dir"
            case pressureMb = "pressure_mb"
            case pressureIn = "pressure_in"
            case precipMm = "precip_mm"
            case precipIn = "precip_in"
            case humidity = "humidity"
            case cloud = "cloud"
            case feelslikeC = "feelslike_c"
            case feelslikeF = "feelslike_f"
            case windchillC = "windchill_c"
            case windchillF = "windchill_f"
            case heatindexC = "heatindex_c"
            case heatindexF = "heatindex_f"
            case dewpointC = "dewpoint_c"
            case dewpointF = "dewpoint_f"
            case willItRain = "will_it_rain"
            case chanceOfRain = "chance_of_rain"
            case willItSnow = "will_it_snow"
            case chanceOfSnow = "chance_of_snow"
            case visKm = "vis_km"
            case visMiles = "vis_miles"
            case gustMph = "gust_mph"
            case gustKph = "gust_kph"
        }
    }
}
