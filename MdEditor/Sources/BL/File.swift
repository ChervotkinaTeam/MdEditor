//
//  File.swift
//  MdEditor
//
//  Created by Коломенский Александр on 25.04.2023.
//

import Foundation

/// Class Файл.
final class File {

	private let fileManager = FileManager.default

	/// URL файла.
	private (set) var url: URL

	/// Является ли файл директорией.
	var isDirectory: Bool { isDir() }

	/// Имя файла.
	var name: String { url.lastPathComponent }

	/// Расширение файла.
	var ext: String { url.pathExtension }

	/// Размер файла.
	var size: UInt64 { getFileSize() }

	/// Дата создания файла.
	var creationDate: Date { getCreationDate() }

	/// Дата последнего изменения файла.
	var modificationDate: Date { getModificationDate() }

	private let attributes: [FileAttributeKey: Any]?

	init(url: URL) {
		self.url = url
		attributes = try? fileManager.attributesOfItem(atPath: url.relativePath)
	}

	private func getFileSize() -> UInt64 {
		return attributes?[FileAttributeKey.size] as? UInt64 ?? 0
	}

	private func getCreationDate() -> Date {
		return attributes?[FileAttributeKey.creationDate] as? Date ?? Date(timeIntervalSince1970: .zero)
	}

	private func getModificationDate() -> Date {
		return attributes?[FileAttributeKey.modificationDate] as? Date ?? Date(timeIntervalSince1970: .zero)
	}

	private func isDir() -> Bool {
		var isDir: ObjCBool = false
		fileManager.fileExists(atPath: url.relativePath, isDirectory: &isDir)
		return isDir.boolValue
	}
}

extension File: Equatable {
	public static func == (lhs: File, rhs: File) -> Bool {
		lhs.url.relativePath == rhs.url.relativePath
	}
}
