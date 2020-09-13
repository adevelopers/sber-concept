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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        cardIcon
            .add(to: self)
            .top(to: \.topAnchor, constant: 8)
            .left(to: \.leftAnchor, constant: 16)
            .width(32)
            .height(32)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
