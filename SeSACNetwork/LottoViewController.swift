//
//  LottoViewController.swift
//  SeSACNetwork
//
//  Created by cho on 1/16/24.
//

import UIKit

struct Lotto: Codable {
    let drwNo: Int //회차
    let drwNoDate: String //날짜
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}


class LottoViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //completionHandler는 내뱉어주는 것
        manager.callRequest(number: "1102") { value in
            self.dateLabel.text = value
        }
    }
    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        //공백이거나, 문자를 입력한 경우에는 통신이 잘 안될 수 있음!
        manager.callRequest(number: sender.text!) { value in
            self.dateLabel.text = value
        }
    }
    

    

}
