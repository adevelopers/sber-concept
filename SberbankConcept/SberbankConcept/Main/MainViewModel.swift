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


final class MainViewModel {
    var collectionCells: BehaviorRelay<[StoryItem]> = .init(value: [])
    var cells: BehaviorRelay<[CardItem]> = .init(value: [])
    
    func loadData() {
        cells.accept([CardItem(type: "Visa", number: "4226 1789 2041 3010", balance: "300 000", applePaySupport:  true),
                      CardItem(type: "MasterCard", number: "3340 1789 8917 2289", balance: nil, applePaySupport: false),
                      CardItem(type: "Visa", number: "4226 2917 1010 1544", balance: nil,  applePaySupport: false)
        ])
        
        collectionCells.accept([
            StoryItem(title: "Анализ финансов"),
            StoryItem(title: "Бонусы спасибо"),
            StoryItem(title: "Всего средств")
        ])
    }
}

