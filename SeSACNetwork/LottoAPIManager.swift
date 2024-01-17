//
//  LottoAPIManager.swift
//  SeSACNetwork
//
//  Created by cho on 1/16/24.
//

import UIKit
import Alamofire

struct LottoAPIManager {
    
    func callRequest(number: String, completionHandler: @escaping (String) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        //내부에서 url로 다 변경을 해주고 있음. 그래서 string만 전달을 해줘도 됨, 요렇게 엔터쳐도 됨!
        //문자열로 주는 것을 Decoding해서 구조체 형식으로 바꿀께!
        //Lotto 구조체에다 응답한 것 받을게!
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                print(success)
                
                //클로저 때문에 발생. self를 붙여줘야함
                //self.dateLabel.text = success.drwNoDate
                //completionHandler는 내뱉어주는 것
                completionHandler(success.drwNoDate)
                
            case .failure(let failure):
                print("통신 오류 발생")
            }
        }
    }
    
}
