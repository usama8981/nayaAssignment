//
//  UIViewController+Extension.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit

extension UIViewController   {

    
    
    private var activity: UIActivityIndicatorView {
        if self.view.viewWithTag(99999) is UIActivityIndicatorView{
            return self.view.viewWithTag(99999) as! UIActivityIndicatorView
        }else {
            let activity = UIActivityIndicatorView(style: .medium)
            activity.color = UIColor.gray
            activity.tag = 99999
            return activity
        }
    }
    
    func showActivityIndicator(){
        let activityIndicator = self.activity
        DispatchQueue.main.async {
            self.view.addSubview( activityIndicator)
            activityIndicator.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            activityIndicator.startAnimating()
            
        }
        
    }
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            let activityIndicator = self.activity
            activityIndicator.removeFromSuperview()
            activityIndicator.stopAnimating()
            
        }
    }
    
}
