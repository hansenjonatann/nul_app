import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/models/tag_model.dart';
import 'package:nul_app/controller/tag_controller.dart';

LocationController _locationC = Get.put(LocationController());

// ignore: must_be_immutable
class UMKMLocationScreen extends StatelessWidget {
  UMKMLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Location',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 20)),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Obx(
                  () => _locationC.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : _locationC.locations.value.isEmpty
                          ? Center(
                              child: Text('No Locations data',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: appRed,
                                      fontSize: 18)))
                          : ListView.builder(
                              itemCount: _locationC.locations.value.length,
                              itemBuilder: (context, index) {
                                final location =
                                    _locationC.locations.value[index];
                                final firstTagName = location.tags != null &&
                                        location.tags!.isNotEmpty
                                    ? location.tags!.first.name
                                    : '-';
                                return Dismissible(
                                  key: Key(location.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    bool? result =
                                        await Get.defaultDialog<bool>(
                                      contentPadding: EdgeInsets.all(8),
                                      title: 'Delete Confirmation',
                                      middleText:
                                          'Are you sure want to delete this location?',
                                      textConfirm: 'Yes',
                                      textCancel: 'Cancel',
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Get.back(result: true);
                                      },
                                      onCancel: () {
                                        Get.back(result: false);
                                      },
                                    );
                                    return result ?? false;
                                  },
                                  onDismissed: (direction) {
                                    // _locationC.locations.remove(location);
                                    Get.snackbar('Deleted',
                                        '${location.name} has been deleted',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white);
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(location.imageUrl ?? ''),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                    title: Text(
                                      '${location.name}',
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Tag: $firstTagName',
                                      style: GoogleFonts.montserrat(),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        Text(
                                          '${location.rating}',
                                          style: GoogleFonts.montserrat(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.bottomSheet(_formCreateLocation());
        },
        child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: appPrimary, borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text('+',
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appWhite)))),
      ),
    );
  }
}

Widget _formCreateLocation() {
  TextEditingController _nameC = new TextEditingController();
  CategoryController _categoryC = Get.put(CategoryController());
  TagController _tagC = Get.put(TagController());
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(color: appWhite),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                  label: 'Name',
                  fieldController: _nameC,
                  hint: 'Your Location Name',
                  hidden: false),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      hint: Text('Select Category',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      items: _categoryC.categories.value
                          .map((item) => DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.name.toString(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: appDarkGrey)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _categoryC.selectedCategory.value = value!;
                      },
                      value: _categoryC.selectedCategory.value),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      hint: Text('Select Tag',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      items: _tagC.tags
                          .map((item) => DropdownMenuItem<Tag>(
                                value: item,
                                child: Text(item.name.toString(),
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        color: appDarkGrey)),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _tagC.selectedTag.value = value!;
                      },
                      value: _tagC.selectedTag.value),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(() => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _locationC.pickFile();
                        },
                        child: Container(
                            width: double.infinity,
                            height: 35,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text('Upload a image',
                                    style: GoogleFonts.montserrat(
                                        color: appWhite, fontSize: 16)))),
                      ),
                      if (_locationC.selectedFile.value != null &&
                          _locationC.selectedFile.value!.bytes != null)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                _locationC.selectedFile.value!.bytes!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                    ],
                  )),
              const SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                  onTap: () {
                    final category = _categoryC.selectedCategory.value;
                    final tag = _tagC.selectedTag.value;

                    if (_nameC.text.isEmpty ||
                        category == null ||
                        tag == null) {
                      Get.snackbar('Warning', 'Please fill all fields',
                          backgroundColor: Colors.orange,
                          colorText: appDarkGrey);
                      return;
                    }

                    _locationC.createLocation(
                      name: _nameC.text,
                      categoryId: category.id ?? 0,
                      tagIds: [tag.id ?? 0],
                    );
                  },
                  child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: appSuccess,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Obx(() => _locationC.isLoading.value == true
                              ? const Text('Saving...')
                              : Text('Save',
                                  style: GoogleFonts.montserrat(
                                    color: appWhite,
                                    fontWeight: FontWeight.bold,
                                  ))))))
            ],
          )),
    ),
  );
}
