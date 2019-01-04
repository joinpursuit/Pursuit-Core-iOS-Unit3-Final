import Foundation

enum AppError: Error {
  case badURL(String)
  case networkError(Error)
  case noResponse
  case decodingError(Error)
  
  public func errorMessage() -> String {
    switch self {
    case .badURL(let str):
      return "badURL: \(str)"
    case .networkError(let error):
      return "networkError: \(error)"
    case .noResponse:
      return "no network response"
    case .decodingError(let error):
      return "decoding error: \(error)"
    }
  }
  public func userErrorMessage() -> String {
    switch self {
    case .badURL(let str):
      return "Error:023 Network Error Occurred"
    case .networkError(let error):
      return "Error:077 Network Error Occurred"
    case .noResponse:
      return "Error:083 Network Error Occurred"
    case .decodingError(let error):
      return "Error:069 Malformed Data Error Occurred"
    }
  }
}
