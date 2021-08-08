//
//  VersionViewController.swift
//  geD
//
//  Created by 김민순 on 2021/07/31.
//

import UIKit

class VersionViewController: BaseViewController {
    var contentString = ""
    
    init(_ contentString: String) {
        self.contentString = contentString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = .white
        contentLabel.text = contentString
        
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
    }
}
