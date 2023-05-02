//
//  OrderedMDFileManager.swift
//  MdEditor
//
//  Created by Коломенский Александр on 02.05.2023.
//

import Foundation

final class OrderedMDFileManager: IFileManager {
	private let fileManager: IFileManager

	init(fileManager: IFileManager) {
		self.fileManager = fileManager
	}

	func contentsOfDirectory(at url: URL) -> [File] {
		sorted(files: fileManager.contentsOfDirectory(at: url))
	}

	func createNewFile(at url: URL, fileName: String) throws {
		try fileManager.createNewFile(at: url, fileName: fileName)
	}

	func contentsOf(file: File) -> String {
		fileManager.contentsOf(file: file)
	}

	func write(file: File, data: String) throws {
		try fileManager.write(file: file, data: data)
	}

	func createFolder(at url: URL, withName name: String) throws {
		try fileManager.createFolder(at: url, withName: name)
	}

	func getRecentFilesUrls() -> [URL] {
		fileManager.getRecentFilesUrls()
	}

	func addToRecentFilesUrl(url: URL) {
		fileManager.addToRecentFilesUrl(url: url)
	}

	func getDocumentsUrl() -> URL {
		fileManager.getDocumentsUrl()
	}

	func getExamplesUrl() -> URL {
		fileManager.getExamplesUrl()
	}

	private func sorted(files: [File]) -> [File] {
		var sortedFiles = files
			.filter { !$0.isDirectory }
			.sorted { $0.name > $1.name }
		var sortedDirectories = files
			.filter { $0.isDirectory }
			.sorted { $0.name > $1.name }

		sortedDirectories.append(contentsOf: sortedFiles)

		return sortedDirectories
	}
}
