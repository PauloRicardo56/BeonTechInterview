//
//  CatListTableViewCell.swift
//  BeonTechInterview
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/09/23.
//

import UIKit

final class CatListTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setupView() {
        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
