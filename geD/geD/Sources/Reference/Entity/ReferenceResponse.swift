struct ReferenceResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [ReferenceInfo]
            
}
struct ReferenceInfo: Decodable {
    var referenceCategoryIdx: Int
    var referenceIdx: Int
    var referenceThumbnail: String
    var referenceAuthor: String
    var referenceAuthorJob: String
    var referenceAuthorProfileUrl: String
    var referenceUrl: String
}
