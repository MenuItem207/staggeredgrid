library staggeredgrid;

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

part 'row_builder.dart';

// widget for staggeredGrid
class StaggeredGrid extends StatefulWidget {
  final int nOfColumns;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  StaggeredGrid({
    required this.nOfColumns,
    required this.itemBuilder,
    required this.itemCount,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  State<StaggeredGrid> createState() => _StaggeredGridState();
}

class _StaggeredGridState extends State<StaggeredGrid> {
  List<ScrollController> controllers = [];
  late LinkedScrollControllerGroup linkedController;

  @override
  void initState() {
    super.initState();
    linkedController = LinkedScrollControllerGroup();
    for (int i = 0; i < widget.nOfColumns; i++) {
      controllers.add((linkedController.addAndGet()));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((controller) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return RowBuilder(
      mainAxisSize: MainAxisSize.max,
      itemCount: widget.nOfColumns,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      itemBuilder: (context, indexOfColumn) {
        return Expanded(
          child: ListView(
            controller: controllers[indexOfColumn],
            shrinkWrap: widget.shrinkWrap,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: widget.physics,
            children: List.generate(
                    lengthOfColumnList(
                        widget.itemCount, widget.nOfColumns, indexOfColumn),
                    (columnIndex) => this.widget.itemBuilder(
                        context,
                        trueIndex(
                            indexOfColumn, columnIndex, widget.nOfColumns)))
                .toList(),
          ),
        );
      },
    );
  }
}

/// length of column list
int lengthOfColumnList(int listLength, int nOfColumns, int columnIndex) {
  int r = listLength % nOfColumns; // remainder
  int baseLength = ((listLength - r) / nOfColumns).round();
  return baseLength + ((columnIndex + 1 <= r) ? 1 : 0);
}

/// convert index of column and columnIndex to true index
int trueIndex(indexOfColumn, columnIndex, nOfCOlumns) =>
    (indexOfColumn + 1) + nOfCOlumns * columnIndex - 1;
