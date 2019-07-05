import Foundation

extension APIXU {
    public struct Day: Codable {
        public let maxTempC: Double?
        public let maxTempF: Double?
        public let minTempC: Double?
        public let minTempF: Double?
        public let avgTempC: Double?
        public let avgTempF: Double?
        public let maxWindMph: Double?
        public let maxWindKph: Double?
        public let totalPrecipMm: Double?
        public let totalPrecipIn: Double?
        public let avgVisKm: Double?
        public let avgVisMiles: Double?
        public let avgHumidity: Double?
        public let condition: Condition?
        public let uv: Double?

        enum CodingKeys: String, CodingKey {
            case maxTempC = "maxtemp_c"
            case maxTempF = "maxtemp_f"
            case minTempC = "mintemp_c"
            case minTempF = "mintemp_f"
            case avgTempC = "avgtemp_c"
            case avgTempF = "avgtemp_f"
            case maxWindMph = "maxwind_mph"
            case maxWindKph = "maxwind_kph"
            case totalPrecipMm = "totalprecip_mm"
            case totalPrecipIn = "totalprecip_in"
            case avgVisKm = "avgvis_km"
            case avgVisMiles = "avgvis_miles"
            case avgHumidity = "avghumidity"
            case condition = "condition"
            case uv = "uv"
        }
    }
}
