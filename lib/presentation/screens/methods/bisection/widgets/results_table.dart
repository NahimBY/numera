import 'package:flutter/material.dart';
import 'package:numera/config/theme/app_theme.dart';
import '../bisection_logic.dart';

class ResultsTable extends StatelessWidget {
  final List<BisectionIteration> iterations;

  const ResultsTable({super.key, required this.iterations});

  @override
  Widget build(BuildContext context) {
    if (iterations.isEmpty) return const SizedBox();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.primary.withOpacity(0.1),
        ),
        dataRowMaxHeight: double.infinity,
        headingTextStyle: AppFonts.headline8.copyWith(color: AppColors.primaryDark),
        dataTextStyle: AppFonts.bodyText2,
        columns: const [
          DataColumn(label: Text('Iter')),
          DataColumn(label: Text('a')),
          DataColumn(label: Text('b')),
          DataColumn(label: Text('xr')),
          DataColumn(label: Text('f(xr)')),
          DataColumn(label: Text('Error Rel.')),
        ],
        rows: iterations.map((it) {
          return DataRow(
            cells: [
              DataCell(Text(it.iteration.toString())),
              DataCell(Text(it.a.toStringAsFixed(6))),
              DataCell(Text(it.b.toStringAsFixed(6))),
              DataCell(Text(it.xr.toStringAsFixed(6))),
              DataCell(Text(it.fxr.toStringAsFixed(6))),
              DataCell(Text(
                it.iteration == 1 
                  ? '---' 
                  : '${(it.error * 100).toStringAsFixed(4)}%',
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
}
