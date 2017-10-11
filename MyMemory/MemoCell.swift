//
//  MemoCell.swift
//  MyMemory
//
//  Created by Lee JongJin on 2017. 10. 11..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {

    // A셀,B셀 공통
    @IBOutlet var subject: UILabel!     // 메모 제목
    @IBOutlet var contents: UILabel!    // 메모 내용
    @IBOutlet var regdate: UILabel!     // 등록 일자
    
    // B셀
    @IBOutlet var img: UIImageView!     // 이미지
    
}
