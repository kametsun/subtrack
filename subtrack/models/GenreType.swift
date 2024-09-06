//
//  GenreType.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/27.
//

import Foundation

enum GenreType: String, Codable, CaseIterable {
    /** エンタメ */
    case ENTERTAINMENT
    /** 音楽 */
    case MUSIC
    /** 教育 */
    case EDUCATION
    /** 健康 */
    case HEALTH
    /** その他 */
    case OTHER
}
