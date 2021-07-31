//
//  ReferenceViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit

class ReferenceViewController: BaseViewController {
    @IBOutlet weak var uxButton: UIButton!
    @IBOutlet weak var frontButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var plannigButton: UIButton!
    @IBOutlet weak var referenceCollectionView: UICollectionView!
    @IBOutlet weak var heartButton: UIButton!
    var referenceInfo: [ReferenceInfo?] = []
    var referenceIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        referenceCollectionView.dataSource = self
        referenceCollectionView.delegate = self
        referenceCollectionView.register(UINib(nibName: "ReferenceImgCell", bundle: nil), forCellWithReuseIdentifier: "ReferenceImgCell")
        collectionViewSetting()
        var type = 1
        ReferenceDataManager().referenceInquire(type: type, vc: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    func collectionViewSetting() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
    }
    func didSuccessReq(result: [ReferenceInfo?]) {
        referenceInfo = result
        referenceCollectionView.reloadData()
        print("레퍼런스 연결 성공")
    }
    func failToReq(message: String) {
        self.presentAlert(title: message)
    }
    @IBAction func heartButtonTouchUpInside(_ sender: UIButton) {
        guard let heartVC = self.storyboard?.instantiateViewController(identifier: "ReferenceHeartViewController") else {
            return
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(heartVC, animated: true)
    }
}
extension ReferenceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return referenceInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReferenceImgCell", for: indexPath) as? ReferenceImgCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 클릭")
        let referenceInquire = referenceInfo[indexPath.row]
        referenceIdx = referenceInquire?.referenceIdx ?? 0
        guard let DetailVC = self.storyboard?.instantiateViewController(identifier: "ReferenceDetailViewController") as? ReferenceDetailViewController else {
            return
        }
        DetailVC.referenceIdx = referenceIdx
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
    
}



