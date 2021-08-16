//
//  MockAPIClient.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import Foundation

class MockAPIClient {

    func getJWT(forEmail email: String, completion: @escaping (Result<String, Error>) -> ()) {
        // Simulate successfully fetching a JWT
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            completion(.success(Constants.jwt))
        }
    }

    func getOrders(forUser user: User, completion: @escaping (Result<[Order], Error>) -> ()) {
        // Simulate successfully fetching 3 orders
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let orders = [
                Order(id: 123, description: "2 chocolate cakes"),
                Order(id: 456, description: "1 cheese cake"),
                Order(id: 789, description: "1 carrot cake, extra icing")
            ]
            completion(.success(orders))
        }
    }
}
