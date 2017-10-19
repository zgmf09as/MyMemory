//
//  CSLogButton.swift
//  MyMemory
//
//  Created by monk773 on 2017. 10. 19..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

public enum CSLogType: Int {
    case basic  // 기본 로그 타입
    case title  // 버튼 타이틀 출력
    case tag    // 버튼 태그 출력
}

class CSLogButton: UIButton {

    public var logType: CSLogType = .basic
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        tintColor = UIColor.white
        
        addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    
    @objc func logging(_ sender: UIButton) {
        switch self.logType {
        case .basic:
            NSLog("버튼 클릭")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는" // ?? -> Nil병합연산자, 앞에 옵셔널이 nil인경우 연산자 뒤에꺼가 사용 아닌 경우 앞에 옵셔널 해제하여 사용
            NSLog("\(btnTitle) 버튼 클릭")
        case .tag:
            NSLog("\(sender.tag) 버튼 클릭")
        }
    }
}
