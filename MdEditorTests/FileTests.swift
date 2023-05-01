//
//  FileTests.swift
//  MdEditorTests
//
//  Created by Коломенский Александр on 27.04.2023.
//

import XCTest
@testable import MdEditor

final class FileTests: XCTestCase {

	private let fileName = "README.md"
	private let fileSize: UInt64 = 1488

	func test_initDir_name_shouldBeAppName() {

		// arrange
		let sut = makeDirSUT()

		// assert
		XCTAssertEqual(
			sut.name,
			"MdEditor.app",
			"Неверное имя файла, имя должно быть именем Программы MdEditor.app"
		)
	}

	func test_initDir_isDirectory_shouldBeTrue() {

		// arrange
		let sut = makeDirSUT()

		// assert
		XCTAssertTrue(
			sut.isDirectory,
			"Должня быть папка (Bundle.main.bundleURL)"
		)
	}

	func test_initFile_name_shouldBeInfoPlist() {

		// arrange
		let sut = makeFileSUT()

		// assert
		XCTAssertEqual(
			sut.name,
			fileName,
			"Неверное имя файла, имя должно быть \(fileName))"
		)
	}

	func test_initFile_isDirectory_shouldBeFalse() {

		// arrange
		let sut = makeFileSUT()

		// assert
		XCTAssertFalse(
			sut.isDirectory,
			"Должен быть файл"
		)
	}

	func test_initFile_extension_shouldBePlist() {

		// arrange
		let sut = makeFileSUT()

		// assert
		XCTAssertEqual(
			sut.ext,
			"md",
			"Должен быть md"
		)
	}

	func test_initFile_size_shouldBe1488() {

		// arrange
		let sut = makeFileSUT()

		// assert
		XCTAssertEqual(
			sut.size,
			fileSize,
			"Размер файла должен быть \(fileSize)"
		)
	}
}

// MARK: - Private

private extension FileTests {
	private func makeDirSUT() -> File {
		let url = Bundle.main.bundleURL
		return File(url: url)
	}

	private func makeFileSUT() -> File {
		let url = Bundle.main.bundleURL
		return File(url: url.appendingPathComponent(fileName))
	}
}
