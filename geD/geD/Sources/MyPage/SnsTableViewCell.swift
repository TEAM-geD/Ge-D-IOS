//
//  SnsTableViewCell.swift
//  geD
//
//  Created by 김민순 on 2021/08/02.
//

import UIKit

class SnsTableViewCell: UITableViewCell {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var snsIconButton: UIButton!
    @IBOutlet weak var selectSnsButton: UIButton!
    var snsName = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.urlTextField.layer.borderWidth = 1
        self.urlTextField.layer.borderColor = UIColor(white: 90.0 / 255.0, alpha: 1.0).cgColor
        self.urlTextField.attributedPlaceholder = NSAttributedString(string: "URL을 입력해주세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor(white: 90.0 / 255.0, alpha: 1.0), NSAttributedString.Key.font : UIFont.AppleSDGothicNeo(.regular, size: 16)])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
