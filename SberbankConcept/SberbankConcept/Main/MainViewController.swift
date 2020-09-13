//
//  ViewController.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints


class MainViewController: UIViewController {

    private lazy var backView: GradientView = {
        let view = GradientView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var panelView: PanelView = {
        let panelView = PanelView()
        return panelView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backView
            .add(to: view)
            .top(to: \.topAnchor)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .bottom(to: \.bottomAnchor)
        
        panelView
            .add(to: view)
            .top(to: \.centerYAnchor, constant: -32)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .height(UIScreen.main.bounds.height)
            
//            .height(constantTo: UIScreen.main.bound.height)
//            .bottom(to: \.bottomAnchor)
            
    }


}

