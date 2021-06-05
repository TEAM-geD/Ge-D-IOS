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
    var termsTitleLable = UILabel()
    var slideUpViewHeight: CGFloat = 0.0
    var firstTermsContentLabel = UILabel()
    let terms = Terms()
    
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
       
        let terms = Terms()
        let termsScrollView = UIScrollView()
        
        // 세그먼트 컨트롤 추가
        mySegementControl.frame = CGRect(x: Device.width * 0.05, y: closeImageView.bounds.maxY + 21, width: Device.width * 0.9, height: 32)
        let titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
        mySegementControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        mySegementControl.selectedSegmentTintColor = .white
        mySegementControl.selectedSegmentIndex = 0
        mySegementControl.backgroundColor = UIColor.init(hex: 0x767680, alpha: 0.12)
        mySegementControl.addTarget(self, action: #selector(pressSegment), for: UIControl.Event.valueChanged)
        
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
        termsTitleLable.text = terms.titles[0]
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
        
        firstTermsContentLabel.numberOfLines = 0
        firstTermsContentLabel.textColor = .black
        firstTermsContentLabel.textAlignment = .left
        firstTermsContentLabel.font = UIFont.systemFont(ofSize: 12)
        firstTermsContentLabel.text = terms.contents[0]
        
        termsScrollView.addSubview(firstTermsContentLabel)
        firstTermsContentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstTermsLabel.snp.bottom).offset(25)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func pressSegment(_ sender: UISegmentedControl) {
        
        let selIdx: Int = sender.selectedSegmentIndex
        
        termsTitleLable.text = terms.titles[selIdx]
        firstTermsContentLabel.text = terms.contents[selIdx]
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
