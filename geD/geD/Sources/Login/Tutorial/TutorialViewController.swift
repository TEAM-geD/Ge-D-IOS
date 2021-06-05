//
//  TutorialViewController.swift
//  geD
//
//  Created by 김민순 on 2021/06/01.
//

import UIKit

class TutorialViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTransparent = true
    }

}
