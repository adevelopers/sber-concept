//
//  ViewController.swift
//  SberbankConcept
//
//  Created by Кирилл Худяков on 13.09.2020.
//  Copyright © 2020 Худяков Кирилл. All rights reserved.
//

import UIKit
import VanillaConstraints
import RxSwift



class MainViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private lazy var backView: GradientView = {
        let view = GradientView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var panelView: PanelView = {
        let panelView = PanelView(contentView: cardsTableView)
        return panelView
    }()
    
    private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        viewModel.loadData()
        
        viewModel.cells
            .subscribe(onNext: { _ in
                self.cardsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }


}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.cells.value[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier) {
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}
