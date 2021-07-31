struct DetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: DetailInfo?
}
struct DetailInfo: Decodable {
    var projectIdx: Int
    var projectName: String
    var projectThumbNailImageUrl: String
    var projectImageUrl1: String
    var projectDescription1: String
    var projectImageUrl2: String
    var projectDescription2: String
    var projectImageUrl3: String
    var projectDescription3: String
    var applyKakaoLinkUrl: String
    var applyGoogleFoamUrl: String
    var projectLikeStatus: Int
    var projectStatus: Int
}
