//
//  CurrencyType.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/25.
//

import Foundation

enum CurrencyType: String, Codable, CaseIterable, CustomStringConvertible {
    /** 日本円 */
    case JPY
    /** 米ドル */
    case USD
    /** ユーロ */
    case EUR

    var description: String {
        return self.rawValue
    }

    static func currencyIcon(for currencyType: CurrencyType) -> String {
        switch currencyType {
        case .JPY:
            return "yensign"
        case .USD:
            return "dollarsign"
        case .EUR:
            return "eurosign"
        }
    }
}
