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
    /** 料金 */
    var price: Int
    /** サブスクリプション開始日 */
    var startDate: Date
    /** 作成日 */
    var createdAt: Date
    /** 更新日 */
    var updatedAt: Date
    /** ユーザ */
    @Relationship(inverse: \User.subscriptions)
    var user: User?
    
    enum CycleType: String, Codable {
        /** 月契約 */
        case MONTH
        /** 年契約 */
        case YEAR
    }
    
    enum StatusType: String, Codable {
        /** アクティブ */
        case ACTIVE
        /** キャンセル */
        case CANCELLED
    }
    
    init(id: String, userId: String, name: String, url: String, cycle: CycleType, price: Int, startDate: Date, status: StatusType, createdAt: Date, updatedAt: Date, user: User? = nil) {
        self.id = id
        self.userId = userId
        self.name = name
        self.url = url
        self.cycle = cycle
        self.price = price
        self.startDate = startDate
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.user = user
    }
}
