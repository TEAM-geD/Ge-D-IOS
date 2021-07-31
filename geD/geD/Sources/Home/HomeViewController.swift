//
//  HomeViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit
import KeychainSwift
class HomeViewController: BaseViewController {
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var iosButton: UIButton!
    @IBOutlet weak var aosButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var heartButton: UIButton!
    let exImg = ["imgHomeProject01", "imgHomeProject02", "imgHomeProject03", "imgHomeProject04", "imgHomeProject05", "imgHomeProject06"]
    var types = "ALL"
    var projectInfo: [projectInfo?] = []
    var projectIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        // buttonLayout()
        UINavigationBar.appearance().barTintColor = UIColor(red: 39/255, green: 39/255 , blue: 39/255, alpha: 1)
        view.backgroundColor = UIColor(red: 39/255, green: 39/255 , blue: 39/255, alpha: 1)
        homeCollectionView.backgroundColor = UIColor(red: 39/255, green: 39/255 , blue: 39/255, alpha: 1)
        ProjectDataManager().projectInquire(type: types, vc: self)
        allButton.isSelected = true
        allButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        iosButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        aosButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
        webButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    @objc func buttonSelected(_ sender: UIButton) {
        switch sender {
        case allButton:
            allButton.isSelected = true
            iosButton.isSelected = false
            aosButton.isSelected = false
            webButton.isSelected = false
            types = "ALL"
        case iosButton:
            iosButton.isSelected = true
            allButton.isSelected = false
            aosButton.isSelected = false
            webButton.isSelected = false
            types = "IOS"
        case aosButton:
            aosButton.isSelected = true
            iosButton.isSelected = false
            allButton.isSelected = false
            webButton.isSelected = false
            types = "AOS"
        case webButton:
            webButton.isSelected = true
            iosButton.isSelected = false
            aosButton.isSelected = false
            allButton.isSelected = false
            types = "WEB"
        default:
            break
        }
        ProjectDataManager().projectInquire(type: types, vc: self)
    }
    func buttonLayout(){
        allButton.layer.cornerRadius = 13
        allButton.layer.borderWidth = 0.4
        allButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        iosButton.layer.cornerRadius = 13
        iosButton.layer.borderWidth = 0.4
        iosButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        aosButton.layer.cornerRadius = 13
        aosButton.layer.borderWidth = 0.4
        aosButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor
        webButton.layer.cornerRadius = 13
        webButton.layer.borderWidth = 0.4
        webButton.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1).cgColor

    }
    @IBAction func heartButtonTouchUpInside(_ sender: UIButton) {
        guard let heartVC = self.storyboard?.instantiateViewController(identifier: "HeartViewController") else {
            return
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(heartVC, animated: true)
    }
    func didSuccessReq(result: [projectInfo?]) {
        projectInfo = result
        homeCollectionView.reloadData()
    }
    func failToReq(message: String) {
        self.presentAlert(title: message)
    }
    
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        let projectInquire = projectInfo[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.heartImgView.image = UIImage()
        cell.projectImgView.image = UIImage(named: exImg[indexPath.row])
        cell.projectNameTextView.text = projectInquire?.projectName
        cell.userInfoLb.text = "\(projectInquire?.userName ?? "") | \(projectInquire?.userJob ?? "")"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 클릭")
        let projectInquire = projectInfo[indexPath.row]
        projectIdx = projectInquire?.projectIdx ?? 0
        guard let DetailVC = self.storyboard?.instantiateViewController(identifier: "HomeDetailViewController") as? HomeDetailViewController else {
            return
        }
        DetailVC.projectIdx = projectIdx

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return sectionInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (homeCollectionView.frame.width - 40) / 2 - 11
        let size = CGSize(width: width, height: 234)
        return size
    }
    
    
}
