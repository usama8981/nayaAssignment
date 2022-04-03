//
//  AsyncImageView.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

@objc final class AsyncImageView: UIImageView {
    
    private var indicator : UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializeContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializeContent()
        
    }
    
    private func initializeContent(){
        self.addSubview(self.indicator)
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        self.indicator.color = UIColor.gray
        self.indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.indicator.hidesWhenStopped = true
        
        
    }
    
    
    func loadUrl(_ url : URL?, completion : ((Bool) -> ())?  = nil) {
        guard let url = url else {
            completion?(true)
            return
        }
        self.indicator.startAnimating()
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString){
            DispatchQueue.main.async {
                self.image = cacheImage
                self.indicator.stopAnimating()
            }
            completion?(true)
            
        }else{
             URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else{
                    return
                }
                let image =  UIImage(data: data)
                if image != nil {
                    imageCache.setObject(image!, forKey:  url.absoluteString as NSString)
                    DispatchQueue.main.async {
                        self.image = image
                        self.indicator.stopAnimating()
                        
                    }
                    
                    completion?(true)
                    
                }
                
                
            }.resume()
        }
    }
    
}
