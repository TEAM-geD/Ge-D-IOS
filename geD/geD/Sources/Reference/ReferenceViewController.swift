//
//  ReferenceViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit

class ReferenceViewController: BaseViewController {
    @IBOutlet weak var uxButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var plannigButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}
extension ReferenceViewController {
    func buttonLayout(){
        uxButton.layer.cornerRadius = 13
        uxButton.layer.borderWidth = 0.4
        uxButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        frontButton.layer.cornerRadius = 13
        frontButton.layer.borderWidth = 0.4
        frontButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        backButton.layer.cornerRadius = 13
        backButton.layer.borderWidth = 0.4
        backButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        plannigButton.layer.cornerRadius = 13
        plannigButton.layer.borderWidth = 0.4
        plannigButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor

    }
}
