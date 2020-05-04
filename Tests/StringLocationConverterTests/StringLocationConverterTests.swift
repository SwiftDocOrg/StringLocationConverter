import XCTest
@testable import StringLocationConverter

final class StringLocationConverterTests: XCTestCase {
    let string = """
    # [Universal Declaration of Human Rights][udhr]

    ## Article 1.

    All human beings are born free and equal in dignity and rights.
    They are endowed with reason and conscience
    and should act towards one another in a spirit of brotherhood.

    [udhr]: https://www.un.org/en/universal-declaration-human-rights/ "View full version"
    """

    func testLocationForRange() throws {
        let range = try XCTUnwrap(string.range(of: "reason"))
        XCTAssertEqual(range.lowerBound.utf16Offset(in: string), 150)
        XCTAssertEqual(range.upperBound.utf16Offset(in: string), 156)

        let converter = StringLocationConverter(for: string)

        let position = converter.location(for: range.lowerBound, in: string)
        XCTAssertNotNil(position)
        XCTAssertEqual(position?.line, 6)
        XCTAssertEqual(position?.column, 23)
    }

    func testLocationForIndices() throws {
        let converter = StringLocationConverter(for: string)

        var line = 1, column = 1
        for index in string.indices {
            let message = "\(index.utf16Offset(in: string)) (\(string[index]))"
            let position = try XCTUnwrap(converter.location(for: index, in: string), message)
            XCTAssertEqual(position.line, line, message)
            XCTAssertEqual(position.column, column, message)

            if string[index].isNewline {
                line += 1
                column = 1
            } else {
                column += 1
            }
        }
    }
}
