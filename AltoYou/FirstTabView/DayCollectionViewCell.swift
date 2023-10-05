//
//  DayCollectionViewCell.swift
//  AltoYou
//
//  Created by 정의찬 on 10/6/23.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    ///MARK: - 출석체크 요일 버튼
    private lazy var dayBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = btn.layer.frame.size.height / 2 + 1
        btn.backgroundColor = UIColor.gray // 연한 블루 색상 필요
        return btn
    }()
    
    //MARK: -init
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    //MARK: - function
    func configuration(_ model: DayModel){
        if model.isCheck == true {
            dayBtn.backgroundColor = UIColor.blue // 조금 더 진한 블루 색 필요
            dayBtn.setBackgroundImage(UIImage(systemName: "check.png"), for: .normal)
            dayBtn.layer.borderColor = UIColor.systemPink // 연한 블루 색 필요
            dayBtn.layer.borderWidth = 3
        } else {
            dayBtn.setTitle(model.day, for: .normal)
            dayBtn.titleLabel?.font = UIFont(name: "Katuri", size: 10)
            dayBtn.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    
    
}
