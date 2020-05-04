/// A location within a string when displayed with newlines.
public struct Location: Hashable {
    /**
     The line number.

     Line numbers are **one-based**,
     meaning that the first line is numbered as `1`.
     */
    public let line: Int

    /**
     The column number.

     Column numbers are **one-based**,
     meaning that the first column on a line is numbered as `1`.
     */
    public let column: Int
}

// MARK: - Comparable

extension Location: Comparable {
    public static func < (lhs: Location, rhs: Location) -> Bool {
        return (lhs.line, lhs.column) < (rhs.line, rhs.column)
    }
}
