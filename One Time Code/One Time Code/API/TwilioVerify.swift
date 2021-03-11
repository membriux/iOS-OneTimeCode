//
//  Twilio.swift
//  One Time Code
//
//  Created by Memo on 3/11/21.
//


import UIKit
import Foundation


struct VerifyAPI {
    
    // MODIFY THIS TO YOUR SPECIFIC HEROKU SERVER
    private static let baseURLString = "HEROKU_SERVER_URL"

    static func createRequest(_ path: String,
                              _ parameters: [String: String],
                              completionHandler: @escaping (_ result: Data) -> VerifyResult) {

        let urlPath = "\(baseURLString)/\(path)"
        var components = URLComponents(string: urlPath)!

        var queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }

        components.queryItems = queryItems

        let url = components.url!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()

        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            if let jsonData = data {
                let result = completionHandler(jsonData)
                print(result)
            } else {
                // error, no data returned
            }
        }
        task.resume()
    }

    static func sendVerificationCode(_ countryCode: String, _ phoneNumber: String) {
        let parameters = [
            "via": "sms",
            "country_code": countryCode,
            "phone_number": phoneNumber
        ]

        createRequest("start", parameters) {
            json in
            return .success(DataResult(data: json))
        }
    }

    static func validateVerificationCode(_ countryCode: String, _ phoneNumber: String, _ code: String, segue: @escaping (CheckResult) -> Void) {

        let parameters = [
            "via": "sms",
            "country_code": countryCode,
            "phone_number": phoneNumber,
            "verification_code": code
        ]

        createRequest("check", parameters) {
            jsonData in

            let decoder = JSONDecoder()
            do {
                let checked = try decoder.decode(CheckResult.self, from: jsonData)
                DispatchQueue.main.async(execute: {
                    segue(checked)
                })
                return VerifyResult.success(checked)
            } catch {
                return VerifyResult.failure(VerifyError.err("failed to deserialize"))
            }
        }
    }
}



enum VerifyError: Error {
    case invalidUrl
    case err(String)
}


protocol WithMessage {
    var message: String { get }
}

enum VerifyResult {
    case success(WithMessage)
    case failure(Error)
}


class DataResult: WithMessage {
    let data: Data
    let message: String

    init(data: Data) {
        self.data = data
        self.message = String(describing: data)
    }
}

struct CheckResult: Codable, WithMessage {
    let success: Bool
    let message: String
}


