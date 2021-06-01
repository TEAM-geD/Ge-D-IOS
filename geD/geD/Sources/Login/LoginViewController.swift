//
//  UIViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit

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
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        containerView.frame = self.view.frame
        
        window?.addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(slideUpViewTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        
        containerView.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.containerView.alpha = 0.8
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
                        self.containerView.alpha = 0.8
                        self.slideUpView.frame = CGRect(x: 0, y: Device.height - self.slideUpViewHeight, width: Device.width, height: self.slideUpViewHeight)
                       }, completion: nil)
        
        setUpSlideUpView()
    }
    
    @objc func slideUpViewTapped() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.containerView.alpha = 0
                        self.slideUpView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideUpViewHeight)
                       }, completion: nil)
    }
    
    func setUpSlideUpView() {
        let closeButton = UIButton()
        
        closeButton.frame = CGRect(x: Device.width * 0.88, y: slideUpView.bounds.minY + 20, width: Device.width * 0.069, height: Device.height * 0.023)
        closeButton.center.y = closeImageView.bounds.height / 2
        closeButton.setTitleColor(UIColor(hex: 0x393939), for: .normal)
        closeButton.setTitle("닫기", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        slideUpView.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(LoginViewController.closeButtonPressed), for: .touchUpInside)
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
