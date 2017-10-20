//
//  MemoListVC.swift
//  MyMemory
//
//  Created by Lee JongJin on 2017. 10. 11..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {

    // 앱 델리게이트 객체의 참조 정보 로드
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setSideBarCallButton()
    }

    private func setSideBarCallButton() {
        if let revealVC = revealViewController() {
            
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            navigationItem.leftBarButtonItem = btn
            
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    // 테이블의 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.appDelegate.memolist.count
    }

    // 테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // memolist 배열 데이터에서 주어진 ㄴ행에 맞는 데이터 로드
        let row = self.appDelegate.memolist[indexPath.row]
        
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
   
        // 재사용 큐로부터 셀 인스턴스 받기
        let baseCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = baseCell as? MemoCell {
            // 메모 셀 내용 구성
            cell.subject?.text = row.title
            cell.contents?.text = row.contents
            cell.img?.image = row.image
            
            // Date 타입의 날짜를 아래 포맷에 맞게 변경
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.regdate?.text = formatter.string(from: row.regdate!)
            
            return cell
        }
        
        return baseCell
    }
    
    // 테이블의 행을 선택시 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // memolist 배열에서 데이터 로드
        let row = self.appDelegate.memolist[indexPath.row]

        // 상세 화면 인스턴스 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
            return
        }

        // 값 전달 후, 화면 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 화면이 나타날 때마다 호출되는 메소드
    // 1. 타 화면으로 이동했다가 다시 목록으로 돌아왔을때
    // 2. 홈버튼을 눌러 앱이 백그라운드 모드로 내려간후 다시 활성화되었을 때
    // 3. 뷰 컨트롤러가 화면에 표시될 때
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터 다시 읽기. 행 구성 메소드가 재실행 된다.
        self.tableView.reloadData()
    }
}
