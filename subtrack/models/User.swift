//
//  User.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/18.
//

import Foundation
import SwiftData

/**
 * ユーザ情報の元となるクラス
 */
@Model
final class User {
    /** ID */
    @Attribute(.unique)
    var id: String
    /** 名前 */
    var name: String
    /** 何日前に通知するか */
    var notifyBeforeDays: Int
    /** 作成日 */
    var createdAt: Date
    /** 更新日 */
    var updatedAt: Date
    /** サブスクリプション */
    @Relationship(deleteRule: .cascade)
    var subscriptions: [Subscription]

    init(
        id: String,
        name: String,
        notifyBeforeDays: Int,
        createdAt: Date,
        updatedAt: Date,
        subscriptions: [Subscription]
    ) {
        self.id = id
        self.name = name
        self.notifyBeforeDays = notifyBeforeDays
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.subscriptions = subscriptions
    }
}
