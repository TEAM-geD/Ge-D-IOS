//
//  UIViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    @IBOutlet weak var termsLabel: UILabel!
    var containerView = UIView()
    var slideUpView = UIView()
    var closeImageView = UIImageView()
    var slideUpViewHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slideUpViewHeight = Device.height * 0.86
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapFunction))
        termsLabel.addGestureRecognizer(tap)
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTransparent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isTransparent = false
    }

    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let termsView = UIView()
        
        slideUpView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        let window = self.view.window
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0)
        containerView.frame = self.view.frame
        
        window?.addSubview(containerView)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.containerView.alpha = 0
                       }, completion: nil)
        
        slideUpView.frame = CGRect(x: 0, y: Device.height, width: Device.width, height: slideUpViewHeight)
        closeImageView.frame = CGRect(x: 0, y: slideUpView.bounds.minY, width: Device.width, height: Device.height * 0.06)
        closeImageView.image = UIImage(named: "277.png")
        
        slideUpView.addSubview(closeImageView)
        termsView.frame = CGRect(x: 0, y: closeImageView.bounds.maxY, width: Device.width, height: slideUpViewHeight - closeImageView.bounds.height)
        termsView.backgroundColor = .white
        slideUpView.addSubview(termsView)
        window?.addSubview(slideUpView)
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.containerView.alpha = 0
                        self.slideUpView.frame = CGRect(x: 0, y: Device.height - self.slideUpViewHeight, width: Device.width, height: self.slideUpViewHeight)
                       }, completion: nil)
        
        setUpSlideUpView()
    }
    
    func setUpSlideUpView() {
        let closeButton = UIButton()
        let mySegementControl = UISegmentedControl(items: ["서비스", "개인정보", "위치정보"])
        let termsTitleLable = UILabel()
        let termsScrollView = UIScrollView()
        
        // 세그먼트 컨트롤 추가
        mySegementControl.frame = CGRect(x: Device.width * 0.05, y: closeImageView.bounds.maxY + 21, width: Device.width * 0.9, height: 32)
        let titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
        mySegementControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        mySegementControl.selectedSegmentTintColor = .white
        mySegementControl.selectedSegmentIndex = 0
        mySegementControl.backgroundColor = UIColor.init(hex: 0x767680, alpha: 0.12)
        
        slideUpView.addSubview(mySegementControl)
        
        
        // 닫기 버튼 추가
        closeButton.frame = CGRect(x: Device.width * 0.88, y: slideUpView.bounds.minY + 20, width: Device.width * 0.069, height: Device.height * 0.023)
        closeButton.center.y = closeImageView.bounds.height / 2
        closeButton.setTitleColor(UIColor(hex: 0x393939), for: .normal)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        slideUpView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(LoginViewController.closeButtonPressed), for: .touchUpInside)
        
        // 약관 제목 추가
        termsTitleLable.text = "서비스 이용약관"
        termsTitleLable.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        termsTitleLable.textColor = .black
        slideUpView.addSubview(termsTitleLable)
        termsTitleLable.snp.makeConstraints { (make) in
            make.left.equalTo(slideUpView.snp.left).inset(19)
            make.top.equalTo(closeImageView.snp.bottom).offset(107)
        }
        
        // 약관 내용 추가
        termsScrollView.isScrollEnabled = true
        termsScrollView.showsVerticalScrollIndicator = true
        termsScrollView.indicatorStyle = .black
        
        slideUpView.addSubview(termsScrollView)
        termsScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(termsTitleLable.snp.bottom).offset(37)
            make.left.equalTo(slideUpView.snp.left).offset(19)
            make.right.equalTo(slideUpView.snp.right).offset(-11)
            make.bottom.equalTo(slideUpView.snp.bottom).offset(-122)
            
            
        }
        
        let firstTermsLabel = UILabel()
        firstTermsLabel.text = "제 1장 총칙"
        firstTermsLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        firstTermsLabel.textColor = .black
        termsScrollView.addSubview(firstTermsLabel)
        
        firstTermsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(termsScrollView.snp.top)
            make.left.equalTo(termsScrollView.snp.left)
        }
        
        let firstTermsContentLabel = UILabel()
        firstTermsContentLabel.numberOfLines = 0
        firstTermsContentLabel.textColor = .black
        firstTermsContentLabel.textAlignment = .left
        firstTermsContentLabel.font = UIFont.systemFont(ofSize: 12)
        firstTermsContentLabel.text = "제1조 (목적)\n이 이용약관(이하 ‘약관’)은 게디(이하 ‘회사’)와 이용 고객(이하 ‘회원’)간에 회사가 제공하는 게디앱 서비스(이하 ‘서비스’)의 가입조건 및 이용에 관한 제반 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조 (이용약관의 효력 및 변경)\n1. 이 약관은 서비스를 이용하고 하는 모든 회원에 대하여 그 효력을 발생합니다.\n2. 이 약관은 게디앱에 공시됨으로써 효력이 발생되고, 합리적인 사유가 발생할 경우 회사는 관계법령에 위배되지 않는 범위에서 이 약관을 변경할 수 있습니다.\n3. 개정약관도 게디앱 사이트에 온라인으로 공시됨으로써 효력이 발생됩니다. 회사는 약관을 변경할 경우 지체 없이 이를 공시하여야 하고, 회원의 권리나 의무등에 관한 중요사항을 개정할 경우에는 사전에 공시하여야 합니다.\n4. 이 약관에 동의하는 것은 정기적으로 레핏앱 사이트를 방문하여 약관의제1조 (목적)\n이 이용약관(이하 ‘약관’)은 게디(이하 ‘회사’)와 이용 고객(이하 ‘회원’)간에 회사가 제공하는 게디앱 서비스(이하 ‘서비스’)의 가입조건 및 이용에 관한 제반 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조 (이용약관의 효력 및 변경)\n1. 이 약관은 서비스를 이용하고 하는 모든 회원에 대하여 그 효력을 발생합니다.\n2. 이 약관은 게디앱에 공시됨으로써 효력이 발생되고, 합리적인 사유가 발생할 경우 회사는 관계법령에 위배되지 않는 범위에서 이 약관을 변경할 있습니다.\n3. 개정약관도 게디앱 사이트에 온라인으로 공시됨으로써 효력이 발생됩니다. 회사는 약관을 변경할 경우 지체 없이 이를 공시하여야 하고, 회원의 권리나 의무등에 관한 중요사항을 개정할 경우에는 사전에 공시하여야 합니다.\n4. 이 약관에 동의하는 것은 정기적으로 레핏앱 사이트를 방문하여 약관의제1조 (목적)\n이 이용약관(이하 ‘약관’)은 게디(이하 ‘회사’)와 이용 고객(이하 ‘회원’)간에 회사가 제공하는 게디앱 서비스(이하 ‘서비스’)의 가입조건 및 이용에 관한 제반 사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n제2조 (이용약관의 효력 및 변경)\n1. 이 약관은 서비스를 이용하고 하는 모든 회원에 대하여 그 효력을 발생합니다.\n2. 이 약관은 게디앱에 공시됨으로써 효력이 발생되고, 합리적인 사유가 발생할 경우 회사는 관계법령에 위배되지 않는 범위에서 이 약관을 변경할 있습니다.\n3. 개정약관도 게디앱 사이트에 온라인으로 공시됨으로써 효력이 발생됩니다. 회사는 약관을 변경할 경우 지체 없이 이를 공시하여야 하고, 회원의 권리나 의무등에 관한 중요사항을 개정할 경우에는 사전에 공시하여야 합니다.\n4. 이 약관에 동의하는 것은 정기적으로 레핏앱 사이트를 방문하여 약관의"
        
        termsScrollView.addSubview(firstTermsContentLabel)
        firstTermsContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstTermsLabel.snp.bottom).offset(25)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        
    }
    
    @objc
    func closeButtonPressed(sender: UIButton) {
        print("Close button pressed")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.containerView.alpha = 0
                        self.slideUpView.frame = CGRect(x: 0, y: Device.height, width: Device.width, height: self.slideUpViewHeight)
                       }, completion: nil)
    }

}
