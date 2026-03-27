//
//  GameScene.swift
//  appCoreGraphics
//
//  Created by Emiliano Cepeda on 02/12/24.
//

import UIKit

enum RageLevel: Int, CaseIterable {
  case happy, somewhatHappy, neutral, somewhatAngry, angry

  var image: UIImage {
    switch self {
    case .happy: return UIImage(named: "happy")!
    case .somewhatHappy: return UIImage(named: "somewhat_happy")!
    case .neutral: return UIImage(named: "neutral")!
    case .somewhatAngry: return UIImage(named: "somewhat_angry")!
    case .angry: return UIImage(named: "angry")!
    }
  }

  var tweet: String {
    switch self {
    case .happy: return "The world is my oyster - raw, wriggling, and danglng from my mouth."
    case .somewhatHappy: return "Get down with your bad self!"
    case .neutral: return "Hmm ... Not good, not bad.  Not happy.  Not sad."
    case .somewhatAngry: return "Core breach imminent - stand back before I go thermonuclear"
    case .angry: return "FFFFFFFUUUUUUUUU!!!!1!!!"
    }
  }
}
