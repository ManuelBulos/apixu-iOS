import Foundation

extension APIXU {
    public struct SearchResponse: Codable {
        public let id: Int?
        public let name: String?
        public let region: String?
        public let country: String?
        public let latitude: Double?
        public let longitude: Double?
        public let url: String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case region = "region"
            case country = "country"
            case latitude = "lat"
            case longitude = "lon"
            case url = "url"
        }
    }
}
