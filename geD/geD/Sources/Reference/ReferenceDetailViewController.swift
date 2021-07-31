//
//  ReferenceDetailViewController.swift
//  geD
//
//  Created by 김민석 on 2021/07/18.
//

import UIKit

class ReferenceDetailViewController: UIViewController {
    var heartButton = UIButton(type: .custom)
    var referenceIdx = 0
    var detailInfo: ReferenceDetailInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heartButton.isSelected = true
        navigationSetting()
        ReferenceDataManager().referenceDetailInquire(idx: referenceIdx, vc: self)
        
    }
    func didSuccessReq(result: ReferenceDetailInfo) {
        detailInfo = result
        referenceIdx = detailInfo?.referenceIdx ?? 0
    }

}
extension ReferenceDetailViewController {
    func navigationSetting(){
        self.navigationController?.navigationBar.isTransparent = true
        UINavigationBar.appearance().barTintColor = UIColor(red: 33/255, green: 33/255 , blue: 33/255, alpha: 1)
        self.navigationItem.title = "Film Camera, Project Fil App"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        heartButton.addTarget(self, action: #selector(heartButtonTouchUpInside(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: heartButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        //self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    
    
    @objc func heartButtonTouchUpInside(_ sender: UIButton){
        heartButton.isSelected = !heartButton.isSelected
        if heartButton.isSelected {
            print("버튼클릭")
            heartButton.setImage(UIImage(named: "icProjectkeepHeart"), for: .normal)
        } else {
            heartButton.setImage(UIImage(named: "icHeart"), for: .normal)
        }
        let input = ReferenceHeartInput(referenceIdx: referenceIdx)
        ReferenceDataManager().ReferenceHeartPost(input, vc: self)
        print(referenceIdx)
    }
}
