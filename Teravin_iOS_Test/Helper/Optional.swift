import Foundation
import UIKit

public extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}

public extension Optional where Wrapped == UIImage {
    var defaultImage: UIImage {
        self ?? UIImage()
    }
}

public extension Optional where Wrapped == Int {
    var emptyInt: Int {
        self ?? 0
    }
}
