import Foundation

extension UserDefaults {
    func resetBooks() {
        removeObject(forKey: Constants.saveBooksKey)
    }
}
