struct ProjectResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [projectInfo]?
}
struct projectInfo: Decodable{
    var projectIdx: Int
    var projectThumbnailImageUrl: String
    var projectName: String
    var projectJobNameList: [String]
    var userIdx: Int
    var userName: String
    var userJob: String?
    var userProfileImageUrl: String?
}
