//
//  Reviews.swift
//  Kaligo
//
//  Created by Mariana Lima on 18/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation

extension Reviews {
    /**
        It add to array the elements defaults of type **Review**.
     
        ## Important Notes ##
        1. The parameter is **int** number.
    */
    mutating func createReviewsWith(quantity n: Int) {
        for _ in 0..<n {
            self.append(Review())
        }
    }
}
