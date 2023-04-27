//
//  IFile.swift
//  MdEditor
//
//  Created by Коломенский Александр on 27.04.2023.
//

import Foundation

/// Протокол описывающий свойства файла.
protocol IFile {

	/// URL файла.
	var url: URL { get }

	/// Является ли файл директорией.
	var isDirectory: Bool { get }

	/// Имя файла.
	var name: String { get }

	/// Расширение файла.
	var ext: String { get }

	/// Размер файла.
	var size: UInt64 { get }

	/// Дата создания файла.
	var creationDate: Date { get }

	/// Дата последнего изменения файла.
	var modificationDate: Date { get }
}
