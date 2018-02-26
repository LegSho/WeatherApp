//
//  TransitionExtension.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/5/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import UIKit

extension UIViewController {
    func transitionFromRight(_ VCToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        DispatchQueue.main.async {
            self.view.window?.layer.add(transition, forKey: kCATransition)
        }
        present(VCToPresent, animated: false, completion: nil)
    }
    
    func transitionDismissLeft(_ VCToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    func transitionFromLeft(_ VCToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(VCToPresent, animated: false, completion: nil)
    }
    
    func transitionDismissRight(_ VCToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}

