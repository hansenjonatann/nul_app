import 'package:flutter/material.dart';
import 'package:nul_app/constants/color.dart';

class UMKMLocationScreen extends StatelessWidget {
  const UMKMLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            const SizedBox(
              height: 10.0,
            ),
            Table(
              border: TableBorder.all(color: appWhite.withValues(alpha: 0.3)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: appPrimary),
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('#'),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Name'),
                      ),
                    ),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
