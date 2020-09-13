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
    var cells: BehaviorRelay<[String]> = .init(value: [])
    
    func loadData() {
        cells.accept(["a","b","c"])
    }
}

