//
//  Single+Rx.swift
//  GithubFinder-ReactorKit
//
//  Created by 최지철 on 12/17/24.
//

import Foundation

import RxSwift
import Alamofire

extension PrimitiveSequence where Trait == SingleTrait, Element == DataResponse<Data, AFError> {
    /// Extension method for logging raw JSON.
    /// - Parameter tag: Log tag.
    /// - Returns: A `Single` with logging applied.
    func logRawJSON(tag: String = "Raw JSON Response") -> Single<Element> {
        return self.do(onSuccess: { response in
            #if DEBUG
            Task {
                if let jsonString = String(data: response.data ?? Data(), encoding: .utf8) {
                    await log.debug("\(tag): \(jsonString)")
                } else {
                    await log.error("Failed to convert response data to string.")
                }
            }
            #endif
        }, onError: { error in
            #if DEBUG
            Task {
                await log.error("Error occurred during logging: \(error.localizedDescription)")
            }
            #endif
        })
    }
}
