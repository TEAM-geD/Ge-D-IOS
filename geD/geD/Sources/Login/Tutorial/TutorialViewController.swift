//
//  TutorialViewController.swift
//  geD
//
//  Created by 김민순 on 2021/06/01.
//

import UIKit

class TutorialViewController: BaseViewController {
    @IBOutlet weak var myViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nextBarButtonItem: UIBarButtonItem!
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let tutorialTitles = ["프로젝트 등록하기", "레퍼런스 찾기", "멤버스 등록하기"]
        let tutorialSubtitles = ["프로젝트를 등록하면 주제와 맞는\n팀원을 구할 수 있어요.", "개발, 디자인, 기획까지\n다양한 레퍼런스를 찾아보세요.", "멤버스를 등록하면\n내 정보를 공개할 수 있어요."]
        let backgroundImages = ["imgTutorial01", "imgTutorial02", "imgTutorial03"]
        let pageControlImages = ["pageControl1", "pageControl2", "pageControl3"]
        let splashImages = ["imgTutorialStep1", "imgTutorialStep2", "imgTutorialStep3"]
        
        myViewWidthConstraint.constant = Device.width * CGFloat(tutorialTitles.count)
        
        
        
        for i in 0..<tutorialTitles.count {
            let backgroundImageView = UIImageView()
            let titleLabel = UILabel()
            let subtitleLabel = UILabel()
            let pageControlImageView = UIImageView()
            let splashImageView = UIImageView()
            
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.image = UIImage(named: backgroundImages[i])
            myView.addSubview(backgroundImageView)
            backgroundImageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.width.equalTo(Device.width)
                make.left.equalToSuperview().offset(CGFloat(i) * Device.width)
            }
            
            titleLabel.text = tutorialTitles[i]
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            titleLabel.textColor = .white
            subtitleLabel.text = tutorialSubtitles[i]
            subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            subtitleLabel.textColor = .white
            subtitleLabel.numberOfLines = 2
            subtitleLabel.textAlignment = .center
            backgroundImageView.addSubview(titleLabel)
            backgroundImageView.addSubview(subtitleLabel)
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().inset(153)
                make.centerX.equalToSuperview()
            }
            
            subtitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
            }
            
            pageControlImageView.image = UIImage(named: pageControlImages[i])
            pageControlImageView.contentMode = .scaleAspectFit
            backgroundImageView.addSubview(pageControlImageView)
            
            pageControlImageView.snp.makeConstraints { (make) in
                make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
                make.centerX.equalToSuperview()
            }
            
            splashImageView.image = UIImage(named: splashImages[i])
            splashImageView.contentMode = .scaleAspectFill
            backgroundImageView.addSubview(splashImageView)
            
            splashImageView.snp.makeConstraints { (make) in
            make.top.equalTo(pageControlImageView.snp.bottom).offset(60)
                make.centerX.equalToSuperview()
            }
        }
        
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTransparent = true
        
        self.navigationItem.hidesBackButton = true
    }

}

extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage = Int(floor(scrollView.contentOffset.x / Device.width))
        
        if currentPage == 2 {
            nextBarButtonItem.title = "Done"
        } else {
            nextBarButtonItem.title = "Skip"
        }
    }
}
