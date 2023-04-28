//
//  MdFileManagerTests.swift
//  MdEditorTests
//
//  Created by Коломенский Александр on 27.04.2023.
//

import XCTest
@testable import MdEditor

// swiftlint:disable force_unwrapping
final class MdFileManagerTests: XCTestCase {

	private let testDirUrl = Bundle.main.resourceURL!
		.appendingPathComponent(Const.Paths.forTestsReadOnly)
	private let tempDirName = "TempDir"
	private let tempFileName = "TempFile.md"
	private let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

	private let dirDocs = File(
		url: Bundle.main.resourceURL!
			.appendingPathComponent(Const.Paths.forTestsReadOnly)
			.appendingPathComponent("Docs")
	)
	private let fileMdEditor = File(
		url: Bundle.main.resourceURL!
			.appendingPathComponent(Const.Paths.forTestsReadOnly)
			.appendingPathComponent("MdEditor.md")
	)
	private let fileTodoList = File(
		url: Bundle.main.resourceURL!
			.appendingPathComponent(Const.Paths.forTestsReadOnly)
			.appendingPathComponent("TodoList.md")
	)

	func test_contentsOfDirectory_shouldBe1Dir2File() {

		// arrange
		let sut = makeSUT()

		// act
		let contentsOfExamples = sut.contentsOfDirectory(at: testDirUrl)

		// assert
		XCTAssertEqual(
			contentsOfExamples.count,
			3,
			"Неверное количество элементов, должно быть 3"
		)

		XCTAssertTrue(
			contentsOfExamples.contains(dirDocs),
			"список должен содержать dirDocs"
		)

		XCTAssertTrue(
			contentsOfExamples.contains(fileMdEditor),
			"список должен содержать fileMdEditor"
		)

		XCTAssertTrue(
			contentsOfExamples.contains(fileTodoList),
			"список должен содержать fileTodoList"
		)
	}

	func test_contentsOfFile_shouldContainMdEditorText() {

		// arrange
		let sut = makeSUT()

		// act
		let contentsOfFile = sut.contentsOf(file: fileMdEditor)

		// assert
		XCTAssertTrue(
			contentsOfFile.contains("MdEditor"),
			"Файл \(fileMdEditor) должен содержать строку \"MdEditor\""
		)
	}

	func test_createFolder_shouldBeSuccess() throws {

		// arrange
		let sut = makeSUT()

		// act
		try sut.createFolder(at: documentsUrl, withName: tempDirName)
		let list = sut.contentsOfDirectory(at: documentsUrl)
		let dirTemp = File(
			url: documentsUrl
				.appendingPathComponent(tempDirName)
		)

		// assert
		XCTAssertTrue(
			list.contains(dirTemp),
			"Список должен содержать \(tempDirName)"
		)
	}

	func test_createNewFile_shouldBeSuccess() throws {

		// arrange
		let sut = makeSUT()

		// act
		try sut.createNewFile(at: documentsUrl, fileName: tempFileName)
		let list = sut.contentsOfDirectory(at: documentsUrl)
		let tempFile = File(
			url: documentsUrl
				.appendingPathComponent(tempFileName)
		)

		// assert
		XCTAssertTrue(
			list.contains(tempFile),
			"Список должен содержать \(tempFileName)"
		)
	}

	override func tearDown() {
		do {
			let fileURLs = try FileManager.default.contentsOfDirectory(
				at: documentsUrl,
				includingPropertiesForKeys: nil,
				options: .skipsHiddenFiles
			)
			for fileURL in fileURLs where fileURL.relativePath.contains(tempDirName) {
				try FileManager.default.removeItem(at: fileURL)
			}
			for fileURL in fileURLs where fileURL.relativePath.contains(tempFileName) {
				try FileManager.default.removeItem(at: fileURL)
			}
		} catch {
			// print(error)
		}
		super.tearDown()
	}
}

// MARK: - Private

private extension MdFileManagerTests {
	private func makeSUT() -> MDFileManager {
		return MDFileManager()
	}
}
