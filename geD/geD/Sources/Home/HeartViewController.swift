//
//  HeartViewController.swift
//  geD
//
//  Created by 김민석 on 2021/06/22.
//

import UIKit

class HeartViewController: UIViewController {

    @IBOutlet weak var heartTableView: UICollectionView!
    var projectInfo: [projectInfo?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        heartTableView.delegate = self
        heartTableView.dataSource = self
        heartTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        ProjectDataManager().heartListInquire(vc: self)
    }
    let exImg = ["imgHomeProject01", "imgHomeProject02", "imgHomeProject03", "imgHomeProject04", "imgHomeProject05", "imgHomeProject06"]
    override func viewWillAppear(_ animated: Bool) {
    }
    func didSuccessReq(result: [projectInfo?]) {
        projectInfo = result
        heartTableView.reloadData()
    }
    func failToReq(message: String) {
        self.presentAlert(title: message)
    }

    

}
extension HeartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.projectImgView.image = UIImage(named: exImg[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInset = UIEdgeInsets(top: 18, left: 20, bottom: 0, right: 20)
        return sectionInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.heartTableView.frame.width - 40) / 2 - 11
        let size = CGSize(width: width, height: 234)
        return size
    }
}
extension HeartViewController{
    func navigationSetting(){
        self.navigationController?.navigationBar.isTransparent = true
        UINavigationBar.appearance().barTintColor = UIColor(red: 33/255, green: 33/255 , blue: 33/255, alpha: 1)
        self.navigationItem.title = "찜한 내역"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
