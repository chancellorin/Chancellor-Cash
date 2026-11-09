//
//  SceneDelegate.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import SideMenuSwift
import KKUtilsKitSwift



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if KKToolUtils.token == nil {
            window?.rootViewController = SherlockNavigationController(rootViewController: SSDetectiveViewController())
        }else {
            let contentViewController = SherlockNavigationController(rootViewController: SSSleuthViewController())
            let menuViewController = SherlockNavigationController(rootViewController: SSConsultantViewController())
            window?.rootViewController = SideMenuController(contentViewController: contentViewController,
            menuViewController: menuViewController)
        }
        
        SideMenuController.preferences.basic.menuWidth = UIScreen.main.bounds.width
        SideMenuController.preferences.basic.direction = .right
        SideMenuController.preferences.basic.position = .under
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        SSSherlockFireplace.sherlock.sherlock_netchek()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
//        if let _ = UserDefaults.standard.string(forKey: "Moriartynoti") {
//            UserDefaults.standard.removeObject(forKey: "Moriartynoti")
//            SSSherlockFireplace.sherlock.sherlock_notichek(needreq: true)
//        }
    }


}

