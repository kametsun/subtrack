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
    var id: String
    var name: String
    var notifyBeforeDays: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, name: String, notifyBeforeDays: Int, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.name = name
        self.notifyBeforeDays = notifyBeforeDays
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
