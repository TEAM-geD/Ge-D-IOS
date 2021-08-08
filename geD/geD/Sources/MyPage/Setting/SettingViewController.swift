//
//  SettingViewController.swift
//  geD
//
//  Created by 김민순 on 2021/07/04.
//

import UIKit
import MessageUI
import KeychainSwift

class SettingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let settingTitles = ["Push 알림 설정", "앱 버전 정보", "약관 및 정책", "오픈소스 라이브러리", "문의하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "설정"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        
        addFooterView()
    }
    
    func addFooterView() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height))
        
        footer.backgroundColor = UIColor(white: 54.0 / 255.0, alpha: 1.0)
        let logoutButton = UIButton()
        let textColor = UIColor(white: 113.0 / 255.0, alpha: 1.0)
        
        let attr = NSAttributedString(
            string: "로그아웃", attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.font : UIFont.AppleSDGothicNeo(.regular, size: 12)])
        logoutButton.setAttributedTitle(attr, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
        if isLogin() {
            footer.addSubview(logoutButton)
            logoutButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.right.equalToSuperview().inset(20)
            }
        }
        
        self.tableView.tableFooterView = footer
    }
    
    @objc func logoutButtonPressed() {
        let logoutVC = CustomAlertViewController("로그아웃 하시겠습니까?", "")
        logoutVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        logoutVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        logoutVC.doneButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        self.present(logoutVC, animated: true, completion: nil)
    }
    
    @objc func logout() {
        if isLogin() {
            KeychainSwift().delete("jwtToken")
        }
        
        goToLogin()
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = settingTitles[indexPath.row]
        let image = UIImage(named: "icSettingGo")
        let accessory  = UIImageView(frame:CGRect(x:0, y:0, width:(image?.size.width)!, height:(image?.size.height)!))
        accessory.image = image
        
        // set cell
        cell.textLabel?.textColor = UIColor.white
        cell.isUserInteractionEnabled = true
        accessory.tintColor = UIColor.white
        cell.accessoryView = accessory
        cell.backgroundColor = UIColor(hex: 0x2B2B2B)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let settingTitle = settingTitles[indexPath.row]
        switch settingTitle {
        case "앱 버전 정보":
            let versionVC = VersionViewController(Constant.appVersionText)
            versionVC.title = settingTitle
            self.navigationController?.pushViewController(versionVC, animated: true)
        case "오픈소스 라이브러리":
            let versionVC = VersionViewController(Constant.openSourceText)
            versionVC.title = settingTitle
            self.navigationController?.pushViewController(versionVC, animated: true)
        case "문의하기":
            if MFMailComposeViewController.canSendMail() {
                let compseVC = MFMailComposeViewController()
                compseVC.mailComposeDelegate = self
                
                compseVC.setToRecipients([Constant.customerServiceEmail])
                
                self.present(compseVC, animated: true, completion: nil)
                
            } else {
                self.presentAlert(title: "메일을 보낼 수 없습니다.")
            }
        case "약관 및 정책":
            let termsVC = TermsViewController()
            termsVC.title = settingTitle
            self.navigationController?.pushViewController(termsVC, animated: true)
        default:
            return
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
