//
//  StartCollectionViewCell.swift
//  MdEditor
//
//  Created by Коломенский Александр on 24.04.2023.
//

import UIKit

class StartCollectionViewCell: UICollectionViewCell {
	static let reuseIdentifier = String(describing: StartCollectionViewCell.self)

	override init(frame: CGRect) {
		super .init(frame: frame)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		backgroundColor = .blue
	}
}
