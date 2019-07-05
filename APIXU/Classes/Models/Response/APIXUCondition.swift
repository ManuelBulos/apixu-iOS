import Foundation

extension APIXU {
    public struct Condition: Codable {
        public let text: String?
        public let icon: String?
        public let code: Int?

        enum CodingKeys: String, CodingKey {
            case text = "text"
            case icon = "icon"
            case code = "code"
        }
    }
}
