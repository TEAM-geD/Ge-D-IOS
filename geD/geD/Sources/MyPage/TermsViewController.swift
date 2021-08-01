//
//  TermsViewController.swift
//  geD
//
//  Created by 김민순 on 2021/07/31.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

class TermsViewController: BaseViewController {
    let termsTitleLabel = UILabel()
    let firstTermsContentLabel = UILabel()
    let terms = Terms()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 회원 탈퇴 Bar Item 추가
        if isLogin() {
            rightBarButtonItemsLayout()
        }
        
        let mySegementControl = UISegmentedControl(items: ["서비스", "개인정보"])
        
        let terms = Terms()
        let termsScrollView = UIScrollView()
        
        // 세그먼트 컨트롤 추가
    
        let titleTextAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.black]
        mySegementControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        mySegementControl.selectedSegmentTintColor = .white
        mySegementControl.selectedSegmentIndex = 0
        mySegementControl.backgroundColor = UIColor(white: 145.0 / 255.0, alpha: 1.0)
        mySegementControl.addTarget(self, action: #selector(pressSegment), for: UIControl.Event.valueChanged)
        
        view.addSubview(mySegementControl)
        mySegementControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(17)
            make.left.equalToSuperview().inset(14)
            make.right.equalToSuperview().inset(14)
        }
        
        // 약관 제목 추가
        termsTitleLabel.text = terms.titles[0]
        termsTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        termsTitleLabel.textColor = .white
        view.addSubview(termsTitleLabel)
        termsTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.top.equalTo(mySegementControl.snp.bottom).offset(24)
        }
        
        // 약관 내용 추가
        termsScrollView.isScrollEnabled = true
        termsScrollView.showsVerticalScrollIndicator = true
        termsScrollView.indicatorStyle = .white
        
        view.addSubview(termsScrollView)
        termsScrollView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.right.equalToSuperview().inset(14)
            make.top.equalTo(termsTitleLabel.snp.bottom).offset(18)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let firstTermsLabel = UILabel()
        firstTermsLabel.text = "제 1장 총칙"
        firstTermsLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        firstTermsLabel.textColor = .white
        termsScrollView.addSubview(firstTermsLabel)
        
        firstTermsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(termsScrollView.snp.top)
            make.left.equalTo(termsScrollView.snp.left)
        }
        
        firstTermsContentLabel.numberOfLines = 0
        firstTermsContentLabel.textColor = .white
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
    
    func rightBarButtonItemsLayout() {
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "icMypageMore2"), style: .plain, target: self, action: #selector(pressMoreButton))
        self.navigationItem.rightBarButtonItem = moreBarButtonItem
    }
    
    @objc func pressMoreButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        let actionReport = UIAlertAction(title: "회원탈퇴", style: .default) { (action) in
            let logoutVC = CustomAlertViewController("회원 탈퇴를 진행하시겠습니까?", "탈퇴 후 회원정보 복구가 불가능하며\n데이터는 모두 삭제됩니다.")
            logoutVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            logoutVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            logoutVC.doneButton.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
            
            self.present(logoutVC, animated: true, completion: nil)
            
        }

        alert.addAction(actionCancel)
        alert.addAction(actionReport)

        present(alert, animated: true, completion: nil)
    }
    
    @objc func logout() {
        // 카카오 연결 끊기
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
        
        // 네이버 연결 끊기
        let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        naverLoginInstance?.requestDeleteToken()
        
        LogoutDataManager().logout(viewController: self)
    }

    @objc func pressSegment(_ sender: UISegmentedControl) {
        
        let selIdx: Int = sender.selectedSegmentIndex
        
        termsTitleLabel.text = terms.titles[selIdx]
        firstTermsContentLabel.text = terms.contents[selIdx]
    }
}
