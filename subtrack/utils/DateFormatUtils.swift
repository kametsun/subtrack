//
//  DateFormatUtils.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/23.
//

import Foundation

func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    return dateFormatter.string(from: date)
}
