import 'package:flutter/material.dart';
import 'package:numera/config/theme/app_theme.dart';

import '../trapeze_logic.dart';

class TrapezeResultsTable extends StatelessWidget {
  final List<TrapezeIteration> iterations;

  const TrapezeResultsTable({super.key, required this.iterations});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.primaryDark.withOpacity(0.1),
        ),
        dataRowMaxHeight: double.infinity,
        headingTextStyle:
            AppFonts.headline8.copyWith(color: AppColors.primaryDark),
        dataTextStyle: AppFonts.bodyText2,
        columns: const [
          DataColumn(label: Text('i')),
          DataColumn(label: Text('xᵢ')),
          DataColumn(label: Text('f(xᵢ)')),
        ],
        rows: iterations
            .map(
              (it) => DataRow(
                cells: [
                  DataCell(Text(it.index.toString())),
                  DataCell(Text(it.x.toStringAsFixed(6))),
                  DataCell(Text(it.fx.toStringAsFixed(6))),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

