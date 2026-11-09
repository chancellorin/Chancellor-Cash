//
//  SherlockNavigationController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift

class SherlockNavigationController: UINavigationController {
    
    var navback: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundImage = nil
        appearance.backgroundColor = KKToolUtils.color_from_hex("#0C0C0C")
        appearance.shadowColor = .clear;
//        appearance.backgroundEffect = nil
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !viewControllers.isEmpty {
            let wdback = UIButton(type: .custom, primaryAction: UIAction { _ in
                switch viewController {
                case is SSDiplomatViewController:
                    let dip = viewController as! SSDiplomatViewController
                    if dip.dipchange || dip.dipid.isEmpty {
                        self.popViewController(animated: true)
                    }else {
                        self.sherlock_pback()
                    }
                case is SSHolmesViewController, is SSJournalistViewController, is SSLandladyViewController, is SSVeteranViewController:
                    self.sherlock_pback()
                case is SSFootprintViewController, is SSLaboratoryViewController, is SSDoctorViewController:
                    self.navback?()
                case is SSSergeantViewController: self.popToRootViewController(animated: true)
                default: self.popViewController(animated: true)
                }
            })
            wdback.setImage(.sherlockNavBack, for: .normal)
            wdback.setTitle(viewController.navigationItem.title ?? viewController.title ?? "", for: .normal)
            wdback.setTitleColor(.white, for: .normal)
            wdback.titleLabel?.font = KKToolUtils.ubuntu_font(size: 18, weight: .bold)
            wdback.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: wdback)
            viewController.title = ""
            viewController.navigationItem.title = ""
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func sherlock_pback() {
        let sher = SSSherlockImvPredict()
        sher.sherlocktype = .sherlockback
        SSSherlockImvPredict.sherlock_alert(sher)
        sher.sherlockback = {
            for shervc in self.viewControllers {
                if shervc is SSSoldierViewController, let soldier = shervc as? SSSoldierViewController, soldier.soldierult {
                    self.popToViewController(soldier, animated: true)
                    return
                }
            }
            self.popToRootViewController(animated: true)
        }
    }

}
