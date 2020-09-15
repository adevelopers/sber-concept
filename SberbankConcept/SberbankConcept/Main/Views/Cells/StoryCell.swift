//
//  StoryCell.swift
//  SberbankConcept
//
//  Created by Kirill Khudiakov on 15.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints


final class StoryCell: UICollectionViewCell, Reusable {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "diamond")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(named: "mainGrey")
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16
        backgroundColor = .white
        imageView
            .add(to: self)
            .top(to: \.topAnchor, constant: 16)
            .left(to: \.leftAnchor, constant: 8)
            .width(32)
            .height(32)
        
        titleLabel
            .add(to: self)
            .top(to: \.bottomAnchor, of: imageView, constant: 8)
            .left(to: \.leftAnchor, constant: 8)
            .right(to: \.rightAnchor)
        
        subtitleLabel
            .add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 4)
            .left(to: \.leftAnchor, constant: 8)
            .right(to: \.rightAnchor)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(model: StoryItem) {
        titleLabel.text = model.title
        subtitleLabel.text = "Показать"
    }
}
