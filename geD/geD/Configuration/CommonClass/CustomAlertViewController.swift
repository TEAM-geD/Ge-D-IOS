//
//  CustomAlertView.swift
//  geD
//
//  Created by 김민순 on 2021/07/11.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var titleString: String?
    var contentString: String?
    var doneButton = UIButton()
    
    init(_ titleString: String, _ contentString: String) {
        self.titleString = titleString == "" ? nil : titleString
        self.contentString = contentString == "" ? nil : contentString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    func updateView() {
        
        self.view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.4)
        
        let alertView = UIView()
        alertView.layer.cornerRadius = 10
        alertView.backgroundColor = UIColor(white: 244.0 / 255.0, alpha: 1.0)
        self.view.addSubview(alertView)
        alertView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Device.height * 0.29)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icPopupWarning")
        imageView.contentMode = .scaleAspectFill
        alertView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(33)
            make.centerX.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        alertView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
        }
        
        if self.titleString != nil {
            titleLabel.text = titleString
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            titleLabel.textColor = UIColor(white: 110.0 / 255.0, alpha: 1.0)
        } else {
            titleLabel.snp.makeConstraints { make in
                make.height.equalTo(0)
            }
        }
        
        let contentLabel = UILabel()
        alertView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.8)
            make.centerX.equalToSuperview()
        }
        
        if self.contentString != nil {
            contentLabel.text = contentString
            contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            contentLabel.textColor = UIColor(white: 110.0 / 255.0, alpha: 1.0)
            contentLabel.textAlignment = .center
            contentLabel.numberOfLines = 3
        } else {
            contentLabel.snp.makeConstraints { make in
                make.height.equalTo(0)
            }
        }
        
        doneButton.setTitle("확인", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        doneButton.setTitleColor(UIColor(white: 110.0 / 255.0, alpha: 1.0), for: .normal)
       
        let cancelButton = UIButton()
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        cancelButton.setTitleColor(UIColor(white: 152.0 / 255.0, alpha: 1.0), for: .normal)
        cancelButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        alertView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(21)
            make.height.equalTo(25)
            make.left.equalToSuperview().inset(114)
        }
        
        alertView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(doneButton)
            make.right.equalToSuperview().inset(114)
        }
        
        alertView.snp.makeConstraints { make in
            make.bottom.equalTo(cancelButton.snp.bottom).offset(33)
        }
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
