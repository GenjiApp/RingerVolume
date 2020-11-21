//
//  IntentHandler.swift
//  RingerVolumeIntents
//
//  Created by Genji on 2020/11/21.
//

import Intents
import VolumeManager

class IntentHandler: INExtension, SetRingerVolumeIntentHandling {

  override func handler(for intent: INIntent) -> Any {
    return self
  }

  func handle(intent: SetRingerVolumeIntent, completion: @escaping (SetRingerVolumeIntentResponse) -> Void) {
    let response: SetRingerVolumeIntentResponse
    if let volume = intent.volume?.floatValue {
      VolumeManager.shared().ringerVolume = volume
      response = SetRingerVolumeIntentResponse(code: .success, userActivity: nil)
    }
    else {
      response = SetRingerVolumeIntentResponse(code: .failure, userActivity: nil)
    }
    completion(response)
  }

  func resolveVolume(for intent: SetRingerVolumeIntent, with completion: @escaping (SetRingerVolumeVolumeResolutionResult) -> Void) {
    if let volume = intent.volume?.doubleValue, volume >= 0 && volume <= 1.0 {
      completion(SetRingerVolumeVolumeResolutionResult.success(with: volume))
    }
    else {
      completion(SetRingerVolumeVolumeResolutionResult.unsupported())
    }
  }

}
