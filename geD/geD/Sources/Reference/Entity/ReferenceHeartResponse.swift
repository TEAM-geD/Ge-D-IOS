struct ReferenceHeartResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ReferenceHeartInfo]
}
struct ReferenceHeartInfo: Decodable {
    var referenceIdx: Int
    var referenceName: String
    var referenceThumbnail: String
    var referenceAuthor: String
    var referenceAuthorProfileUrl: String
    var referenceUrl: String
}
