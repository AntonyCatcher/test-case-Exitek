
import UIKit

extension ViewController: MobileStorage {
    
    func imeiGenerator() -> String {
        let A = String(format: "%02d", Int.random(in: 1...99))
        let B = String(format: "%06d", Int.random(in: 1...999_999))
        let C = String(format: "%06d", Int.random(in: 1...999_999))
        let D = String(format: "%01d", Int.random(in: 1...9))
        let dash = "-"
        return A + dash + B + dash + C + dash + D
    }
    
    func getAll() -> Set<Mobile> {
        var set: Set<Mobile> = []
        for i in 1...manufacturer.count {
            set.insert(Mobile(imei: self.imeiGenerator(),
                             model: manufacturer[i-1]))
        }
        return set
    }
    
    func findBylMEI(_ imei: String) -> Mobile? {
        if (database.contains { $0.imei == imei }) {
            return database.first { $0.imei == imei }
        } else {
            return nil
        }
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if mobile.imei.isEmpty && mobile.model.isEmpty {
            throw SavingError.cannotSave
        }
        return mobile
    }
    
    func deleter(_ product: Mobile) throws {
        if product.imei.isEmpty || product.model.isEmpty {
            throw DeletionError.somethingWentWrong
        }
        database.remove(product)
    }
    
    func exists(_ product: Mobile) -> Bool {
        return database.contains { $0 == product }
    }
}
