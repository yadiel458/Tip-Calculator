//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Yadiel Velez on 12/12/15.
//  Copyright © 2015 1st Gadget. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsDelegate {
    //Inputs
    @IBOutlet weak var amountTextField: UITextField!
    //Labels
    @IBOutlet weak var TipPercentageLabel: UILabel!
    @IBOutlet weak var numberOfPersonLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var billPerPersonLabel: UILabel!
    //Slider & Stepper
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var personsStepper: UIStepper!
    //Variables
    var tipPercentage : Double = NSUserDefaults.standardUserDefaults().doubleForKey("DefaultTipRate") ?? 0.20
    var numberOfPerson:Int = 1
    let numberFormatter:NSNumberFormatter = NSNumberFormatter()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipAmountLabel.text = "$0.00"
        totalBillLabel.text = "Bill Total"
        billPerPersonLabel.text = "$0.00"
        numberOfPersonLabel.text = "1"
        self.amountTextField.becomeFirstResponder()
        print("DefaultTipRate")
        let tipPercentage : Double = NSUserDefaults.standardUserDefaults().doubleForKey("DefaultTipRate")
        TipPercentageLabel.text = self.numberFormatter.stringFromNumber(tipPercentage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupContainer() {
        
        
        tipSlider.minimumValue = 0
        tipSlider.maximumValue = 30
        tipSlider.value = 20
        tipSlider.addTarget(self, action: "sliderTipChanged:", forControlEvents: .ValueChanged)
        
        personsStepper.minimumValue = 1
        personsStepper.maximumValue = 30
        personsStepper.value = 1
        personsStepper.addTarget(self, action: "sliderPersonChanged:", forControlEvents: .ValueChanged)
        
        amountTextField.text = ""
        
        refreshCalculation()
        
    }
    @IBAction func OnEditingFieldBill(sender: AnyObject) {
        refreshCalculation()
    }
    func refreshCalculation() {
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        if let amount = numberFormatter.numberFromString(amountTextField.text!) as? Double {
            
            let tipAmount = amount * tipPercentage
            let totalBill = amount + tipAmount
            let billPerPerson = totalBill / Double(numberOfPerson)
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            tipAmountLabel.text = numberFormatter.stringFromNumber(tipAmount)
            totalBillLabel.text = numberFormatter.stringFromNumber(totalBill)
            billPerPersonLabel.text = numberFormatter.stringFromNumber(billPerPerson)
            
        } else {
            
            tipAmountLabel.text = "-"
            totalBillLabel.text = "-"
            billPerPersonLabel.text = "-"
        }
        
        numberFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        TipPercentageLabel.text = String(format: "%.0f%%", tipPercentage * 100)
        
        numberOfPersonLabel.text = "\(numberOfPerson)"
        
    }
    @IBAction func sliderTipChanged(sender: AnyObject) {
        tipPercentage = Double(round(tipSlider.value)) / 100
        refreshCalculation()
    }
    @IBAction func StepperPersonChanged(sender: AnyObject) {
        numberOfPerson = Int(round(personsStepper.value))
        refreshCalculation()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let SettingsViewController = segue.destinationViewController as? SettingsViewController {
            SettingsViewController.delegate = self
            refreshCalculation()
        }
    }
    func tipPercentageChanged(newValue: Double) {
        TipPercentageLabel.text = "\(newValue)%"
        tipPercentage = newValue
        tipSlider.value = 100.0 * Float(newValue)
        refreshCalculation()
    }
}