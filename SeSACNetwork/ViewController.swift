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

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
        
        
    }

    @objc func translateButtonClicked() {
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        var parameters: Parameters = [
            "text": sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        var headers: HTTPHeaders = [
            //이런 인증키들은 깃헙에 private이더라도 하면 안됨!
            "X-Naver-Client-Id": "i2Hzl2heWTWFSHH7Jq75",
            "X-Naver-Client-Secret": "7cExugCtVX"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
        
        
        
    }
    
}

