import Foundation

extension APIXU {
    public struct ErrorCode: Codable {
        public let code: Int?
        public let message: String?

        enum CodingKeys: String, CodingKey {
            case code = "code"
            case message = "message"
        }
    }
}
