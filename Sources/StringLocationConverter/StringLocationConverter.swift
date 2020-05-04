/// Converts string indices to line and column locations.
public struct StringLocationConverter: Hashable {
    let lineIndices: [String.Index]

    /**
     Creates a location converter for a string.

     - Parameters:
        - string: The string whose contents are used to calculate locations.
     */
    public init(for string: String) {
        self.lineIndices = [string.startIndex] +
                            string.indices.filter { string[$0].isNewline } +
                            [string.endIndex]
    }

    /**
     Returns the location corresponding to an index within a string.

     - Parameters
        - index: A string index.
        - string: A string whose indices are used to calculate the location.
     - Returns: The corresponding location,
                or `nil` if `index` has no corresponding position in `string`.
     */
    public func location(for index: String.Index, in string: String) -> Location? {
        guard let index = index.samePosition(in: string) else { return nil }
        let line = lineIndices.lastIndex(where: { index > $0 }) ?? 0
        let column = string.distance(from: lineIndices[line], to: index)
        return Location(line: line + 1, column: column + (line == 0 ? 1 : 0))
    }
}

