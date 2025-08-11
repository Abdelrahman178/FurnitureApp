//
//  Bundle+Localization.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 06/08/2025.
//

import Foundation
import ObjectiveC

private var bundleKey: UInt8 = 0

extension Bundle {
    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, PrivateBundle.self)
        }

        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let langBundle = Bundle(path: path)
        objc_setAssociatedObject(Bundle.main, &bundleKey, langBundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private class PrivateBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            let customBundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle
            return customBundle?.localizedString(forKey: key, value: value, table: tableName)
                ?? super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
