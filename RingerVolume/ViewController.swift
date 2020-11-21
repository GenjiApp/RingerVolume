//
//  ViewController.swift
//  RingerVolume
//
//  Created by Genji on 2020/11/21.
//

import UIKit
import VolumeManager

class ViewController: UIViewController {

  @IBOutlet weak var volumeSlider: UISlider!
  let volumeManager = VolumeManager.shared()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.volumeSlider.value = self.volumeManager.ringerVolume
  }

  @IBAction func sliderChanged(_ sender: Any) {
    guard let slider = sender as? UISlider else { return }
    self.volumeManager.ringerVolume = slider.value
  }

}
