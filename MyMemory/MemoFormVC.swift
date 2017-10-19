//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by Lee JongJin on 2017. 10. 11..
//  Copyright © 2017년 monk773. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    var subject: String!    // 내용의 첫 줄을 추출하여 제목으로 사용(제목 따로 입력 안받음)
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 경고창 사용될 콘텐츠 뷰 컨틀롤러 구성
        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        // 내용을 입력하지 않은 경우 경고 띄우기
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertV, forKey: "contentViewController")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // MemoData 객체 생성, 데이터 읽기
//        let data = MemoData()
//
//        data.title = self.subject
//        data.contents = self.contents.text
//        data.image = self.preview.image
//        data.regdate = Date()
        
        let data = MemoData(title: self.subject, contents: self.contents.text, image: self.preview.image)
        
        // 앱 델리게이트 객체 읽어온 다음, memolist 배열에 MemoData 객체 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // 작성폼 화면 종료, 이전 화면으로 되돌아가기
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()  // 델리게이트 패턴 기반으로 동작
        picker.delegate = self
        picker.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "이미지를 가져올 곳을 선택해주세요.", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .savedPhotosAlbum
            }
            
            // 이미지 피커 화면을 표시
            self.present(picker, animated: false, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "저장앨범", style: .default, handler: { (action) in
            picker.sourceType = .savedPhotosAlbum
            
            // 이미지 피커 화면을 표시
            self.present(picker, animated: false, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "사진 라이브러리", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            
            // 이미지 피커 화면을 표시
            self.present(picker, animated: false, completion: nil)
        }))
        
        // 메뉴 표시
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        self.contents.delegate = self

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "memo-background")!)
        
        contents.layer.borderWidth = 0
        contents.layer.borderColor = UIColor.clear.cgColor
        contents.backgroundColor = UIColor.clear
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        contents.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedStringKey.paragraphStyle: style])
        contents.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 이미지 선택을 완료했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 선택된 이미지를 미리보기에 표시
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        // 이미지 피커 컨트롤러 닫기
        picker.dismiss(animated: false, completion: nil)
    }
    
    // 텍스트 뷰에 내용 입력시 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비기에션 타이틀에 표시
        self.navigationItem.title = subject
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts, animations: { bar?.alpha = ( bar?.alpha == 0 ? 1 : 0 )})
    }

}
