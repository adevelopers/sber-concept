//
//  PanelView.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints

enum PanelViewState {
    case opened
    case closed
}

enum VerticalDirection {
    case none
    case up
    case down
}

final class PanelView: UIView {
    
    private let animationDuration: TimeInterval = 0.5
    
    private var state: PanelViewState = .closed
    
    private var contentView: UIView
    
    private lazy var shieldik: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainGrey")
        view.layer.cornerRadius = 2
        return view
    }()
    
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(frame: .zero)
        setupUI()
        setupPan()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        contentView
            .add(to: self)
            .top(to: \.topAnchor, constant: 48)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .bottom(to: \.bottomAnchor)
        
        
        shieldik
            .add(to: self)
            .centerX(to: \.centerXAnchor)
            .top(to: \.topAnchor, constant: 8)
            .width(100)
            .height(4)
        
        
    }
    
    
    private func setupPan() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(pan)
    }
    
    private var direction: VerticalDirection = .none
    private var startPoint: CGPoint = .zero
    private var endPoint: CGPoint = .zero
    
    @objc
    private func handlePan(_ pan: UIPanGestureRecognizer) {
        let translation = pan.translation(in: self)
        
        switch pan.state {
        case .began:
            startPoint = pan.location(in: self.superview)
        case .changed:
            frame.origin.y = frame.origin.y + translation.y
        case .ended:
            endPoint = pan.location(in: self.superview)
            let delta = startPoint.y - endPoint.y
            direction = delta > 0 ? VerticalDirection.up : VerticalDirection.down
            
            switch (direction, state) {
            case (.up, .closed):
                self.animatedOpen()
            case (.down, .opened):
                self.animatedClose()
            case (_, .closed):
                animatedToNormal()
            default:
                ()
            }
        default:
            ()
        }
        
        pan.setTranslation(.zero, in: self)
    }
    
    private func animatedOpen() {
        guard state == .closed else { return }
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame.origin.y = 16
        }, completion: { _ in
            self.state = .opened
        })
    }
    
    private func animatedClose() {
        guard state == .opened else { return }
        UIView.animate(withDuration: animationDuration, animations: toNormal, completion: { _ in
            self.state = .closed
        })
    }
    
    private func animatedToNormal() {
        guard state == .closed else { return }
        
        UIView.animate(withDuration: animationDuration, animations: toNormal)
    }
    
    private func toNormal() {
        frame.origin.y = (UIScreen.main.bounds.height / 2)
    }
}
