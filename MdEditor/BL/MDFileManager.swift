//
//  MDFileManager.swift
//  MdEditor
//
//  Created by Коломенский Александр on 27.04.2023.
//

import Foundation

final class MDFileManager: IFileManager {

	private let fileManager = FileManager.default
	private let fileEncoding = String.Encoding.utf8

	/// Возвращает список всего содержимого URL.
	/// - Parameter url: путь
	/// - Returns: массив файлов содержащихся по пути URL
	func contentsOfDirectory(at url: URL) -> [IFile] {
		var fileList = [IFile]()

		guard let items = try? fileManager.contentsOfDirectory(atPath: url.relativePath) else {
			return fileList
		}

		items.forEach { item in
			if let itemFullUrl = URL(string: "\(url.relativePath)/\(item)") {
				fileList.append(File(url: itemFullUrl))
			}
		}
		return fileList
	}

	/// Создание нового файла по пути URL.
	/// - Parameters:
	///   - url: путь
	///   - fileName: имя нового файла
	///   - ext: расширение файла
	func createNewFile(at url: URL, fileName: String, ext: String) throws {
		var urlWithFileName = url
		urlWithFileName.appendPathComponent("\(fileName).\(ext)")
		try "".write(to: urlWithFileName, atomically: true, encoding: fileEncoding)
	}

	/// Открыть и получить содержимое файла
	/// - Parameter file: IFile
	/// - Returns: содержимое файла Data
	func contentsOf(file: IFile) -> String {
		if let text = try? String(contentsOfFile: file.url.relativePath, encoding: fileEncoding) {
			return text
		} else {
			return ""
		}
	}

	/// Запись данных в файл
	/// - Parameters:
	///   - file: IFile
	///   - data: данные для записи
	func write(file: IFile, data: String) throws {
		try data.write(to: file.url, atomically: true, encoding: fileEncoding)
	}

	/// Создать новый каталог
	/// - Parameters:
	///   - url: путь где будет создан новый каталог
	///   - name: имя каталога
	func createFolder(at url: URL, withName name: String) throws {
		try fileManager.createDirectory(at: url, withIntermediateDirectories: false)
	}
}
