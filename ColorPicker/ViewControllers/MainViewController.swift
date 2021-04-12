//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Mac on 10.04.2021.
//

import UIKit


class MainViewController: UIViewController {
    
    

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.screenColor = view.backgroundColor
        
        settingsVC.delegate = self
    }
    
}

extension MainViewController: SettingViewControllerDelegate {
    func setColor(_ color: UIColor) {
            view.backgroundColor = color
        }
}


