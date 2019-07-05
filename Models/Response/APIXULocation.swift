import Foundation

extension APIXU {
    public struct Location: Codable {
        public let name: String?
        public let region: String?
        public let country: String?
        public let latitude: Double?
        public let longitude: Double?
        public let tzID: String?
        public let localTimeEpoch: Int?
        public let localTime: String?

        enum CodingKeys: String, CodingKey {
            case name = "name"
            case region = "region"
            case country = "country"
            case latitude = "lat"
            case longitude = "lon"
            case tzID = "tz_id"
            case localTimeEpoch = "localtime_epoch"
            case localTime = "localtime"
        }
    }
}
