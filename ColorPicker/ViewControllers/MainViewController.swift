//
//  MainViewController.swift
//  ColorPicker
//
//  Created by Mac on 10.04.2021.
//

import UIKit


class MainViewController: UIViewController {
    
    var delegate: ScreenBGDelegate!
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        guard let segue = seg.source as? SettingsViewController  else { return }
        delegate = segue.self
        self.view.backgroundColor = delegate.changeBG()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVS = segue.destination as? SettingsViewController else { return }
        settingsVS.screenColor = self.view.backgroundColor
    }
    
}


