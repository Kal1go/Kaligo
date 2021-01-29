//
//  ListHandler.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import Endpoints_Requests

enum ListLoadResponse: Error {
    case success(answer: Lists)
    case error(description: String)
}

enum ListOneResponse: Error {
    case success(answer: List)
    case error(description: String)
}

class ListHandler {
    public static let BASE_URL: String = "\(Environment.SERVER_URL)/list"

    static func create(list: List, withCompletion completion: @escaping (ListOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/create",
                                params: list.dictionaryRepresentation,
                                decodableType: ServerAnswer<List>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<List>):
                if answer.success ?? false {
                    if let list = answer.content {
                        completion(ListOneResponse.success(answer: list))
                    } else {
                        completion(ListOneResponse.error(description: (String(describing: "Not have list"))))
                    }
                } else {
                    completion(ListOneResponse.error(description: (String(describing: answer.message))))
                }
            case .error(let error):
                completion(ListOneResponse.error(description: error.localizedDescription))
            default:
                completion(ListOneResponse.error(description: "Error to convert data"))
            }
        }
    }

    static func getLast(withNumber number: Int, withCompletion completion: @escaping (ListLoadResponse) -> Void) {
        EndpointsRequests
            .getRequest(
                url: "\(BASE_URL)/get/last/\(number)",
                decodableType: ServerAnswer<Lists>.self
            ) { (response) in
                switch response {
                case .result(let answer as ServerAnswer<Lists>):
                    if answer.success ?? false {
                        let lists = answer.content ?? []
                        completion(ListLoadResponse.success(answer: lists))
                    } else {
                        completion(ListLoadResponse.error(description: answer.message ?? ""))
                    }
                case .error(let error):
                    completion(ListLoadResponse.error(description: error.localizedDescription))
                default:
                    completion(ListLoadResponse.error(description: "Error to convert data"))
                }
            }
    }
    
    static func getOne(id: String, withCompletion
        completion: (ListOneResponse) -> Void) {
        completion(ListOneResponse.error(description: "Not implementation"))
    }
    
    static func fork(params: List,
                     withCompletion completion: @escaping (ListOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/fork",
                                params: params.fork,
                                decodableType: ServerAnswer<List>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<List>):
                guard let result = answer.success,
                    let list = answer.content,
                    result

                    else {
                        if let message = answer.message {
                            completion(ListOneResponse
                                .error(description: message))
                        } else {
                            completion(ListOneResponse
                                .error(description: "Answer is false"))
                        }
                        return
                }
                completion(ListOneResponse.success(answer: list))
            case .error(let error):
                completion(ListOneResponse.error(description: error.localizedDescription))
            default:
                completion(ListOneResponse.error(description: "Error to convert data"))
            }
        }
    }
    static func update(params: List, withCompletion completion: @escaping (ListOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/update",
                                params: params.dictionaryRepresentation,
                                decodableType: ServerAnswer<List>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<List>):
                guard let result = answer.success,
                    let list = answer.content,
                    result

                    else {
                        if let message = answer.message {
                            completion(ListOneResponse
                                .error(description: message))
                        } else {
                            completion(ListOneResponse
                                .error(description: "Answer is false"))
                        }
                        return
                }
                completion(ListOneResponse.success(answer: list))
            case .error(let error):
                completion(ListOneResponse.error(description: error.localizedDescription))
            default:
                completion(ListOneResponse.error(description: "Error to convert data"))
            }
        }
    }
    public static func deleteOne(id: String, completion: @escaping (ListOneResponse) -> Void) {
        EndpointsRequests
            .getRequest(
                url: "\(BASE_URL)/delete/\(id)",
                decodableType: ServerAnswer<List>.self
            ) { (response) in
                switch response {
                case .result(let answer as ServerAnswer<List>):
                    if (answer.success ?? false), let list = answer.content {
                        completion(ListOneResponse.success(answer: list))
                    } else {
                        completion(ListOneResponse.error(description: answer.message ?? ""))
                    }
                case .error(let error):
                    completion(ListOneResponse.error(description: error.localizedDescription))
                default:
                    completion(ListOneResponse.error(description: "Error to convert data"))
                }
        }

    }
}
