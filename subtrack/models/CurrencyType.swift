//
//  CurrencyType.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/25.
//

import Foundation

enum CurrencyType: String, Codable, CaseIterable {
    /** 日本円 */
    case JPY
    /** 米ドル */
    case USD
    /** ユーロ */
    case EUR

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
