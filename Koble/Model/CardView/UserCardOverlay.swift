//
//  UserCardOverlay.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//


import Shuffle_iOS
import UIKit

//subcalss of UIview
class UserCardOverlay: UIView {
    
    
    
    //part of the shuffle library
    init(direction: SwipeDirection){
        //direction swipe
        super.init(frame: .zero)
        //this is the cases for all swipes (LEFT: DISSLIEK, RIGHT: DISSLIKE)
        switch direction {
        case .left:
            createLeftOverlay()
        case .right:
            createRightOverlay()
        default:
            break
        }
        
    }//end SwipeDirection
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        return nil
    }
    
    
    private func createLeftOverlay(){
        let leftTextView = SampleOverlayLabelView(title: "no", color: .sampleRed, rotation: CGFloat.pi/10)
        //LIKE
        addSubview(leftTextView)
        //bottom: ,left: ,paddingLeft: , paddingBottom: ,width: CGFloat, height: CGFloat
        leftTextView.anchor(top: topAnchor,
                           right: rightAnchor,
                           paddingTop: 30,
                           paddingRight: 14)

    }//end LEFT
    
    private func createRightOverlay(){
            let rightTextView = SampleOverlayLabelView(title: "🤍", color: .sampleGreen, rotation: -CGFloat.pi/10)
            //NOPE
            addSubview(rightTextView)
            //bottom: ,left: ,paddingLeft: , paddingBottom: ,width: CGFloat, height: CGFloat
            rightTextView.anchor(top: topAnchor,
                               left: leftAnchor,
                               paddingTop: 26,
                               paddingRight: 14)
        
    }//end RIGHT
    
    
}
//this function creates UIview with tittle lable used above
fileprivate class SampleOverlayLabelView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    //The Tittle and the cornurs radus / border
    init(title: String, color: UIColor, rotation: CGFloat) {
        super.init(frame: CGRect.zero)
        layer.borderColor = color.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 4
        //animation which chnages the visibilty gradually
        transform = CGAffineTransform(rotationAngle: rotation)
        //tittle labels text clolor
        addSubview(titleLabel)
        titleLabel.textColor = color
        titleLabel.attributedText = NSAttributedString(string: title,
                                                       attributes: NSAttributedString.Key.overlayAttributes)
        titleLabel.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingLeft: 8,
                          paddingRight: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

}
