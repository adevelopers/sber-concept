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
    
    private lazy var sectionHeaderView: CollapsableSectionHeaderView = {
        CollapsableSectionHeaderView()
    }()
    
    private lazy var backView: GradientView = {
        let view = GradientView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var navigationView: NavigationView = {
        let view = NavigationView()
        return view
    }()
    
    
    // CollectionView
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var cardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        backView
            .add(to: view)
            .top(to: \.topAnchor)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .bottom(to: \.bottomAnchor)
        
        navigationView
            .add(to: view)
            .top(to: \.topAnchor, constant: 98)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
        
        collectionView
            .add(to: view)
            .top(to: \.bottomAnchor, of: navigationView, relation: .equal, constant: 48)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .height(130)
        
        panelView
            .add(to: view)
            .top(to: \.centerYAnchor, constant: -32)
            .left(to: \.leftAnchor)
            .right(to: \.rightAnchor)
            .height(UIScreen.main.bounds.height)
        
        setupSubscriptions()
        
        viewModel.loadData()
    }
    
    private func setupSubscriptions() {
        
        viewModel.sections
            .subscribe(onNext: { _ in
                self.cardsTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.collectionCells
            .subscribe(onNext: { _ in
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        sectionHeaderView.rx.controlEvent(.touchDown)
            .bind(to: viewModel.didTapCards)
            .disposed(by: disposeBag)
            
        viewModel.didTapCards.subscribe(onNext: { _ in
                self.cardsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = viewModel.sections.value[section]
        switch sectionModel {
        case let .cards(_, cells):
            return viewModel.collapsableSectionState == .opened ? cells.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.sections.value[indexPath.section]
        switch sectionModel {
        case let .cards(_, cells):
            if let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier) as? CardCell {
                let model = cells[indexPath.row]
                cell.set(model)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionModel = viewModel.sections.value[section]
        switch sectionModel {
        case let .cards(title, _):
            return title
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = viewModel.sections.value[section]
        switch sectionModel {
        case let .cards(title, _):
            (sectionHeaderView.subviews[0] as? UILabel)?.text = title
            return sectionHeaderView
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return viewModel.collapsableSectionState == .opened ? 30 : 0
//    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionCells.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell {
            cell.set(model: viewModel.collectionCells.value[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
