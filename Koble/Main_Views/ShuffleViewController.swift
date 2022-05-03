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
        
        //FUNCTION CREATED TO UPLOAD TEST USERS
        //createUsers()
        
        //TEMPORARY COMMENT OUT
/*
        let user = FirebaseUser.currentUser()!

        let cardModel = UserCardModel(id: user.objectId,
                                      name: user.username,
                                      age: abs(user.dateOfBirth.interval(ofComponent: .year, fromDate: Date())),
                                      interest: user.interest,
                                      image: user.profImg)
        
        initialCardModels.append(cardModel)
        layoutCardsStackView()
*/
        

        downloadInitialUSers()
        
       
    }//end viewDidLoad LIFE CYCLE
    
    
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
    
    //MARK: - DownLoadUSers
    
    
    
    
    
    
}//end ShuffleViewController





//EXTENSION: confominf to protocol StackDelegate & DataSource
extension ShuffleViewController: SwipeCardStackDelegate, SwipeCardStackDataSource {
    
   //MARK: - Data Source
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
    
    //MARK: - Delegate
    
    /*
     This section is used to see if card has been selected, which card was swiped and which direction,
     and if the stack is finished
     */
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        
        print("Stack is Empty")
        
    }//end did all swiped ??
    
    //tells which card was swipped and to which direction
    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        
        print("Swiped to", direction)
        
    }//end
    
    //tells where it was swipped
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        
        print("Selcted card at", index)
    }
    
    
    
  
}




