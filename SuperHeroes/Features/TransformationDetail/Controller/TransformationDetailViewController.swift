//
//  TransformationDetailViewController.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 01-10-23.
//

import UIKit

final class TransformationDetailViewController: UIViewController {
    // MARK: - Subviews
    private lazy var innerView = TransformationDetailView(transformation: transformation)

    // MARK: - Model
    private let transformation: Transformation
    
    // MARK: - Initialization
    init(transformation: Transformation) {
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = transformation.name
    }
}
