  //
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Yadiel Velez on 12/12/15.
//  Copyright © 2015 1st Gadget. All rights reserved.
//

import UIKit
  protocol SettingsDelegate{
    func tipPercentageChanged(newValue : Double)
  }
class SettingsViewController: UIViewController {
    @IBOutlet weak var tipControl: UISegmentedControl!
    var tipRates:Double?
    var destName : String!
    var delegate :SettingsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeValue(sender: UISegmentedControl) {
        var tipRate = [0.05, 0.10, 0.15, 0.20, 0.25, 0.30]
        tipRates = (tipRate[tipControl.selectedSegmentIndex])
        delegate?.tipPercentageChanged(tipRates!); print("(tipRates)")
        NSUserDefaults.standardUserDefaults().setDouble(tipRates!, forKey: "DefaultTipRate")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
