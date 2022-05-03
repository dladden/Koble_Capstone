//
//  UserCardContentView.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//

import Foundation
import UIKit

//UserCardContentView is a subclass of UIView
class UserCardContentView: UIView{
    /*
      Stack:  Background - Image - Gradient View
     */
    private let backgroundView: UIView = {
        //initialzing the
        let background = UIView()
        //edditing the card and its corners
        background.clipsToBounds = true
        background.layer.cornerRadius = 10
        return background
        
    }()
    private let imageView: UIImageView = {
        
        let imageView = UIImageView()
        //sacling the image to fit in the imageview
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    private let gradientLayer : CAGradientLayer = {
       
        let gradientLayer = CAGradientLayer()
        //adding the gradient shadow
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.01).cgColor, UIColor.black.withAlphaComponent(0.8).cgColor]
        //gradient location start point
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        return gradientLayer
    }()
    
    //user card initializer
    init(withImage image: UIImage?){
    //calls the super initiazlier of the UIView
        super.init(frame: .zero)
        // passing image to imageview
        imageView.image = image
        initializer()
        
    }//end initializer
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func initializer(){
        addSubview(backgroundView)
        //backgourn view ancored tot the superview
        backgroundView.anchorToSuperview()
        //add image to the ancored view
        backgroundView.addSubview(imageView)
        imageView.anchorToSuperview()
        //gradient layer above the image
        applyShadow(radius: 8, opacity: 0.4, offset: CGSize(width: 0, height: 2))
        backgroundView.layer.insertSublayer(gradientLayer, above: imageView.layer)
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let heightFactor: CGFloat = 0.35
        gradientLayer.frame = CGRect(x: 0, y: (1 - heightFactor) * bounds.height, width: bounds.width, height: heightFactor * bounds.height)
        
    }
    
    
    
}//end UserCardContentView
