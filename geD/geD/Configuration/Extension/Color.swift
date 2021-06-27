//
//  Color.swift
//  geD
//
//  Created by 김민순 on 2021/05/24.
//

import UIKit

extension UIColor {
    // MARK: hex code를 이용하여 정의
    // ex. UIColor(hex: 0xF5663F)
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    // MARK: 메인 테마 색 또는 자주 쓰는 색을 정의
    // ex. label.textColor = .mainBlack
    class var mainBlack: UIColor { UIColor(hex: 0x272727) }
    class var mainUltraPurple: UIColor { UIColor(hex: 0x4e03f7) }
    class var subGray: UIColor { UIColor(hex: 0xa6Adc2) }
    class var subSoftPurple: UIColor { UIColor(hex: 0x8D6Cf8) }
    class var subMediumPurple: UIColor { UIColor(hex: 0x9262Fc) }
    class var subDeepPurple: UIColor { UIColor(hex: 0x7D5Cff) }
    class var bluePurple: UIColor { UIColor(red: 78.0 / 255.0, green: 3.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)}
}
