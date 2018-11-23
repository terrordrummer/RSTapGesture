//
//  ViewController.swift
//  RSTapGesture
//
//  Created by terrordrummer on 11/23/2018.
//  Copyright (c) 2018 terrordrummer. All rights reserved.
//

import UIKit
import RSTapGesture

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // add the tap gesture and set the event handlers
        RSTapGesture(in: label)
            .onTouchDown { (_) in
                self.addTransition(to: self.label)
                self.label.text = "Touch down"
            }
            .onTouchUpInside { (_) in
                self.addTransition(to: self.label)
                self.label.text = "Touch up inside"
            }
            .onTouchUpOutside { (_) in
                self.addTransition(to: self.label)
                self.label.text = "Touch up outside"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func addTransition(to view: UIView) {
        // add a fade transition to animate the next change
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = 0.1
        view.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }

}

