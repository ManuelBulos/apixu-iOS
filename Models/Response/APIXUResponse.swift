import Foundation

extension APIXU {
    public struct Response: Codable {
        public let location: Location?
        public let current: Current?
        public let forecast : Forecast?
        public let error: ErrorCode?

        enum CodingKeys: String, CodingKey {
            case location = "location"
            case current = "current"
            case forecast = "forecast"
            case error = "error"
        }
    }
}
