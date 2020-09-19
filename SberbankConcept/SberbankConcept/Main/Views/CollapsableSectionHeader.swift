//
//  CollapsableSectionHeader.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 19.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit


final class CollapsableSectionHeaderView: UIControl {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let view = UIImageView(image: UIImage(imageLiteralResourceName: "arrow-down"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel
            .add(to: self)
            .left(to: \.leftAnchor, constant: 16)
            .centerY(to: \.centerYAnchor)
        
        arrowIcon
            .add(to: self)
            .left(to: \.rightAnchor, of: titleLabel, relation: .equal, constant: 8, priority: .defaultHigh)
            .centerY(to: \.centerYAnchor)
    }
    
}

