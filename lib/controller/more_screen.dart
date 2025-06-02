import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nul_app/controller/category_controller.dart';
import 'package:get/get.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});

  final CategoryController _categoryC = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kategori")),
      body: SafeArea(
        child: Obx(() {
          if (_categoryC.categories.value.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _categoryC.categories.value.length,
            itemBuilder: (context, index) {
              final category = _categoryC.categories.value[index];
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      isThreeLine: false,
                      leading: Image.network(
                        category.icon.toString(),
                        width: 30,
                      ),
                      title: Text(category.name.toString()),
                      onTap: () => Get.toNamed('/category-detail',
                          arguments: {'categoryId': category.id ?? 0}),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
