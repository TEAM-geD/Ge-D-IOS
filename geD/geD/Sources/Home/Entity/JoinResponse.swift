struct JoinResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
