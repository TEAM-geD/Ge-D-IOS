//
//  UIViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let attributedString = NSMutableAttributedString(string: "ge:D", attributes: [
          .font: UIFont(name: "GmarketSansBold", size: 54.0)!,
          .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
          .kern: -1.08
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "GmarketSansMedium", size: 54.0)!, range: NSRange(location: 2, length: 2))
        
        mainLabel.attributedText = attributedString
    }

}
