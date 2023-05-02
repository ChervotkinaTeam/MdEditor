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
	func contentsOfDirectory(at url: URL) -> [File] {
		var fileList = [File]()

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
	func createNewFile(at url: URL, fileName: String) throws {
		var urlWithFileName = url
		urlWithFileName.appendPathComponent("\(fileName)")
		try "".write(to: urlWithFileName, atomically: true, encoding: fileEncoding)
	}

	/// Открыть и получить содержимое файла
	/// - Parameter file: File
	/// - Returns: содержимое файла Data
	func contentsOf(file: File) -> String {
		if let text = try? String(contentsOfFile: file.url.relativePath, encoding: fileEncoding) {
			return text
		} else {
			return ""
		}
	}

	/// Запись данных в файл
	/// - Parameters:
	///   - file: File
	///   - data: данные для записи
	func write(file: File, data: String) throws {
		try data.write(to: file.url, atomically: true, encoding: fileEncoding)
	}

	/// Создать новый каталог
	/// - Parameters:
	///   - url: путь где будет создан новый каталог
	///   - name: имя каталога
	func createFolder(at url: URL, withName name: String) throws {
		try fileManager.createDirectory(at: url.appendingPathComponent(name), withIntermediateDirectories: false)
	}

	/// Функция возвращает список URL недавно открытых файлов
	func getRecentFilesUrls() -> [URL] {
		let defaults = UserDefaults.standard
		var recentFilesUrl = [URL]()
		let recentFilesStringUrl = defaults.stringArray(forKey: Const.FileManager.RecentFilesUrlKey) ?? [String]()
		recentFilesStringUrl.forEach { stringUrl in
			if let url = URL(string: stringUrl) {
				recentFilesUrl.append(url)
			}
		}
		return recentFilesUrl
	}

	/// Функция добавляет URL в список URL недавно открытых файлов
	func addToRecentFilesUrl(url: URL) {
		let defaults = UserDefaults.standard
		var recentFilesUrl = defaults.stringArray(forKey: Const.FileManager.RecentFilesUrlKey) ?? [String]()
		if recentFilesUrl.count >= Const.FileManager.maxCountRecentFiles {
			recentFilesUrl.removeLast()
		}
		recentFilesUrl.insert(url.relativePath, at: 0)
		defaults.set(recentFilesUrl, forKey: Const.FileManager.RecentFilesUrlKey)
	}

	/// URL  к папке Documents
	func getDocumentsUrl() -> URL {
		FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[.zero]
	}

	/// URL  к папке Examples
	func getExamplesUrl() -> URL {
		guard let resourceUrl = Bundle.main.resourceURL else { return getDocumentsUrl() }
		return resourceUrl.appendingPathComponent(Const.Paths.examples)
	}
}
