//
//  SceneDelegate.swift
//  Routine
//
//  Created by t2023-m0072 on 10/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: windowScene)
    let vc = MainRoutineViewController()
    let navigationController = UINavigationController(rootViewController: vc)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    self.window = window
      
      // 라이트 모드로 설정
      window.overrideUserInterfaceStyle = .light

  }
  
}

