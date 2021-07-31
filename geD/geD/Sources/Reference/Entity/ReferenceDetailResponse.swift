struct ReferenceDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ReferenceDetailInfo
}

struct ReferenceDetailInfo: Decodable {
    var referenceIdx: Int
    var referenceUrl: String
}
