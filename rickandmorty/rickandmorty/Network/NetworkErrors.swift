import Foundation

enum NetworkFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
    case internalError = 500
}
