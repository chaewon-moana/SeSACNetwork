//
//  MarketViewController.swift
//  SeSACNetwork
//
//  Created by cho on 1/16/24.
//

import UIKit
import Alamofire

struct Market: Codable {
    let market: String
    let korean_name: String
    let english_name: String
}

class MarketViewController: UIViewController {
    
    @IBOutlet var marketView: UITableView!
    
    var marketList: [Market] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        configureTableView()
    }
    
    func configureTableView() {
        marketView.delegate = self
        marketView.dataSource = self
    }
    
    func callRequest() {
        //데이터가 어떤 형태로 오는지 확인을 해야함! -> 배열의 형태로 있으니 잘 확인!
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get).validate(statusCode: 200..<501).responseDecodable(of: [Market].self) { response in
            switch response.result {
            //상태코드를 기준으로 성공으로 넘어감 -> 근데 200~299가 성공이 아닐 수도 있음! 그걸 바꾸는 게 validate..alamofire에선 200~299를 성공코드로 봄
            case .success(let success):
                //print(success)
                //dump(success) //몇개의 elements가 있는지, 잘 보이는 형태로 콘솔에 출력할 수 있음
                
                
                if response.response?.statusCode == 200 { //직접 status code로 바꿀 수 있음
                    self.marketList = success
                    self.marketView.reloadData()
                } else if response.response?.statusCode == 500 {
                    print("오류가 발생했어요. 잠시 후 다시 시도해주세요")
                }
                
                
                print(success[0].korean_name)
                print(success[1].korean_name)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell")!
        
        let data = marketList[indexPath.row]
        cell.textLabel?.text = data.korean_name
        cell.detailTextLabel?.text = data.english_name
        
        return cell
    }

}
