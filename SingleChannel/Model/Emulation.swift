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
    
    func emulate(ticks: Int) -> Statistics {
        let stats = Statistics()

        var nextTickRequest: Double = next(lambda: lambda)
        var nextChannelWork: [Double] = [-1, -1, -1]

        var nextQueue = 0
        
        for tick in 0..<ticks {
            if (Double(tick) >= nextTickRequest) {
                let request = Request(creationTime: tick)
                nodes[nextQueue % Constants.amountChannels].requests.append(request)
                nextQueue += 1
                nextTickRequest = Double(tick) + next(lambda: lambda)
            }
            
            for indexNode in 3...5 {
                let node = nodes[indexNode]
                let emptyQueue = nodes[indexNode - Constants.amountChannels].requests.isEmpty

                // Reverse
                if (Double(tick) >= nextChannelWork[indexNode - Constants.amountChannels] && node.isFull()) {
                    stats.overallSystemTime += node.requests[0].endLifeTime(removeTime: Double(tick))
                    node.requests.removeAll()
                }
                
                if !node.isFull() && !emptyQueue {
                    let req = nodes[indexNode - Constants.amountChannels].requests.removeFirst()
                    stats.overallQueueTime += req.endQueueTime(exitTime: Double(tick))
                    node.requests.append(req)
                    nextChannelWork[indexNode - Constants.amountChannels] = Double(tick) + next(lambda: mu)
                }
            }

            for indexNode in 0..<Constants.amountChannels {
                let node = nodes[indexNode]
                stats.overallQueueLength += node.requests.count
            }

            for indexNode in 0...5 {
                let node = nodes[indexNode]
                stats.overallSystemLength += node.requests.count
            }
        }

        return stats
    }
}
