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
  final bool shrinkWrap;
  final BoxConstraints? size; // required if shrink wrap is false

  StaggeredGrid({
    required this.nOfColumns,
    required this.itemBuilder,
    required this.itemCount,
    this.physics,
    this.shrinkWrap = false,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: physics ??
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: RowBuilder(
          itemCount: nOfColumns,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          itemBuilder: (context, indexOfColumn) {
            return Expanded(
              child: (shrinkWrap == true)
                  ? ListView(
                      shrinkWrap: shrinkWrap,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: List.generate(
                              lengthOfColumnList(
                                  itemCount, nOfColumns, indexOfColumn),
                              (columnIndex) => this.itemBuilder(
                                  context,
                                  trueIndex(
                                      indexOfColumn, columnIndex, nOfColumns)))
                          .toList(),
                    )
                  : Container(
                      height: size!.maxHeight,
                      width: size!.maxWidth,
                      child: ListView(
                        shrinkWrap: shrinkWrap,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List.generate(
                            lengthOfColumnList(
                                itemCount, nOfColumns, indexOfColumn),
                            (columnIndex) => this.itemBuilder(
                                context,
                                trueIndex(indexOfColumn, columnIndex,
                                    nOfColumns))).toList(),
                      ),
                    ),
            );
          },
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
