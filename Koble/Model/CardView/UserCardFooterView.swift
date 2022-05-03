//
//  UserCardFooterView.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//

import Foundation
import UIKit

class UserCardFooterView: UIView{
    //creatin glabel
    private var label = UILabel()
    //initalizing the gradient layer
    private var gradientLayer: CAGradientLayer?
    
    
    //intializing the footer view with the name TITTLE and Interest as SUBTITLE
    init(withTitle title: String?, subTitle: String?){
        super.init(frame: .zero)
        //adding clear background for footer
        backgroundColor = .clear
        //masking corners
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 12
        clipsToBounds = true
        isOpaque = false
        initialize(title: title, subtitle: subTitle)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func initialize(title: String?, subtitle: String?) {
        //string which cannot be chmaged after initialization
        let attributedText = NSMutableAttributedString(string: (title ?? "") + "\n", attributes: NSAttributedString.Key.titleAttributes)
        
        print("init footer", title, subtitle)
        
        if let subtitle = subtitle, subtitle != "" {
            
            attributedText.append(NSMutableAttributedString(string: subtitle, attributes: NSAttributedString.Key.subtitleAttributes))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            paragraphStyle.lineBreakMode = .byTruncatingTail
            attributedText.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
            label.numberOfLines = 2
        }
        label.attributedText = attributedText
        addSubview(label)
    }
    
    override func layoutSubviews() {
        let padding: CGFloat = 20
        
        label.frame = CGRect(x: padding, y: bounds.height - label.intrinsicContentSize.height - padding, width: bounds.width, height: label.intrinsicContentSize.height)
    }
}

