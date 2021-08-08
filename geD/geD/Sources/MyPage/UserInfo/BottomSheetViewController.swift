//
//  BottomSheetViewController.swift
//  geD
//
//  Created by 김민순 on 2021/08/04.
//

import UIKit

class BottomSheetViewController: UIViewController {
    var defaultHeight: CGFloat = Device.height * 0.35
    
    var delegate: SnsDelegate?
    
    private let containerView: UIView = { () -> UIView in
        let containerView = UIView()
        containerView.backgroundColor = .black
        
        
        
        return containerView
    }()
    
    private let bottomView: UIView = { () -> UIView in
        let bottomView = UIView()
        bottomView.layer.cornerRadius = 49
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.backgroundColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
        
        return bottomView
    }()
    
    private let snsCollectionView: UICollectionView = { () -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 30
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContainer)))
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        bottomView.addGestureRecognizer(gesture)
        gesture.delegate = self
        snsCollectionView.delegate = self
        snsCollectionView.dataSource = self
        snsCollectionView.register(UINib(nibName: "SnsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SnsCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    private func setupUI() {
        self.view.addSubview(containerView)
        self.view.addSubview(bottomView)
        bottomView.addSubview(snsCollectionView)
        
        containerView.alpha = 0.0
        
        setupLayout()
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(Device.height * 0.35 - 49)
        }
        bottomView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Device.height * 0.35)
        }
        snsCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.left.equalToSuperview().inset(58)
            make.right.equalToSuperview().inset(58)
            make.bottom.equalTo(self.bottomView.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func showBottomSheet() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.containerView.alpha = 0.4
        }, completion: nil)
    }
    
    @objc func tapContainer() {
        dismissViewController()
    }
    
    private func dismissViewController() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.containerView.alpha = 0.0
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func shouldDismissWithGesture(_ recognizer: UIPanGestureRecognizer) -> Bool {
        return recognizer.state == .ended
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        if shouldDismissWithGesture(recognizer) {
            dismissViewController()
        }
    }
    
    @objc private func pressSnsButton(_ sender: UIButton) {
        delegate?.selectSns(snsName: Constant.snsNameList[sender.tag], snsImageName: Constant.snsProfileImageNameList[sender.tag])
        
        dismissViewController()
    }
}

extension BottomSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension BottomSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.snsNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SnsCollectionViewCell", for: indexPath) as! SnsCollectionViewCell
        cell.snsLabelButton.setTitle(Constant.snsNameList[indexPath.row], for: .normal)
        cell.snsImageButton.setImage(UIImage(named: Constant.snsImageNameList[indexPath.row]), for: .normal)
        
        let touchButton = UIButton()
        touchButton.tag = indexPath.row
        touchButton.addTarget(self, action: #selector(pressSnsButton(_:)), for: .touchUpInside)
        cell.addSubview(touchButton)
        touchButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ( (collectionView.bounds.width - 30) / 2).rounded(.down), height: 36)
    }
}
