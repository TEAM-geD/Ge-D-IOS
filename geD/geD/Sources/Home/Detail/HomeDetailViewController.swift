//
//  HomeDetailViewController.swift
//  geD
//
//  Created by 김민석 on 2021/06/25.
//

import UIKit

class HomeDetailViewController: UIViewController {
    @IBOutlet weak var DetailTableView: UITableView!
    @IBOutlet weak var joinButton: UIButton!
    var projectIdx = 0
    var heartButton = UIButton(type: .custom)
    var detailInfo: DetailInfo?
    var isHeart = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
        DetailTableView.register(UINib(nibName: "DetailImageCell", bundle: nil), forCellReuseIdentifier: "DetailImageCell")
        joinButton.layer.cornerRadius = 10
        joinButton.backgroundColor = .bluePurple
        self.showIndicator()
        ProjectDataManager().DetailInquire(vc: self, idx: projectIdx)
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
    @IBAction func joinButtonTouchUpInside(_ sender: UIButton) {
        guard let popUpVC = self.storyboard?.instantiateViewController(identifier: "PopUpViewController") else {
            return
        }
        let input = JoinInput(projectIdx: projectIdx)
        ProjectDataManager().ProjectJoin(input, vc: self)
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
    }
    func didSuccessReq(result: DetailInfo?) {
        self.dismissIndicator()
        detailInfo = result
        isHeart = detailInfo?.projectLikeStatus ?? 100
        if isHeart == 0 {
            heartButton.setImage(UIImage(named: "icHeart"), for: .normal)
            heartButton.isSelected = false
        } else if isHeart == 1 {
            heartButton.setImage(UIImage(named: "icProjectkeepHeart"), for: .normal)
            heartButton.isSelected = true
        }
        DetailTableView.reloadData()
    }
    func failToReq(message: String) {
        self.presentAlert(title: message)
    }
    
    

}
extension HomeDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let imgCell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as? DetailImageCell else{
            return UITableViewCell()
        }
        return imgCell
    }
    
    
}

extension HomeDetailViewController{
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
        print(isHeart)
        
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
        let input = HeartInput(projectIdx: projectIdx)
        ProjectDataManager().ProjectHeartPost(input, vc: self)
    }
}
