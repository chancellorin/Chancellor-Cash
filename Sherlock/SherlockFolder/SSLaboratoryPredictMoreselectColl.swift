//
//  SSLaboratoryPredictMoreselectColl.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift

class SSLaboratoryPredictMoreselectColl: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        laborEvid.termDetailList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let labocell = collectionView.dequeueReusableCell(withReuseIdentifier: "SSLaboratoryPredictMoreselectCollCell", for: indexPath) as! SSLaboratoryPredictMoreselectCollCell
        if let labor = laborEvid.termDetailList?[indexPath.item].EMIs, labor > 1 {
            labocell.laboratory.text = "\(laborEvid.termDetailList?[indexPath.item].EMIs ?? 0) EMIs"
        }else {
            labocell.laboratory.text = "\(laborEvid.termDetailList?[indexPath.item].showTerm ?? "0") Days"
        }
        if indexPath.item == laborEvid.terindex {
            labocell.contentView.backgroundColor = isLaborawithd ? laboratorywithdColor : laboratoryColor
            labocell.contentView.ss_borderColor = .clear
            labocell.laboratory.textColor = KKToolUtils.color_from_hex("#FF0C0C0C")
            labocell.laboratory.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        }else {
            labocell.contentView.backgroundColor = KKToolUtils.color_from_hex("#FF161616")
            labocell.contentView.ss_borderColor = KKToolUtils.color_from_hex("#FF282828")
            labocell.laboratory.textColor = KKToolUtils.color_from_hex("#FF666666")
            labocell.laboratory.font = KKToolUtils.ubuntu_font(size: 13)
        }
        return labocell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSizeMake(laborcollWidth, 42.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        laborEvid.terindex = indexPath.item
        reloadData()
        laboratoryamoselect?(laborEvid)
    }
    
    var laboratoryamoselect: ((SSSherlockSergeantEvidence) -> Void)?
    
    var isLaborawithd = false
    var laborcollWidth = (UIScreen.main.bounds.width - 28 - 16)/3
    
    var laborEvid = SSSherlockSergeantEvidence() {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flay = UICollectionViewFlowLayout()
        flay.minimumLineSpacing = 8
        flay.minimumInteritemSpacing = 4
        flay.scrollDirection = .horizontal
        flay.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        super.init(frame: frame, collectionViewLayout: flay)
        backgroundColor = .clear
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        register(SSLaboratoryPredictMoreselectCollCell.self, forCellWithReuseIdentifier: "SSLaboratoryPredictMoreselectCollCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
