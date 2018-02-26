//
//  DeleteBtn.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/15/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

@IBDesignable
class DeleteBtn: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
