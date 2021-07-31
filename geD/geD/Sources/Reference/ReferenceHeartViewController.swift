import UIKit

class ReferenceHeartViewController: BaseViewController {

    @IBOutlet weak var heartCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        heartCollectionView.dataSource = self
        heartCollectionView.delegate = self
        heartCollectionView.register(UINib(nibName: "ReferenceHeartCell", bundle: nil), forCellWithReuseIdentifier: "ReferenceHeartCell")
        navigationSetting()
        ReferenceDataManager().referenceHeartInquire(vc: self)
    
    }
}
extension ReferenceHeartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReferenceHeartCell", for: indexPath) as? ReferenceHeartCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        return cell
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
        let width = (heartCollectionView.frame.width - 40) / 2 - 11
        let size = CGSize(width: width, height: 234)
        return size
    }
    
    
}
extension ReferenceHeartViewController {
    func navigationSetting(){
        self.navigationController?.navigationBar.isTransparent = true
        UINavigationBar.appearance().barTintColor = UIColor(red: 33/255, green: 33/255 , blue: 33/255, alpha: 1)
        self.navigationItem.title = "찜한 내역"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
