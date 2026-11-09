//
//  SSLabel.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit

class SSLabel: UILabel {
    
    private let fixedLineSpace: CGFloat = 5

    var textInsets = UIEdgeInsets.zero
    
    override var text: String? {
        didSet {
            setupLineSpacing()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            setupLineSpacing()
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let innerRect = bounds.inset(by: textInsets)
        var rect = super.textRect(forBounds: innerRect, limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= textInsets.left
        rect.origin.y -= textInsets.top
        rect.size.width += textInsets.left + textInsets.right
        rect.size.height += textInsets.top + textInsets.bottom
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    private func setupLineSpacing() {
        guard let content = text, !content.isEmpty else { return }
        
        let para = NSMutableParagraphStyle()
        para.lineSpacing = fixedLineSpace
        para.alignment = self.textAlignment
        para.lineBreakMode = self.lineBreakMode
        
        let attrStr = NSMutableAttributedString(string: content)
        attrStr.addAttribute(.paragraphStyle, value: para, range: NSRange(location: 0, length: content.count))
        super.attributedText = attrStr
    }

}
