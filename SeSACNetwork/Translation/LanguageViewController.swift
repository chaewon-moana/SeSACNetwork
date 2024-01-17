//
//  LanguageViewController.swift
//  SeSACNetwork
//
//  Created by cho on 1/17/24.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let codeList = ["ko","en","ja","zh-CN","zh-TW","vi","id","th","de","ru","es", "it", "fr"]
    
    let languageCode = [
        "ko": "한국어",
        "en": "영어",
        "ja": "일본어",
        "zh-CN": "중국어 간체",
        "zh-TW": "중국어 번체",
        "vi": "베트남어",
        "id": "인도네시아어",
        "th": "태국어",
        "de": "독일어",
        "ru": "러시아어",
        "es": "스페인어",
        "it": "이탈리아어",
        "fr": "프랑스어"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        let xib = UINib(nibName: "LanguageTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "LanguageTableViewCell")
        
    }
    
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
        
        cell.languageLabel.text = languageCode[codeList[indexPath.row]]
        
        return cell
    }
}
