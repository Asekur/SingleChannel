//
//  Emulation.swift
//  QueuingSystem
//
//  Created by Chegelik on 28.10.2021.
//

import Foundation

class Emulation {
    var nodes: [Node]
    let lambda: Double
    let mu: Double
    
    init(nodes: [Node], lambda: Double, mu: Double) {
        self.nodes = nodes
        self.lambda = lambda
        self.mu = mu
    }
    
    func next(lambda: Double) -> Double {
        return log(1 - Double.random(in: 0..<1)) / (-1 * lambda)
    }
    
    func emulate(ticks: Int) {
        var nextTickRequest = Int(next(lambda: lambda))
        var nextChannelWork = [-1, -1, -1]
        
        for tick in 0..<ticks {
            print(next(lambda: lambda))
        }
        
        for tick in 0..<ticks {
            if (tick == nextTickRequest) {
                let request = Request(creationTime: tick)
                //add to queue
                nodes[tick % Constants.amountChannels + 1].requests.append(request)
                var next = next(lambda: lambda)
                nextTickRequest = tick + Int(round(next))
            }
            
            for indexNode in 4...6 {
                let node = nodes[indexNode]
                let fullNode = node.isFull()
                let emptyQueue = nodes[indexNode - Constants.amountChannels].requests.isEmpty
                if !fullNode && !(emptyQueue) {
                    node.requests.append(nodes[indexNode - Constants.amountChannels].requests[0])
                    nodes[indexNode - Constants.amountChannels].requests.removeFirst()
                    var nextC = next(lambda: mu)
                    nextChannelWork[indexNode - Constants.amountChannels - 1] = tick + Int(round(nextC))
                }
                if (tick == nextChannelWork[indexNode - Constants.amountChannels - 1] && node.isFull()) {
                    node.requests.removeAll()
                }
            }
            
            for index in 1...6 {
                if nodes[index].requests.isEmpty {
                   // print ("\(tick): \(index) empty")
                }
            }
            
        }
    }
}
