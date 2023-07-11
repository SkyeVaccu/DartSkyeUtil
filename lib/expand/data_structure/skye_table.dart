///it's the two-dimensional table to operate data
class SkyeTable<Q, P, Y> {
  // the store true object
  final Map<Q, Map<P, Y>> _table = {};

  SkyeTable();

  /// put the value into the table
  /// @param row : target row
  /// @param column : target column
  /// @param value : target value
  void put(Q row, P column, Y value) {
    _table[row] ??= {}..[column] = value;
  }

  /// get the value
  /// @param row : target row
  /// @param column : target column
  /// @return : target value
  Y? get(Q row, P column) {
    return _table[row]?[column];
  }

  /// remove the value
  /// @param row : target row
  /// @param column : target column
  void remove(Q row, P column) {
    _table[row]?.remove(column);
  }

  /// whether the row is exist
  /// @param row : target row
  /// @return : if it's exist
  bool rowIsExist(Q row) {
    return _table.containsKey(row);
  }

  /// whether the column is exist
  /// @param column : target column
  /// @return : if it's exist
  bool columnIsExist(P column) {
    for (Q key in _table.keys) {
      if (_table[key]?[column] != null) {
        return true;
      }
    }
    return false;
  }

  /// get all data in the row
  /// @param row : target row
  /// @return : all data
  Map<P, Y>? getRow(Q row) {
    return _table[row];
  }

  /// get all data in the column
  /// @param column : target column
  /// @return : all data
  Map<Q, Y>? getColumn(P column) {
    Map<Q, Y> map = {};
    for (Q key in _table.keys) {
      if (_table[key]?[column] != null) {
        map[key] = _table[key]![column] as Y;
      }
    }
    return map.isEmpty ? null : map;
  }
}
