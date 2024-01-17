//
//  BookViewController.swift
//  SeSACNetwork
//
//  Created by cho on 1/17/24.
//

import UIKit
import Alamofire
import Kingfisher

struct Book: Codable {
    let documents: [Document]
    let meta: Meta
}

struct Document: Codable {
    let authors: [String]
    let contents: String
   // let datetime, isbn: String
    let price: Int
//    let publisher: String
//    let salePrice: Int
//    let status: String
    let thumbnail: String
    let title: String
//    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, price //datetime, isbn, publisher
        //case salePrice = "sale_price"
        case thumbnail, title //status, url
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

class BookViewController: UIViewController {

    @IBOutlet var bookCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var bookList: [Document] = [] {
        didSet {
            bookCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
        
        setCollectionViewLayout()


    }
    
    func setCollectionViewLayout() {
        let xib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(xib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 16
        let cellWidth = UIScreen.main.bounds.width - spacing * 3
        let cellHeight = UIScreen.main.bounds.height - spacing * 4
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 4)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .vertical
        
        bookCollectionView.collectionViewLayout = layout
    }
    
    func callRequest(text: String) {
        
        //만약 한글검색이 안된다면 인코딩처리
        //let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10"
        
        let headers: HTTPHeaders = [
            //이런 인증키들은 깃헙에 private이더라도 하면 안됨!
            "Authorization": APIKey.kakaoAPIKey
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let success):
                print(success.documents)
                print(success.documents.count)
                
                self.bookList = success.documents
                
            case .failure(let failure):
                print(failure, "통신오류")
            }
        }
    }


}

extension BookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest(text: searchBar.text!)
    }
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        let url = URL(string: bookList[indexPath.item].thumbnail)
        cell.bookAuthorsLabel.text = bookList[indexPath.item].authors[0] 
        cell.bookContentsLabel.text = bookList[indexPath.item].contents
        cell.bookTitleLabel.text = bookList[indexPath.item].title
        cell.thumbnailView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
