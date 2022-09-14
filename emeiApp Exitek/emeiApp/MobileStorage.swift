
import Foundation

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findBylMEI(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func deleter(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}
