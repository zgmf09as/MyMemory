//
//  ProfileVC.swift
//  MyMemory
//
//  Created by monk773 on 2017. 10. 23..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileImage = UIImageView() // 프로플 사진 이미지
    let tv = UITableView() //프로필 목록
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = "꼼꼼한 재은 씨"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = "sqlpro@naver.com"
        default:
            ()
        }
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // back button
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        
        navigationItem.leftBarButtonItem = backBtn
        
        // background setting
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
        
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        
        bgImg.center = CGPoint(x: view.frame.width/2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width/2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        view.addSubview(bgImg)
        
        // profileSetting
        let image = UIImage(named: "account.jpg")
        
        profileImage.image = image
        profileImage.frame.size = CGSize(width: 100, height: 100)
        profileImage.center = CGPoint(x: view.frame.width/2, y: 270)
        
        profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true
        
        view.addSubview(profileImage)
        
        tv.frame = CGRect(x: 0, y: profileImage.frame.origin.y + self.profileImage.frame.size.height + 20 , width: self.view.frame.width
            , height: 100)
        
        tv.dataSource = self
        tv.delegate = self
        
        view.addSubview(tv)
    }
    
    @objc func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
