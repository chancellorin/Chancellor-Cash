//
//  SSSherlock+.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import KKUtilsKitSwift

extension UIView {
    
    @IBInspectable var ss_cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var ss_borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var ss_borderColor: UIColor {
        get { UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    public func ss_layerShadow(
        cornerRadius: CGFloat = 25,
        shadowOffset: CGSize = CGSize(width: 0, height: 4),
        shadowColor: UIColor = KKToolUtils.color_from_hex("#54AAFF00")
    ) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = cornerRadius / 2.0
        self.layer.shadowOpacity = 1.0
    }
    
    func ss_dashedBorder() {
        self.layer.sublayers?.forEach { layer in
            if layer.name == "SSDashedBorder" {
                layer.removeFromSuperlayer()
            }
        }
        let dashedLayer = CAShapeLayer()
        dashedLayer.name = "SSDashedBorder"
        dashedLayer.fillColor = UIColor.clear.cgColor
        dashedLayer.strokeColor = KKToolUtils.color_from_hex("#36AAFF00").cgColor
        dashedLayer.lineWidth = 1.5
        dashedLayer.lineDashPattern = [3, 2] as [NSNumber]
        let inset = 1.5 / 2
        let innerRect = self.bounds.insetBy(dx: inset, dy: inset)
        let newRadius = max(0, self.layer.cornerRadius - inset)
        dashedLayer.path = UIBezierPath(roundedRect: innerRect, cornerRadius: newRadius).cgPath
        dashedLayer.frame = self.bounds
        
        self.layer.insertSublayer(dashedLayer, at: 0)
    }
    
    func ss_dashedBorderRefrash() {
        guard let dashedLayer = self.layer.sublayers?.first(where: { $0.name == "SSDashedBorder" }) as? CAShapeLayer else { return }
        let lineW = dashedLayer.lineWidth
        let inset = lineW / 2
        let innerRect = self.bounds.insetBy(dx: inset, dy: inset)
        let newRadius = max(0, self.layer.cornerRadius - inset)
        let path = UIBezierPath(roundedRect: innerRect, cornerRadius: newRadius)
        dashedLayer.path = path.cgPath
        dashedLayer.frame = self.bounds
    }
    
    func ss_dashedLine() {
        self.layer.sublayers?.forEach { layer in
            if layer.name == "SSDashedLine" {
                layer.removeFromSuperlayer()
            }
        }
        
        let dashLayer = CAShapeLayer()
        dashLayer.name = "SSDashedLine"
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = KKToolUtils.color_from_hex("#36AAFF00").cgColor
        dashLayer.lineWidth = 1
        dashLayer.lineDashPattern = [3, 2] as [NSNumber]
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        dashLayer.path = path.cgPath
        dashLayer.frame = self.bounds
        
        self.layer.insertSublayer(dashLayer, at: 0)
    }
    
    func ss_dashedLineRefresh() {
        guard let dashLayer = self.layer.sublayers?.first(where: { $0.name == "SSDashedLine" }) as? CAShapeLayer else { return }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: dashLayer.lineWidth))
        path.addLine(to: CGPoint(x: self.bounds.width, y: dashLayer.lineWidth))
        dashLayer.path = path.cgPath
    }
    
    func ss_horizontalGradient(_ hex: String) {
        self.layer.sublayers?.forEach { layer in
            if layer is CAGradientLayer, layer.name == "HorizontalGradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
        let gradientLayer = CAGradientLayer()
        let hexlist = [hex, "54\(hex)", "000000"]
        let cgColors = hexlist.map { KKToolUtils.color_from_hex($0).cgColor }
        gradientLayer.colors = cgColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.name = "HorizontalGradientLayer"
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func ss_updateHorizontalGradientFrame() {
        self.layer.sublayers?.forEach { layer in
            guard let gradLayer = layer as? CAGradientLayer, gradLayer.name == "HorizontalGradientLayer" else { return }
            gradLayer.frame = self.bounds
        }
    }
    
}

extension UIButton {
    public func ss_underline() {
        let text =  self.title(for: .normal) ?? ""
        let attr = NSMutableAttributedString(string: text)
        attr.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: self.titleColor(for: .normal) ?? .clear,
            .foregroundColor: self.titleColor(for: .normal) ?? .clear
        ], range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attr, for: .normal)
    }
}

extension UILabel {
    func lineSpace(_ space: CGFloat = 5) {
        guard let content = self.text, !content.isEmpty else { return }
        let para = NSMutableParagraphStyle()
        para.lineSpacing = space
        para.alignment = self.textAlignment
        para.lineBreakMode = self.lineBreakMode
        
        let newAttr = NSMutableAttributedString(string: content)
        newAttr.addAttribute(.paragraphStyle, value: para, range: NSRange(location: 0, length: newAttr.length))
        self.attributedText = newAttr
    }
    
    func ss_splitByColonText(_ fullstr: String) {
        guard let colonIndex = fullstr.firstIndex(of: ":") else {
            self.font = KKToolUtils.ubuntu_font(size: 11, weight: .medium)
            self.textColor = KKToolUtils.color_from_hex("#99A1AF")
            self.text = fullstr
            return
        }
        let leftPart = String(fullstr[...colonIndex])
        let rightPart = String(fullstr[fullstr.index(after: colonIndex)...])
        
        let attr = NSMutableAttributedString()
        attr.append(NSAttributedString(string: leftPart, attributes: [
            .font: KKToolUtils.ubuntu_font(size: 11, weight: .medium),
            .foregroundColor: KKToolUtils.color_from_hex("#99A1AF")
        ]))
        attr.append(NSAttributedString(string: rightPart, attributes: [
            .font: KKToolUtils.ubuntu_font(size: 11, weight: .bold),
            .foregroundColor: UIColor.white
        ]))
        self.attributedText = attr
    }
}

extension UITextField {
    func textPadding(left: CGFloat = 14, right: CGFloat = 14) {
        let leftPad = UIView(frame: CGRect(x: 0, y: 0, width: left, height: 1))
        self.leftView = leftPad
        self.leftViewMode = .always
        
        let rightPad = UIView(frame: CGRect(x: 0, y: 0, width: right, height: 1))
        self.rightView = rightPad
        self.rightViewMode = .always
    }
    
    func placeholderColor(_ color: UIColor) {
        guard let placeholderStr = self.placeholder else { return }
        let attr = NSAttributedString(string: placeholderStr, attributes: [
            .foregroundColor: color
        ])
        self.attributedPlaceholder = attr
    }
}

extension UIImageView {
    func startInfiniteRotate(duration: TimeInterval = 1.5) {
        self.layer.removeAnimation(forKey: "rotateAnim")
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.fromValue = 0
        anim.toValue = Double.pi * 2
        anim.duration = duration
        anim.repeatCount = .greatestFiniteMagnitude
        anim.timingFunction = CAMediaTimingFunction(name: .linear)
        self.layer.add(anim, forKey: "rotateAnim")
    }
    
    func stopRotate() {
        self.layer.removeAnimation(forKey: "rotateAnim")
    }
}

extension UIImage {
    func rotateRight90() -> UIImage {
        let size = self.size
        let width = size.width
        let height = size.height
        let rotatedSize = CGSize(width: height, height: width)
        UIGraphicsBeginImageContext(rotatedSize)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: height, y: 0)
        context.rotate(by: .pi / 2)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let rotatedImg = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return rotatedImg
    }
}

extension String {
    func stringWidth(_ fontS: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: KKToolUtils.ubuntu_font(size: fontS)]
        let rect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                     options: .usesLineFragmentOrigin,
                                     attributes: attributes,
                                     context: nil)
        return ceil(rect.width)
    }
}


