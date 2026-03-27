//
//  GameViewController.swift
//  appCoreGraphics
//
//  Created by Emiliano Cepeda on 02/12/24.
//

import UIKit

class ContainerScrollView: UIScrollView {
  var scrollView: UIScrollView?

  func setScrollView(_ scrollView: UIScrollView) {
    self.scrollView = scrollView
    addSubview(scrollView)
  }
}
