import 'package:flutter_test/flutter_test.dart';

import 'package:staggeredgrid/staggeredgrid.dart';

// test for staggered grid
void main() {
  // test for list length
  test(
      'Given list length, number of columns and column index, return correct length of column at index',
      () async {
    // ARRANGE
    int listLength1 = 5;
    int nOfC1 = 3;
    int cIndex1 = 2;

    int listLength2 = 32;
    int nOfC2 = 5;
    int cIndex2 = 3;

    int listLength3 = 47;
    int nOfC3 = 4;
    int cIndex3 = 3;

    int l1, l2, l3;
    // ACT
    l1 = lengthOfColumnList(listLength1, nOfC1, cIndex1);
    l2 = lengthOfColumnList(listLength2, nOfC2, cIndex2);
    l3 = lengthOfColumnList(listLength3, nOfC3, cIndex3);

    // ASSERT
    expect(l1, 1);
    expect(l2, 6);
    expect(l3, 11);
  });

  test(
      'Given columnIndex, index of column and number of columns, return the true index of the element',
      () async {
    // ARRANGE
    int columnIndex1 = 3;
    int indexOfColumn1 = 4;
    int nOfC1 = 5;

    int columnIndex2 = 5;
    int indexOfColumn2 = 2;
    int nOfC2 = 4;

    int columnIndex3 = 2;
    int indexOfColumn3 = 1;
    int nOfC3 = 2;

    int i1, i2, i3;
    // ACT
    i1 = trueIndex(indexOfColumn1, columnIndex1, nOfC1);
    i2 = trueIndex(indexOfColumn2, columnIndex2, nOfC2);
    i3 = trueIndex(indexOfColumn3, columnIndex3, nOfC3);

    // ASSERT
    expect(i1, 20);
    expect(i2, 23);
    expect(i3, 6);
  });
}
