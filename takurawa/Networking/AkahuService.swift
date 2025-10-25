//
//  ClientAPI.swift
//  takurawa
//
//  Created by Angus Quigley on 25/10/2025.
//

import Foundation

//-- https://developers.akahu.nz/reference/get_accounts
struct GetAllAccountsResponse: Decodable {
    let success: Bool
    let items: [Account]
}

func refreshAccountData(USER_TOKEN: String, APP_TOKEN: String) async throws {
    //-- Refresh to obtain the latest Akahu Data
    guard let refresh_url = URL(string: "https://api.akahu.io/v1/refresh") else {
            throw URLError(.badURL)
    }
    
    var refresh_request = URLRequest(url: refresh_url)
    refresh_request.httpMethod = "POST"
    refresh_request.addValue("Bearer \(USER_TOKEN)", forHTTPHeaderField: "Authorization")
    refresh_request.addValue(APP_TOKEN, forHTTPHeaderField: "X-Akahu-Id")
    let (_, refresh_response) = try await URLSession.shared.data(for: refresh_request)
    
    guard let httpResponse = refresh_response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            print("Something went wrong: \(refresh_response)")
            throw URLError(.badServerResponse)
        }
}

func fetchAccountData(USER_TOKEN: String, APP_TOKEN: String) async throws -> [Account] {
    
    guard let url = URL(string: "https://api.akahu.io/v1/accounts") else {
            throw URLError(.badURL)
        }
    
    var request = URLRequest(url: url)
    
    request.httpMethod = "GET"
    
    request.addValue("Bearer \(USER_TOKEN)", forHTTPHeaderField: "Authorization")
    request.addValue(APP_TOKEN, forHTTPHeaderField: "X-Akahu-Id")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            print("Something went wrong: \(response)")
            throw URLError(.badServerResponse)
        }

    let decodedJSONData = try JSONDecoder().decode(GetAllAccountsResponse.self, from: data)
    if (decodedJSONData.success) {
        return decodedJSONData.items
    }
    //-- Else return an empty array. A better method would be to handle the error, but I will review this code later!
    else {
        return []
    }
}
