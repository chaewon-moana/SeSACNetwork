//
//  ViewController.swift
//  SeSACNetwork
//
//  Created by cho on 1/16/24.
//

import UIKit
import Alamofire
//struct Moana {
//    let boxOfficeResult: MiddleMoana
//}
//
//struct MiddleMoana {
//    let boxofficeType: String
//    let showRange: String
//    let dailyBoxOfficeList: [SmallMoana]
//}
//
//struct SmallMoana {
//    let movieNm: String
//    let openDt: String
//}
//


struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoFinal
}

struct PapagoFinal: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
}

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    @IBOutlet var sourceLanguageButton: UIButton!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var targetLanguageButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
        
        sourceLanguageButton.addTarget(self, action: #selector(sourceLanguageButtonTapped), for: .touchUpInside)
        
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        
        targetLanguageButton.addTarget(self, action: #selector(targetLanguageButtonTapped), for: .touchUpInside)
        
        setUI()
        
    }
    
    @objc func sourceLanguageButtonTapped() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        navigationController?.pushViewController(vc, animated: true)
        print(#function)
    }
    
    @objc func targetLanguageButtonTapped() {
        print(#function)

        let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func changeButtonTapped() {
        
    }
    
    func setUI() {
        sourceLanguageButton.setTitle("한국어", for: .normal)
        targetLanguageButton.setTitle("영어", for: .normal)
        
        sourceTextView.layer.borderColor = UIColor.gray.cgColor
        targetLabel.layer.borderColor = UIColor.gray.cgColor
        
        translateButton.backgroundColor = .systemGreen
        translateButton.setTitleColor(.white, for: .normal)
    }
    
    
    
    /*
     1. 네트워크 통신 단절 상태
     2. API 콜수가 제한을 넘겼을 때
     3. 번역 버튼 클릭 횟수. 텍스트 비교해서 같은 글자라면 똑같은 값 보여주기
     4. 텍스트 비교. 의미없는 통신이있다면 통신하지 않게 만들기
     5. LoadingView
     */

    @objc func translateButtonClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        let headers: HTTPHeaders = [
            //이런 인증키들은 깃헙에 private이더라도 하면 안됨!
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                
                self.targetLabel.text = success.message.result.translatedText

                dump(success)
            case .failure(let failure):
                dump(failure)
            }
        }
        
        
        
    }
    
    
    @IBAction func sourceButtonTapped(_ sender: UIButton) {
        print("dddd")
        
    }
    
    
    
    
}

