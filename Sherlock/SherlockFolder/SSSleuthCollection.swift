//
//  SSSleuthCollection.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift

struct SSSleuthMuseum {
    var sleuthim: String
    var sleuthti: String
}

class SSSleuthCollection: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sleuthds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let slecell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSSleuthCollectionCell", for: indexPath) as! SSSleuthCollectionCell
        slecell.sleuthimv.image = UIImage(named: sleuthds[indexPath.item].sleuthim)
        slecell.sleuthti.text = sleuthds[indexPath.item].sleuthti
        return slecell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0: sleuthcollselect?(SSSoldierViewController())
        case 1:
            self.sleuthcollselect?(SSAristocratViewController("https://privacy.chancellorin.com/privacy/contactUs.html", "Contact us"))
        case 2: sleuthcollselect?(SSDoctorViewController())
        case 3: sleuthcollselect?(SSInspectorViewController())
        case 4: sleuthcollselect?(SSWitnessViewController())
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-16)*0.2, height: 87)
    }
    
    var sleuthds = [
        SSSleuthMuseum(sleuthim: "sleuth_e", sleuthti: "EMI"),
        SSSleuthMuseum(sleuthim: "sleuth_c", sleuthti: "Contact us"),
        SSSleuthMuseum(sleuthim: "sleuth_f", sleuthti: "Feedback"),
        SSSleuthMuseum(sleuthim: "sleuth_a", sleuthti: "About "),
        SSSleuthMuseum(sleuthim: "sleuth_b", sleuthti: "Bank")
        ]
    var sleuthcollselect: ((UIViewController) -> Void)?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        sleuth_stepui()

    }
    
    func sleuth_stepui() {
        delegate = self
        dataSource = self
        register(SSSleuthCollectionCell.self, forCellWithReuseIdentifier: "SSSleuthCollectionCell")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
}
