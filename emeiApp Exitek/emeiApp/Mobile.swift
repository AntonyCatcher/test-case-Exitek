
import Foundation

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum DeletionError: Error {
    case somethingWentWrong
}

enum SavingError: Error {
    case cannotSave
}
