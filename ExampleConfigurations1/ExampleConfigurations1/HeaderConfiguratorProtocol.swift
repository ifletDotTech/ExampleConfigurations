//
//  HeaderConfiguratorProtocol.swift
//  ExampleConfigurations1
//
//  Created by Eduard Calero on 19/9/21.
//

import UIKit

protocol HeaderConfiguratorProtocol: UIViewController {}

extension HeaderConfiguratorProtocol {
    func configureNavigationBar(){
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.titleView = buildCustomHeader(withText: "Iflet.tech")
   }
   
   
   fileprivate func buildCustomHeader(withText title: String, image: UIImage? = nil, size: CGFloat = 33) -> UIView {
       
       var imageStack = [UIView]()
       
       if let image = image {
           let imageView = UIImageView()
           NSLayoutConstraint.activate([
               imageView.heightAnchor.constraint(equalToConstant: 50),
               imageView.widthAnchor.constraint(equalToConstant: 50)
           ])
           imageView.image = image
           imageStack.append(imageView)
       }
           
           let titleLabel = UILabel()
    let attText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont(name: "Raleway-ExtraBold", size: size)!,
                                                                 NSAttributedString.Key.foregroundColor : UIColor.white
    ])
           titleLabel.attributedText = attText
           imageStack.append(titleLabel)
       
       
       
           let hStack = UIStackView(arrangedSubviews: imageStack)
           hStack.spacing = 5
           hStack.alignment = .center
           return hStack
       
   }
}
