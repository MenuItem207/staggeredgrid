library staggeredgrid;

import 'package:flutter/material.dart';
import 'package:staggeredgrid/rowBuilder.dart';

// widget for staggeredGrid
// must be placed within a widget with size just like a list
class StaggeredGrid extends StatelessWidget {
  final int nOfColumns;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ScrollPhysics? physics;
  final BoxConstraints minSize; // size of grid
  StaggeredGrid({
    required this.nOfColumns,
    required this.itemBuilder,
    required this.itemCount,
    this.physics,
    required this.minSize,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        physics: physics ??
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          constraints: BoxConstraints(
              minHeight: minSize.maxHeight, minWidth: minSize.maxWidth),
          child: RowBuilder(
            itemCount: nOfColumns,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            itemBuilder: (context, indexOfColumn) {
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                      lengthOfColumnList(itemCount, nOfColumns, indexOfColumn),
                      (columnIndex) => this.itemBuilder(
                          context,
                          trueIndex(indexOfColumn, columnIndex,
                              nOfColumns))).toList(),
                ),
              );
            },
          ),
        ));
  }
}

// length of column list
int lengthOfColumnList(int listLength, int nOfColumns, int columnIndex) {
  int r = listLength % nOfColumns; // remainder
  int baseLength = ((listLength - r) / nOfColumns).round();
  return baseLength + ((columnIndex + 1 <= r) ? 1 : 0);
}

// convert index of column and columnIndex to true index
int trueIndex(indexOfColumn, columnIndex, nOfCOlumns) =>
    (indexOfColumn + 1) + nOfCOlumns * columnIndex - 1;
