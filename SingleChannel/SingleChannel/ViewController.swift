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
                "Среднее время заявки в очереди \n\((Double(stats.overallQueueLength) / lambdaTextField.doubleValue) / Double(Constants.n))\n" +
                "Среднее время заявки в системе \n\((Double(stats.overallSystemLength) / lambdaTextField.doubleValue) / Double(Constants.n))"
    }
}

