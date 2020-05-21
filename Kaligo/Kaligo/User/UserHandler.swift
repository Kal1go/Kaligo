//
//  UserHandler.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import Endpoints_Requests

enum UserLoadResponse: Error {
    case success(answer: Users)
    case error(description: String)
}

enum UserOneResponse: Error {
    case success(answer: User)
    case error(description: String)
}

class UserHandler {
    public static let BASE_URL: String = "\(Environment.SERVER_URL)/user"

    static func create(user: User, withCompletion completion: @escaping (UserOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/create",
                                params: user.dictionaryRepresentation,
                                decodableType: ServerAnswer<User>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<User>):
                if answer.success ?? false {
                    if let user = answer.content {
                        completion(UserOneResponse.success(answer: user))
                    } else {
                        completion(UserOneResponse.error(description: (String(describing: "Not have user"))))
                    }
                } else {
                    completion(UserOneResponse.error(description: (String(describing: answer.message))))
                }
            case .error(let error):
                completion(UserOneResponse.error(description: error.localizedDescription))
            default:
                completion(UserOneResponse.error(description: "Error to convert data"))
            }
        }
    }
    struct AuthAnswer: Codable {
        var success: Bool?
        var content: String?
    }

    static func auth(params: [String: Any], withCompletion completion: @escaping (UserOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/auth",
                                params: params,
                                decodableType: ServerAnswer<User>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<User>):
                guard let user = answer.content else {
                    if let message = answer.message {
                        completion(UserOneResponse.error(description: message))
                    } else {
                        completion(UserOneResponse.error(description: "Error to convert datas"))
                    }

                    return
                }
                completion(UserOneResponse.success(answer: user))
            case .error(let error):
                completion(UserOneResponse.error(description: error.localizedDescription))
            default:
                completion(UserOneResponse.error(description: "Error to convert data"))
            }
        }
    }

    static func getAll(userID: String, withCompletion completion: @escaping (UserLoadResponse) -> Void) {
        completion(UserLoadResponse.error(description: "Not implementation"))

    }
    static func getOne(id: String, withCompletion
        completion: (UserOneResponse) -> Void) {
        completion(UserOneResponse.error(description: "Not implementation"))

    }
    static func update(user: User, withCompletion completion: (UserOneResponse) -> Void) {
        completion(UserOneResponse.error(description: "Not implementation"))

    }
    public static func delete(id: Int, completion: @escaping (UserOneResponse) -> Void) {
        completion(UserOneResponse.error(description: "Not implementation"))

    }
}
