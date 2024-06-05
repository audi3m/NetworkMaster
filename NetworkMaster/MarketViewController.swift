//
//  MarketViewController.swift
//  NetworkMaster
//
//  Created by J Oh on 6/5/24.
//

import UIKit
import Alamofire
import SnapKit



class MarketViewController: UIViewController {
    
    var list: [UPbit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        print(#function, "111111111")
        callRequest()
        print(#function, "222222222")
        
    }
    
    func configureTableView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        // 바로 사용
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
        
        tableView.backgroundColor = .cyan
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func callRequest() {
        print(#function, "33333333")
        
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url).responseDecodable(of: [UPbit].self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.list = value
            case .failure(let error):
                print(error)
            }
        }
        
        print(#function, "44444444")
    }
    
    
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let market = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.id, for: indexPath) as! MarketTableViewCell
        cell.nameLabel.text = market.korean_name
        return cell
        
    }
    
}

struct UPbit: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
}
