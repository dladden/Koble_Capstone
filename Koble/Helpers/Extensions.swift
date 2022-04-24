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
