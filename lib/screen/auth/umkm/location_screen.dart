import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UMKMLocationScreen extends StatelessWidget {
  const UMKMLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              _buildTable(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTable() {
  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('#'),
      ),
      const DataColumn(
        label: Text('Name'),
      ),
      const DataColumn(
        label: Text('Image'),
      ),
      const DataColumn(
        label: Text('Tags'),
      ),
      const DataColumn(
        label: Text('Rating'),
      ),
      const DataColumn(
        label: Text('Actions'),
      ),
    ];
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: _createColumns(),
      rows: [],
    ),
  );
}
