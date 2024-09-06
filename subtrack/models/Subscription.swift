//
//  Subscription.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation
import SwiftData

/**
 * サブスクリプションの元となるクラス
 */
@Model
final class Subscription {
    /** ID */
    @Attribute(.unique)
    var id: String
    /** ユーザID */
    var userId: String
    /** サブスクリプション名 */
    var name: String
    /** URL */
    var url: String
    /** 更新サイクル */
    var cycle: CycleType
    /** ステータス */
    var status: StatusType
    /** 通過 */
    var currency: CurrencyType
    /** 料金 */
    var price: Double
    /** サブスクリプション開始日 */
    var startDate: Date
    /** 作成日 */
    var createdAt: Date
    /** 更新日 */
    var updatedAt: Date
    /** ユーザ */
    @Relationship(inverse: \User.subscriptions)
    var user: User?

    enum CycleType: String, Codable, CaseIterable {
        /** 月契約 */
        case MONTH
        /** 年契約 */
        case YEAR
    }

    enum StatusType: String, Codable, CaseIterable {
        /** アクティブ */
        case ACTIVE
        /** キャンセル */
        case CANCELLED
    }

    init(
        id: String,
        userId: String,
        name: String,
        url: String,
        cycle: CycleType,
        currency: CurrencyType,
        price: Double,
        startDate: Date,
        status: StatusType,
        user: User? = nil
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.url = url
        self.cycle = cycle
        self.currency = currency
        self.price = price
        self.startDate = startDate
        self.status = status
        self.createdAt = Date()
        self.updatedAt = Date()
        self.user = user
    }

    /**
     * 次回のサブスクリプションの更新日を返す
     */
    func nextRenewalDate() -> Date? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo") ?? TimeZone.current
        switch cycle {
        case .MONTH:
            return calendar.date(byAdding: .month, value: 1, to: startDate)
        case .YEAR:
            return calendar.date(byAdding: .year, value: 1, to: startDate)
        }
    }

    /**
     * favicon.icoを返す
     */
    func getFaviconURL() -> URL? {
        guard let url = URL(string: self.url) else { return nil}
        return URL(string: "\(url.scheme ?? "https")://\(url.host ?? "")/favicon.ico")
    }
}
