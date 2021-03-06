//
//  ViewController.swift
//  ColorPicker
//
//  Created by Mac on 27.03.2021.
//

import UIKit

protocol SettingViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class SettingsViewController: UIViewController {
    
    var delegate: SettingViewControllerDelegate?
    
    @IBOutlet var screenView: UIView! {
        didSet {
            screenView.layer.cornerRadius = 15
        }
    }
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var colorsTF: [UITextField]!
    
    var screenColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenView.backgroundColor = screenColor
//        setDefaults()
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        addDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        changeColor()
        
        switch sender {
        case redSlider: setValue(for: redValueLabel)
        case greenSlider: setValue(for: greenValueLabel)
        default: setValue(for: blueValueLabel)
        }
        delegate?.setColor(screenView.backgroundColor!)
    }
    
    private func changeColor() {
        screenView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                             green: CGFloat(greenSlider.value),
                                             blue: CGFloat(blueSlider.value),
                                             alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                label.text = string(from: redSlider)
            case greenValueLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setDefaults() {
        guard let red = screenView.backgroundColor?.ciColor.red else { return }
        guard let green = screenView.backgroundColor?.ciColor.green else { return }
        guard let blue = screenView.backgroundColor?.ciColor.blue else { return }
        print(red)
//        redSlider.value = Float(red)
//        greenSlider.value = Float(green)
//        blueSlider.value = Float(blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func addDoneButton() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done",
                                     style: .done,
                                     target: self,
                                     action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        toolBar.setItems([flexibleSpace, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        for textfield in colorsTF{
            textfield.inputAccessoryView = toolBar
        }
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}


extension SettingsViewController: UITextFieldDelegate {

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let sliderValue = (text as NSString).floatValue
        guard sliderValue <= 1 else { return }
        switch textField.tag {
        case 0:
            redValueLabel.text = text
            redSlider.value = sliderValue
        case 1:
            greenValueLabel.text = text
            greenSlider.value = sliderValue
        default:
            blueValueLabel.text = text
            blueSlider.value = sliderValue
        }
        changeColor()
    }
    
}
