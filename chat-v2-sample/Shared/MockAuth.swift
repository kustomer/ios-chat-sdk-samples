//
//  MockAuth.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import Foundation

class MockAuth {

    static let shared = MockAuth()

    var currentUser: User?

    func logIn(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> ()) {
        // Simulate log in success
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let user = User(email: email)
            self.currentUser = user
            completion(.success(user))
        }
    }

    func logOut() {
        // Simulate log out success
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentUser = nil
        }
    }
}
