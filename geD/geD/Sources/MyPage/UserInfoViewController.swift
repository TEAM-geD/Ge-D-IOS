//
//  UserInfoViewController.swift
//  geD
//
//  Created by 김민순 on 2021/08/01.
//

import UIKit

class UserInfoViewController: BaseViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboardWhenTappedAround()
        placeholderSetting()
        self.title = "내 정보 수정"
        profileImageView.layer.cornerRadius = 20
        introduceTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(doneView.snp.bottom)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constant.snsTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: Constant.snsTableViewCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 50
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.snsTableViewCellIdentifier, for: indexPath) as! SnsTableViewCell
        
        return cell
    }
    
    
}

extension UserInfoViewController: UITextViewDelegate {
    func placeholderSetting() {
        introduceTextView.delegate = self
        introduceTextView.text = "간단한 소개를 입력해주세요."
        introduceTextView.textColor = .lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "간단한 소개를 입력해주세요."
            textView.textColor = .lightGray
        }
    }
}
