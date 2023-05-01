//
//  IFileManager.swift
//  MdEditor
//
//  Created by Коломенский Александр on 27.04.2023.
//

import Foundation

/// Протокол для FileManager
protocol IFileManager {

	/// Возвращает список всего содержимого URL.
	/// - Parameter url: путь
	/// - Returns: массив файлов содержащихся по пути URL
	func contentsOfDirectory(at url: URL) -> [File]

	/// Создание нового файла по пути URL.
	/// - Parameters:
	///   - url: путь
	///   - fileName: имя нового файла
	func createNewFile(at url: URL, fileName: String) throws

	/// Открыть и получить содержимое файла
	/// - Parameter file: IFile
	/// - Returns: содержимое файла Data
	func contentsOf(file: File) -> String

	/// Запись данных в файл
	/// - Parameters:
	///   - file: IFile
	///   - data: данные для записи 
	func write(file: File, data: String) throws

	/// Создать новый каталог
	/// - Parameters:
	///   - url: путь где будет создан новый каталог
	///   - name: имя каталога
	func createFolder(at url: URL, withName name: String) throws
}
