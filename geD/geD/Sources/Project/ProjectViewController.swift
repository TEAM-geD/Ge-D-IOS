//
//  ProjectViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit

class ProjectViewController: BaseViewController {
    @IBOutlet weak var projectInfoView: UIView!
    @IBOutlet weak var textFiledView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    @IBAction func backButtonTouchUpInside(_ sender: UIBarButtonItem) {
        goToMain()
    }
    
}
extension ProjectViewController {
    func viewSetting() {
        self.projectInfoView.layer.cornerRadius = 12
        self.textFiledView.layer.cornerRadius = 10
        self.textFiledView.layer.borderColor = UIColor(red: 224, green: 224, blue: 224, alpha: 1.0).cgColor
        self.textFiledView.layer.borderWidth = 1
        
    }
}
