//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by Lee JongJin on 2017. 10. 11..
//  Copyright © 2017년 monk773. All rights reserved.
//
// 목록으로부터 값을 전달 받아 컨텐츠를 표현하는 것
// 값을 전달 받는 것은 2가지 유형이 있다.
// 1. 필요한 전첸 콘텐츠를 모두 전달 받기
// 2. 데이터에 대한 참조 키값만 전달받아 공용 저장소에서 직접 그 값을 꺼내오는 방식.
// 아래 구현은 1번으로 구현

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        // 제목, 내용, 이미지 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        // 날짜 포맷
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        // 타이틀 표시
        self.navigationItem.title = dateString
    }
}
