//
//  StepHandler.swift
//  Kaligo
//
//  Created by Matheus Silva on 21/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import Endpoints_Requests

enum StepLoadResponse: Error {
    case success(answer: Steps)
    case error(description: String)
}

enum StepOneResponse: Error {
    case success(answer: Step)
    case error(description: String)
}

class StepHandler {
    public static let BASE_URL: String = "\(Environment.SERVER_URL)/step"

    static func create(step: Step, withCompletion completion: @escaping (StepOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/create",
                                params: step.dictionaryRepresentation,
                                decodableType: ServerAnswer<Step>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<Step>):
                if answer.success ?? false {
                    if let step = answer.content {
                        completion(StepOneResponse.success(answer: step))
                    } else {
                        completion(StepOneResponse.error(description: (String(describing: "Not have step"))))
                    }
                } else {
                    completion(StepOneResponse.error(description: (String(describing: answer.message))))
                }
            case .error(let error):
                completion(StepOneResponse.error(description: error.localizedDescription))
            default:
                completion(StepOneResponse.error(description: "Error to convert data"))
            }
        }
    }

    static func getAll(withCompletion completion: @escaping (StepLoadResponse) -> Void) {
        EndpointsRequests
            .getRequest(
                url: "\(BASE_URL)/get/all",
                decodableType: ServerAnswer<Steps>.self
            ) { (response) in
                switch response {
                case .result(let answer as ServerAnswer<Steps>):
                    if answer.success ?? false {
                        let steps = answer.content ?? []
                        completion(StepLoadResponse.success(answer: steps))
                    } else {
                        completion(StepLoadResponse.error(description: answer.message ?? ""))
                    }
                case .error(let error):
                    completion(StepLoadResponse.error(description: error.localizedDescription))
                default:
                    completion(StepLoadResponse.error(description: "Error to convert data"))
                }
            }
    }
    static func getOne(id: String, withCompletion
        completion: (StepOneResponse) -> Void) {
        completion(StepOneResponse.error(description: "Not implementation"))
    }
    static func update(params: Step, withCompletion completion: @escaping (StepOneResponse) -> Void) {
        EndpointsRequests.postRequest(url: "\(BASE_URL)/update",
                                params: params.dictionaryRepresentation,
                                decodableType: ServerAnswer<Step>.self) { (response) in
            switch response {
            case .result(let answer as ServerAnswer<Step>):
                guard let result = answer.success,
                    let step = answer.content,
                    result

                    else {
                        if let message = answer.message {
                            completion(StepOneResponse
                                .error(description: message))
                        } else {
                            completion(StepOneResponse
                                .error(description: "Answer is false"))
                        }
                        return
                }
                completion(StepOneResponse.success(answer: step))
            case .error(let error):
                completion(StepOneResponse.error(description: error.localizedDescription))
            default:
                completion(StepOneResponse.error(description: "Error to convert data"))
            }
        }
    }
    public static func deleteOne(id: String, completion: @escaping (StepOneResponse) -> Void) {
        EndpointsRequests
            .getRequest(
                url: "\(BASE_URL)/delete/\(id)",
                decodableType: ServerAnswer<Step>.self
            ) { (response) in
                switch response {
                case .result(let answer as ServerAnswer<Step>):
                    if (answer.success ?? false), let step = answer.content {
                        completion(StepOneResponse.success(answer: step))
                    } else {
                        completion(StepOneResponse.error(description: answer.message ?? ""))
                    }
                case .error(let error):
                    completion(StepOneResponse.error(description: error.localizedDescription))
                default:
                    completion(StepOneResponse.error(description: "Error to convert data"))
                }
        }

    }
}
