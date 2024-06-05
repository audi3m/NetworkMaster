//
//  ViewController.swift
//  NetworkMaster
//
//  Created by J Oh on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

// 옵셔널로 지정하면 어느 부분이 오류인지 알 수 있음
struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}


class ViewController: UIViewController {
    
    let numberTextField = UITextField()
    let checkButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func configHierarchy() {
        view.addSubview(numberTextField)
        view.addSubview(checkButton)
        view.addSubview(resultLabel)
    }
    
    func configLayout() {
        numberTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(checkButton.snp.bottom).offset(20)
        }
    }
    
    func configUI() {
        view.backgroundColor = .white
        
        numberTextField.backgroundColor = .systemGray6
        
        checkButton.backgroundColor = .blue
        checkButton.setTitle("당첨 번호 확인", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        checkButton.layer.cornerRadius = 10
        
        
        resultLabel.backgroundColor = .cyan
        resultLabel.numberOfLines = 0
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.textAlignment = .center
        
    }
    
    // 1. URL
    // 2. responseString 확인
    // 3. nil
    @objc func checkButtonClicked() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(numberTextField.text!)"
        
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                print(value)
                self.resultLabel.text = "\(value.drwNoDate)\n1등 당첨금액: \(value.firstWinamnt.formatted())원"
            case .failure(let error):
                print(error)
                self.resultLabel.text = "올바른 값을 입력해주세요"
            }
        }
        
        view.endEditing(true)
        
        //        AF.request(url).responseString { response in
        //            print(response)
        //        }
    }
    
    
    
    
}

