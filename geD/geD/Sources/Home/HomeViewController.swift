//
//  HomeViewController.swift
//  geD
//
//  Created by 김민순 on 2021/05/31.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var iosButton: UIButton!
    @IBOutlet weak var aosButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var heartButton: UIButton!
    let exImg = ["imgHomeProject01", "imgHomeProject02", "imgHomeProject03", "imgHomeProject04", "imgHomeProject05", "imgHomeProject06"]
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        buttonLayout()
        UINavigationBar.appearance().barTintColor = UIColor(red: 33/255, green: 33/255 , blue: 33/255, alpha: 1)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
    
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.heartImgView.image = UIImage()
        cell.projectImgView.image = UIImage(named: exImg[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("셀 클릭")
        guard let DetailVC = self.storyboard?.instantiateViewController(identifier: "HomeDetailViewController") else {
            return
        }
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
