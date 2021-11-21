//
//  ViewController.swift
//  SingleChannel
//
//  Created by Chegelik on 21.11.2021.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func generateClicked(_ sender: Any) {
        let nodes = [
            Node(isQueue: false),
            Node(isQueue: true),
            Node(isQueue: true),
            Node(isQueue: true),
            Node(isQueue: false),
            Node(isQueue: false),
            Node(isQueue: false)
        ]
        let emulation = Emulation(nodes: nodes, lambda: 12.0, mu: 4.5)
        emulation.emulate(ticks: Constants.n)
    }
}

