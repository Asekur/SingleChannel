//
//  Request.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Request {
    let creationTime: Int
    
    init(creationTime: Int) {
        self.creationTime = creationTime
    }
    
    func endLifeTime(removeTime: Double) -> Double {
        removeTime - Double(self.creationTime)
    }
    
    func endQueueTime(exitTime: Double) -> Double {
        exitTime - Double(self.creationTime)
    }
}
