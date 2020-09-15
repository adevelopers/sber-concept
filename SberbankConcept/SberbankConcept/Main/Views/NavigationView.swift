//
//  NavigationView.swift
//  SberbankConcept
//
//  Created by Kirill Khudiakov on 15.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints
import RxSwift



final class NavigationView: UIView {
    
    private lazy var avatarView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "avatar")
        return view
    }()
    
    private lazy var textField: TextField = {
        let field = TextField()
        field.layer.cornerRadius = 16
        field.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        field.attributedPlaceholder = NSAttributedString(string: "Поиск по приложению", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        field.rightViewMode = .always
        let searchButton = UIButton()
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        searchButton.setImage(UIImage(imageLiteralResourceName: "search"), for: .normal)
        field.rightView = searchButton
        return field
    }()
    
    private lazy var notifyView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(imageLiteralResourceName: "bellIcon")
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI() {
        avatarView
            .add(to: self)
            .left(to: \.leftAnchor, constant: 16)
            .centerY(to: \.centerYAnchor)
            .width(30)
            .height(30)
        
        notifyView
            .add(to: self)
        
        textField
            .add(to: self)
            .left(to: \.rightAnchor, of: avatarView, relation: .equal, constant: 16, priority: .defaultHigh)
            .centerY(to: \.centerYAnchor)
            .height(30)
            .right(to: \.leftAnchor, of: notifyView, relation: .equal, constant: 16, priority: .defaultHigh)
        
        notifyView
            .right(to: \.rightAnchor, constant: 16)
            .centerY(to: \.centerYAnchor)
            .width(22)
            .height(24)
    }
    
}
