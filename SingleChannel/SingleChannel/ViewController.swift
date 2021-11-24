//
//  ViewController.swift
//  SingleChannel
//
//  Created by Chegelik on 21.11.2021.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var amountChannelsTextField: NSTextField!
    @IBOutlet weak var lambdaTextField: NSTextField!
    @IBOutlet weak var muTextField: NSTextField!
    @IBOutlet var resultTextView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    func clearValues() {
//        Statistics.overallQueueLength = 0
//        Statistics.overallQueueTime = 0
//        Statistics.overallSystemLength = 0
//        Statistics.overallSystemTime = 0
//    }
    
    @IBAction func generateClicked(_ sender: Any) {
        let nodes = [
            Node(isQueue: true),
            Node(isQueue: true),
            Node(isQueue: true),
            Node(isQueue: false),
            Node(isQueue: false),
            Node(isQueue: false)
        ]

        Constants.amountChannels = amountChannelsTextField.integerValue == 0 ? 3 : amountChannelsTextField.integerValue
        let emulation = Emulation(nodes: nodes,
            lambda: lambdaTextField.doubleValue / 60,
            mu: muTextField.doubleValue / 60)
        let stats = emulation.emulate(ticks: Constants.n)
        
        resultTextView.string =
                "Средняя длина системы \n\(Double(stats.overallSystemLength) / Double(Constants.n))\n" +
                "Средняя длина очереди \n\(Double(stats.overallQueueLength) / Double(Constants.n))\n" +
                "Среднее время заявки в очереди \n\(((Double(stats.overallQueueTime) / 60.0) / Double(Constants.n)))\n" +
                "Среднее время заявки в системе \n\(((Double(stats.overallSystemTime)  / 60.0) / Double(Constants.n)))"
                
        //clearValues()
    }
}

