import 'package:flutter/material.dart';
import 'package:numera/config/theme/app_theme.dart';

import '../false_position_logic.dart';

class FalsePositionResultsTable extends StatelessWidget {
  final List<FalsePositionIteration> iterations;

  const FalsePositionResultsTable({super.key, required this.iterations});

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
          DataColumn(label: Text('Iter')),
          DataColumn(label: Text('a')),
          DataColumn(label: Text('b')),
          DataColumn(label: Text('c')),
          DataColumn(label: Text('f(a)')),
          DataColumn(label: Text('f(b)')),
          DataColumn(label: Text('f(c)')),
          DataColumn(label: Text('Error')),
        ],
        rows: iterations
            .map(
              (it) => DataRow(
                cells: [
                  DataCell(Text(it.iteration.toString())),
                  DataCell(Text(it.a.toStringAsFixed(6))),
                  DataCell(Text(it.b.toStringAsFixed(6))),
                  DataCell(Text(it.c.toStringAsFixed(6))),
                  DataCell(Text(it.fa.toStringAsFixed(6))),
                  DataCell(Text(it.fb.toStringAsFixed(6))),
                  DataCell(Text(it.fc.toStringAsFixed(6))),
                  DataCell(Text(it.error.isInfinite
                      ? '—'
                      : it.error.toStringAsFixed(6))),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

