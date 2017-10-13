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
        // 내용을 입력하지 않은 경우 경고 띄우기
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
