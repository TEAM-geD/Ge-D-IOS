//
//  ProjectRegisterViewController.swift
//  geD
//
//  Created by 김민석 on 2021/08/06.
//

import UIKit

class ProjectRegisterViewController: UIViewController {

    @IBOutlet weak var projectInfoView: UIView!
    @IBOutlet weak var projectContentTextView1: UITextView!
    @IBOutlet weak var representView: UIView!
    
    @IBOutlet weak var projectImgView1: UIView!
    @IBOutlet weak var openKakaoView: UIView!
    @IBOutlet weak var projectImgView2: UIView!
    @IBOutlet weak var projectImgView3: UIView!
    
    @IBOutlet weak var googleformView: UIView!
    @IBOutlet weak var projectContentView1: UIView!
    @IBOutlet weak var projectContentView2: UIView!
    @IBOutlet weak var projectContentView3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension ProjectRegisterViewController {
    func viewSetting() {
        projectInfoView.layer.cornerRadius = 12
        
        representView.layer.borderWidth = 1
        representView.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        representView.layer.cornerRadius = 10
        
        projectImgView1.layer.borderWidth = 1
        projectImgView1.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectImgView1.layer.cornerRadius = 10
        projectImgView2.layer.borderWidth = 1
        projectImgView2.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectImgView2.layer.cornerRadius = 10
        projectImgView3.layer.borderWidth = 1
        projectImgView3.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectImgView3.layer.cornerRadius = 10
        
        projectContentView1.layer.borderWidth = 1
        projectContentView1.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectContentView1.layer.cornerRadius = 10
        projectContentView2.layer.borderWidth = 1
        projectContentView2.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectContentView2.layer.cornerRadius = 10
        projectContentView3.layer.borderWidth = 1
        projectContentView3.layer.borderColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0).cgColor
        projectContentView3.layer.cornerRadius = 10
        
        openKakaoView.layer.borderWidth = 1
        openKakaoView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0).cgColor
        openKakaoView.layer.cornerRadius = 9
        
        googleformView.layer.borderWidth = 1
        googleformView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0).cgColor
        googleformView.layer.cornerRadius = 9
    }
}
