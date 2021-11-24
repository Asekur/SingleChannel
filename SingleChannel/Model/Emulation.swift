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
            
            for indexNode in 4...6 {
                let node = nodes[indexNode]
                let emptyQueue = nodes[indexNode - Constants.amountChannels].requests.isEmpty

                // Reverse
                if !node.isFull() && !emptyQueue {
                    let req = nodes[indexNode - Constants.amountChannels].requests.removeFirst()
                    stats.overallQueueTime += req.endQueueTime(exitTime: Double(tick))
                    node.requests.append(req)
                    nextChannelWork[indexNode - Constants.amountChannels - 1] = Double(tick) + next(lambda: mu)
                }

                if (Double(tick) >= nextChannelWork[indexNode - Constants.amountChannels - 1] && node.isFull()) {
                    stats.overallSystemTime += node.requests[0].endLifeTime(removeTime: Double(tick))
                    node.requests.removeAll()
                }
            }

            for indexNode in 1...3 {
                let node = nodes[indexNode]
                stats.overallQueueLength += node.requests.count
            }

            for indexNode in 1...6 {
                let node = nodes[indexNode]
                stats.overallSystemLength += node.requests.count
            }
        }

        return stats
    }
}
