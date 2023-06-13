//
//  OpenDocumentTableViewCell.swift
//  MdEditor
//
//  Created by Коломенский Александр on 05.05.2023.
//

import UIKit

class OpenDocumentTableViewCell: UITableViewCell {
	static let reuseIdentifier = String(describing: OpenDocumentTableViewCell.self)
	static let cellHeight: CGFloat = 80.0

	lazy var labelFileName: UILabel = makeLabelFileName()
	lazy var labelFileInfo: UILabel = makeLabelFileInfo()
	lazy var imageFileType: UIImageView = makeImageFileType()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	func configure(file: OpenDocumentModels.ViewModel.File) {
		labelFileName.text = file.name
		labelFileInfo.text = file.fileInfo
		imageFileType.image = file.image
	}
}

// MARK: - Private extensions
private extension OpenDocumentTableViewCell {
	func setupUI() {
		[
			labelFileName,
			labelFileInfo,
			imageFileType
		].forEach { contentView.addSubview($0) }
	}

	func layout() {
		let textLabelHeight: CGFloat = 20.0
		let imageFileTypeWidth: CGFloat = 50.0

		imageFileType.pin
			.left(Sizes.Padding.normal)
			.vCenter()
			.width(imageFileTypeWidth)
			.aspectRatio()

		labelFileName.pin
			.after(of: imageFileType, aligned: .top)
			.marginStart(Sizes.Padding.half)
			.end(Sizes.Padding.half)
			.height(textLabelHeight)

		labelFileInfo.pin
			.after(of: imageFileType)
			.below(of: labelFileName)
			.marginTop(Sizes.Padding.half)
			.marginStart(Sizes.Padding.half)
			.end(Sizes.Padding.half)
			.height(textLabelHeight)
	}

	func makeImageFileType() -> UIImageView {
		let imageView = UIImageView()

		return imageView
	}

	func makeLabelFileName() -> UILabel {
		let label = UILabel()

		label.numberOfLines = 0
		label.textColor = Theme.black
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.adjustsFontForContentSizeCategory = true

		return label
	}

	func makeLabelFileInfo() -> UILabel {
		let label = UILabel()

		label.numberOfLines = 0
		label.textColor = Theme.black
		label.font = UIFont.preferredFont(forTextStyle: .caption1)
		label.adjustsFontForContentSizeCategory = true

		return label
	}
}
