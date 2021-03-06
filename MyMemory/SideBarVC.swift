//
//  SideBarVC.swift
//  MyMemory
//
//  Created by monk773 on 2017. 10. 20..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

enum btnStatus: Int {
    case new = 0
    case fnew = 1
    case calendar = 2
    case noti = 3
    case statistics = 4
    case account = 5
}

class SideBarVC: UITableViewController {

    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png")
    ]
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setHederArea()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // Configure the cell...
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
//            let target = self.revealViewController().frontViewController as! UINavigationController
//            target.pushViewController(uv!, animated: true)
//            self.revealViewController().revealToggle(self)
//        } else if indexPath.row == 5 {
//
//        }
        
        switch btnStatus(rawValue: indexPath.row) {
        case btnStatus.new?:
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController().frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController().revealToggle(self)
        case btnStatus.account?:
            let uv = storyboard?.instantiateViewController(withIdentifier: "_Profile")
            present(uv!, animated: true) {
                self.revealViewController().revealToggle(self)
            }
        default:
            break
        }
    }

    private func setHederArea() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        
        headerView.backgroundColor = UIColor.brown
        
        tableView.tableHeaderView = headerView
        
        nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        nameLabel.text = "꼼꼼한 재은 씨"
        nameLabel.textColor = UIColor.white
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.backgroundColor = UIColor.clear
        
        headerView.addSubview(nameLabel)
        
        emailLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y*2, width: 100, height: 30)
        
        emailLabel.text = "sqlpro@naver.com"
        emailLabel.textColor = UIColor.white
        
        emailLabel.font = UIFont.systemFont(ofSize: 11)
        emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        let defaultProfile = UIImage(named: "account.jpg")
        profileImage.image = defaultProfile
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 0
        
        headerView.addSubview(profileImage)
    }
}
