//
//  TableViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

final class GenericTableViewController<T, Cell: CellIdentifiable & NibLoadable>: UITableViewController {
    // MARK: - Model
    private var items: [T]
    private let configureCellAction: (Cell, T) -> Void
    private let didSelectItemAction: (T) -> Void
    
    // MARK: - Initialization
    init(
        items: [T],
        configureCellAction: @escaping (Cell, T) -> Void,
        didSelectItemAction: @escaping (T) -> Void
    ) {
        self.items = items
        self.configureCellAction = configureCellAction
        self.didSelectItemAction = didSelectItemAction
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    // MARK: - Register Cells
    private func registerCells() {
        if Cell.isNibLoadable {
            let nib = UINib(nibName: "\(Cell.self)", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: Cell.identifier)
            return
        }
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
    
    // MARK: - Methods
    func setItems(_ items: [T]) {
        self.items = items
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        configureCellAction(cell, item)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        didSelectItemAction(item)
    }
}
