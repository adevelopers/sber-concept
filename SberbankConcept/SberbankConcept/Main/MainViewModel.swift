//
//  MainViewModel.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


enum MainSeectionModel {
    case cards(title: String, [CardItem])
}

enum CollapsableSectionState {
    case opened
    case closed
}

final class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    var collectionCells: BehaviorRelay<[StoryItem]> = .init(value: [])
    var sections: BehaviorRelay<[MainSeectionModel]> = .init(value: [])
    
    var didTapCards: PublishRelay<Void> = .init()
    
    var collapsableSectionState: CollapsableSectionState = .opened
    
    init() {
        didTapCards.subscribe(onNext: {
            switch self.collapsableSectionState {
            case .opened:
                self.collapsableSectionState = .closed
            case .closed:
                self.collapsableSectionState = .opened
            }
        }).disposed(by: disposeBag)
    }
    
    func loadData() {
        sections.accept([
            .cards(title: "Карты", [
                CardItem(type: "Visa", number: "4226 1789 2041 3010", balance: "300 000", applePaySupport:  true),
                CardItem(type: "MasterCard", number: "3340 1789 8917 2289", balance: nil, applePaySupport: false),
                CardItem(type: "Visa", number: "4226 2917 1010 1544", balance: nil,  applePaySupport: false)
            ])
        ])
        
        collectionCells.accept([
            StoryItem(title: "Анализ финансов"),
            StoryItem(title: "Бонусы спасибо"),
            StoryItem(title: "Всего средств")
        ])
    }
}

