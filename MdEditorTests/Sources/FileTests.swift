//
//  FileTests.swift
//  MdEditorTests
//
//  Created by Коломенский Александр on 27.04.2023.
//

import XCTest
@testable import MdEditor

final class FileTests: XCTestCase {

	private let fileNameReadmeMd = "README.md"
	private let fileNameInfoPlist = "Info.plist"
	private let fileSize: UInt64 = 1408

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

	func test_file_name_shouldBeInfoPlist() {

		// arrange
		let sut = makeFileSUT(fileName: fileNameInfoPlist)

		// assert
		XCTAssertEqual(
			sut.name,
			fileNameInfoPlist,
			"Неверное имя файла, имя должно быть \(fileNameInfoPlist))"
		)
	}

	func test_file_isDirectory_shouldBeFalse() {

		// arrange
		let sut = makeFileSUT(fileName: fileNameInfoPlist)

		// assert
		XCTAssertFalse(
			sut.isDirectory,
			"Должен быть файл"
		)
	}

	func test_file_extension_shouldBePlist() {

		// arrange
		let sut = makeFileSUT(fileName: fileNameInfoPlist)

		// assert
		XCTAssertEqual(
			sut.ext,
			"plist",
			"Расширение файла должно быть plist"
		)
	}

	func test_file_size_shouldBe1408() {

		// arrange
		let sut = makeFileSUT(fileName: fileNameInfoPlist)

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

	private func makeFileSUT(fileName: String) -> File {
		let url = Bundle.main.bundleURL
		return File(url: url.appendingPathComponent(fileName))
	}
}
