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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
        DetailTableView.register(UINib(nibName: "DetailImageCell", bundle: nil), forCellReuseIdentifier: "DetailImageCell")
        joinButton.layer.cornerRadius = 10
        joinButton.backgroundColor = .bluePurple
    }
    @IBAction func joinButtonTouchUpInside(_ sender: UIButton) {
        guard let popUpVC = self.storyboard?.instantiateViewController(identifier: "PopUpViewController") else {
            return
        }
        popUpVC.modalPresentationStyle = .overCurrentContext
        self.present(popUpVC, animated: false, completion: nil)
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
        //self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    
    
    @objc func heartButtonTouchUpInside(_ sender: UIButton){
        if sender.isSelected {
            print("버튼클릭")
        }
    }
}
