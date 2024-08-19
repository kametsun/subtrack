//
//  UserRepository.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation
import SwiftData

class UserRepository {
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func registerUser(user: User) throws {
        modelContext.insert(user)
        try modelContext.save()
    }

    func getUser() throws -> User? {
        let fetchDescriptor = FetchDescriptor<User>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(fetchDescriptor).first
    }
}
