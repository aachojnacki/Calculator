//
//  BitcoinPriceProvider.swift
//
//
//  Created by Adrian Chojnacki on 08/10/2023.
//

import Foundation

public protocol BitcoinPriceProviderProtocol {
    func getBitcoinPrice() async throws -> Float
}

enum BitcoinPriceError: Error {
    case invalidPriceFormat
}

public class BitcoinPriceProvider: BitcoinPriceProviderProtocol {
    private let apiUrl = URL(string: "https://api.api-ninjas.com/v1/cryptoprice?symbol=BTCUSD")!
    private let apiKey = "FTWr4Dgv3TdsbdUQK8YFpg==bWJCyxb76UKFp8pS"
        
    struct BitcoinResponse: Codable {
        let symbol: String
        let price: String
        let timestamp: Int
    }
    
    public init() {}

    public func getBitcoinPrice() async throws -> Float {
        var request = URLRequest(url: apiUrl)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response = try decoder.decode(BitcoinResponse.self, from: data)
        if let price = Float(response.price) {
            return price
        } else {
            throw BitcoinPriceError.invalidPriceFormat
        }
    }
}


