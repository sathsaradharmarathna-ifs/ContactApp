//
//  Extensios.swift
//  Simple
//
//  Created by Sathsara Dharmarathna on 2025-05-20.
//

import UIKit

extension UIView{
    
    func addCornerRadious(radious:CGFloat){
        self.layer.cornerRadius = radious
        self.layer.masksToBounds = true
    }
    
}
