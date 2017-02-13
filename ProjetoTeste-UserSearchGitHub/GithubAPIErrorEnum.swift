import Foundation


/// Github API Errors
///
/// - NetworkError: Network error
/// - DatabaseError: Database error
enum GithubAPIErrorEnum: Error {
    case NetworkError
    case DatabaseError
}
