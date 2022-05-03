//
//  ShuffleViewController.swift
//  Koble
//
//  Created by Denys Ladden on 5/1/22.
//

import UIKit
import Shuffle_iOS
import Firebase



class ShuffleViewController: UIViewController {

    //MARK: - Vars
    /*
     Deck of cars where each deck has multiple cards
     In the data there will be an array of cards which is
     feed theouh
     */
    private let cardStack = SwipeCardStack()
    //initializing an array which will house single cards NUMBER OF CARDS
    private var initialCardModels: [UserCardModel] = []
    
    
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = FirebaseUser.currentUser()!
        
        let cardModel = UserCardModel(id: user.objectId,
                                      name: user.username,
                                      age: abs(user.dateOfBirth.interval(ofComponent: .year, fromDate: Date())),
                                      interest: user.interest,
                                      image: user.profImg)
        
        initialCardModels.append(cardModel)
        layoutCardsStackView()
        
        

       
    }//end viewDidLoad
    
    //MARK: - layout Cards
    //refresh the table view
    private func layoutCardsStackView(){
        //
        cardStack.delegate = self
        cardStack.dataSource = self
        //
        view.addSubview(cardStack)
        //anchoring
        cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)

        
        
    }
}//end ShuffleViewController





//EXTENSION: confominf to protocol StackDelegate & DataSource
extension ShuffleViewController: SwipeCardStackDelegate, SwipeCardStackDataSource {
    
    
    //Data source:
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
    
        let card = UserCard()
        card.footerHeight = 80
        //swipe types only left and right
        
        card.swipeDirections = [.left, .right]
        
        //direaction overlay
        
        for direction in card.swipeDirections{
        
            card.setOverlay(UserCardOverlay(direction: direction), forDirection: direction)
            
            
        }//end direction
        
        card.configure(model: initialCardModels[index])
        
        return card
    }
    
    
    //Data source: //HOW MANY CARDS ARE ON THE STACK
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
     
        return initialCardModels.count
    }
    
    
  
}




