//
//  SSDoctorTextView.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSDoctorTextView: UITextView {

    var textInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 24, right: 8)
    var placeholder: String? {
        didSet { placeholderLabel.text = placeholder }
    }
    let maxCount: Int = 1000
    
    private lazy var placeholderLabel: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = KKToolUtils.color_from_hex("#803A3A3A")
        lab.font = self.font
        return lab
    }()
    
    private lazy var countLabel: UILabel = {
        let lab = UILabel()
        lab.font = KKToolUtils.ubuntu_font(size: 11)
        lab.textColor = KKToolUtils.color_from_hex("#FF3A3A3A")
        lab.text = "(0/\(maxCount))"
        lab.textAlignment = .right
        return lab
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        ss_borderColor = KKToolUtils.color_from_hex("#FF2A2A2A")
        ss_borderWidth = 1
        ss_cornerRadius = 14
        
        textColor = .white
        font = KKToolUtils.ubuntu_font(size: 13)
        placeholder = "Please enter"

        textContainerInset = textInsets
        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textInsets.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textInsets.left + 4),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textInsets.right),
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(136)
            make.centerX.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textContainerInset = textInsets
        refreshPlaceholderVisible()
        refreshCountText()
    }
    
    @objc private func textDidChange() {
        if text.count > maxCount {
            text = String(text.prefix(maxCount))
            selectedRange = NSRange(location: text.count, length: 0)
        }
        refreshPlaceholderVisible()
        refreshCountText()
    }
    
    private func refreshPlaceholderVisible() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    private func refreshCountText() {
        countLabel.text = "(\(text.count)/\(maxCount))"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
