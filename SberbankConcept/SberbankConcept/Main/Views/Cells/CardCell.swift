//
//  CardCell.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints


final class CardCell: UITableViewCell, Reusable {
    
    private lazy var cardIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "cardIcon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var applePayView: UIImageView = {
        let view = UIImageView(image: UIImage(imageLiteralResourceName: "ApplePay"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var cardTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(named: "mainGrey")
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "mainGreen")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        cardIcon
            .add(to: self)
            .top(to: \.topAnchor, constant: 8)
            .left(to: \.leftAnchor, constant: 16)
            .width(32)
            .height(32)
        
        cardTypeLabel
            .add(to: self)
            .top(to: \.topAnchor, constant: 8)
            .left(to: \.rightAnchor, of: cardIcon, relation: .equal, constant: 16, priority: .defaultHigh)
            .right(to: \.rightAnchor, constant: 16)
        
        numberLabel
            .add(to: self)
            .top(to: \.bottomAnchor, of: cardTypeLabel, relation: .equal, constant: 4, priority: .defaultHigh)
            .left(to: \.rightAnchor, of: cardIcon, relation: .equal, constant: 16, priority: .defaultHigh)
            .right(to: \.rightAnchor, constant: 16)
        
        balanceLabel
            .add(to: self)
            .right(to: \.rightAnchor, constant: 16)
            .height(32)
        
        applePayView
            .add(to: self)
            .top(to: \.bottomAnchor, of: cardIcon, relation: .equal, constant: 4, priority: .defaultHigh)
            .left(to: \.leftAnchor, constant: 16)
            .width(41)
            .height(27)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ model: CardItem) {
        cardTypeLabel.text = model.type
        numberLabel.text = model.number
        if let balance = model.balance {
            balanceLabel.text = "\(balance) ₽"
        }
        
        applePayView.isHidden = !model.applePaySupport
    }
    
}
