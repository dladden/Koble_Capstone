//
//  Extensions.swift
//  Koble
//
//  Created by Denys Ladden on 4/19/22.
//

import Foundation
import UIKit

extension Date{
    
    func longDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmss"
        return dateFormatter.string(from: self)
    }
    //INTERVAL FUNCTION takes takes two parameters calendar and date returns integer (can check anything like time passing btween two days)
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int{
        //
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else{ return 0 }
        
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else{ return 0 }
        
        return end - start 
        
    }
    
}//end date extesnion


extension UIColor{
    func primary() -> UIColor{
        return UIColor(red: 0.9725, green: 0.8078, blue: 0.9255, alpha: 1)
        
    }
    func tabBarUnselected() -> UIColor{
        return UIColor(red: 0.9725, green: 0.8078, blue: 0.9255, alpha: 1)
    }
    
    static var sampleRed = UIColor(red: 252/255, green: 70/255, blue: 93/255, alpha: 1)
    static var sampleGreen = UIColor(red: 49/255, green: 193/255, blue: 109/255, alpha: 1)
    static var sampleBlue = UIColor(red: 52/255, green: 154/255, blue: 254/255, alpha: 1)
    
}


//MARK: - UserCardOverlay Extension
//EXTENSIONS for UserCardOverlay

//font set up
extension NSAttributedString.Key {
    static var overlayAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 42)!,
        NSAttributedString.Key.kern: 5.0
    ]
    /*
     EXTENSION for the Text below of the card the name, age, and interest!!!
     */
    static var shadowAttribute: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 2
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        return shadow
    }()
    
    static var titleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "ArialRoundedMTBold", size: 24)!,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
    
    static var subtitleAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont(name: "Arial", size: 17)!,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.shadow: NSAttributedString.Key.shadowAttribute
    ]
}



//uicolor
extension UIView {
    //applies shadow to the view
    func applyShadow(radius: CGFloat, opacity: Float, offset: CGSize, color: UIColor = .black) {
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
    }
    
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        //anchors top
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    @discardableResult
    func anchorToSuperview() -> [NSLayoutConstraint] {
        return anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor)
    }
}
