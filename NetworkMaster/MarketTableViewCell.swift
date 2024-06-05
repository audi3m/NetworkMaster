//
//  MarketTableViewCell.swift
//  NetworkMaster
//
//  Created by J Oh on 6/5/24.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    
    static let id = "MarketTableViewCell"
    
    let nameLabel = UILabel()
    var market: UPbit?
    
    // 재사용 그릇 세팅
    // nib = XIB. 코드로 하면 실행 안됨
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 버튼 동작에 이슈 없음
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
