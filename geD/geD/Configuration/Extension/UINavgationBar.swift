//
//  UINavgationBar.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit

extension UINavigationBar {
    // MARK: 네비게이션바를 투명하게 처리
    var isTransparent: Bool {
        get {
            return false
        } set {
            self.isTranslucent = newValue
            self.setBackgroundImage(newValue ? UIImage() : nil, for: .default)
            self.shadowImage = newValue ? UIImage() : nil
            self.backgroundColor = newValue ? .clear : nil
        }
    }
    
    func setBackButtonImage(_ image : UIImage?) {
        self.backIndicatorImage = image
        self.backIndicatorTransitionMaskImage = image
        self.shadowImage = UIImage()
    }
    
}
