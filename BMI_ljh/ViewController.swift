//
//  ViewController.swift
//  BMI_ljh
//
//  Created by LimJongHoon on 11/13/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    @IBAction func calcBmi(_ sender: UIButton) {
        // 입력값 검증
        guard let heightText = txtHeight.text, !heightText.isEmpty,
              let weightText = txtWeight.text, !weightText.isEmpty,
              let height = Double(heightText),
              let weight = Double(weightText),
              height > 0, weight > 0 else {
            lblResult.textColor = .red
            lblResult.text = "⚠️ 키와 체중을 올바르게 입력하세요!"
            return
        }
        
        // BMI 계산
        let bmi = weight / (height * height * 0.0001) // kg/m*m
        let shortenedBmi = String(format: "%.1f", bmi)
        
        // BMI 판정 및 출력 결과 구성
        var body = ""
        var color: UIColor = .black
        var emoji = ""
        
        switch bmi {
        case ..<18.5:
            body = "저체중"
            color = .blue
            emoji = "🥶"
        case 18.5..<25:
            body = "정상"
            color = .green
            emoji = "😊"
        case 25..<30:
            body = "1단계 비만"
            color = .orange
            emoji = "😐"
        case 30..<40:
            body = "2단계 비만"
            color = .red
            emoji = "😟"
        default:
            body = "3단계 비만"
            color = .darkGray
            emoji = "😱"
        }
        
        // 결과 출력
        lblResult.textColor = color
        lblResult.text = "\(emoji) BMI: \(shortenedBmi), 판정: \(body)"
        
        // 추가: BMI에 따라 애니메이션 효과
        lblResult.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.lblResult.transform = .identity
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트 필드 스타일 설정
        configureTextField(txtHeight)
        configureTextField(txtWeight)
        
        // 결과 라벨 스타일 설정
        configureResultLabel(lblResult)
    }
    
    // 텍스트 필드 스타일 설정
    func configureTextField(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor // 테두리 색상
        textField.layer.borderWidth = 2.0                 // 테두리 두께
        textField.layer.cornerRadius = 5.0               // 모서리 둥글게
        textField.layer.masksToBounds = true             // 내용 잘리지 않도록
    }
    
    // 결과 라벨 스타일 설정
    func configureResultLabel(_ label: UILabel) {
        label.layer.cornerRadius = 10.0                 // 테두리 둥글게
        label.layer.masksToBounds = true                // 내용 잘리지 않도록
    }
    
}
