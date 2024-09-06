//
//  GetFaviconURL.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/09/06.
//

import Foundation

/**
 * favicon.icoを返す
 */
func getFaviconURL(url: String) -> URL? {
    guard let url = URL(string: url) else { return nil}
    return URL(string: "\(url.scheme ?? "https")://\(url.host ?? "")/favicon.ico")
}
