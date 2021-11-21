//
//  Node.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Node {
    var requests = [Request]()
    let isQueue: Bool
    
    init(isQueue: Bool) {
        self.isQueue = isQueue
    }
    
    func isFull() -> Bool {
        !requests.isEmpty
    }
}
