import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/controller/umkm/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nul_app/models/category_model.dart';
import 'package:nul_app/models/tag_model.dart';
import 'package:nul_app/controller/tag_controller.dart';
import 'package:file_picker/file_picker.dart';

class UMKMLocationScreen extends StatelessWidget {
  UMKMLocationScreen({super.key});
  UMKMLocationController _locationC = Get.put(UMKMLocationController());
  CategoryController _categoryC = Get.put(CategoryController());
  TagController _tagC = Get.put(TagController());
  TextEditingController _nameC = new TextEditingController();
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
              Obx(() => _locationC.isLoading.value == true
                  ? Center(child: CircularProgressIndicator())
                  : _locationC.locations.value.length < 1
                      ? Center(
                          child: Text('No Locations data',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: appRed,
                                  fontSize: 18)))
                      : const Text('Location List')),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.bottomSheet(Container(
            width: double.infinity,
            decoration: BoxDecoration(color: appWhite),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.all(20),
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
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
                      SizedBox(height: 20),
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded: true,
                              hint: Text('Select Tag',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              items: _tagC.tags.value
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text('Upload a image',
                                            style: GoogleFonts.montserrat(
                                                color: appWhite,
                                                fontSize: 16)))),
                              ),
                              if (_locationC.selectedFile.value != null &&
                                  _locationC.selectedFile.value!.bytes != null)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
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
                                  child: Obx(
                                      () => _locationC.isLoading.value == true
                                          ? Text('Saving...')
                                          : Text('Save',
                                              style: GoogleFonts.montserrat(
                                                color: appWhite,
                                                fontWeight: FontWeight.bold,
                                              ))))))
                    ],
                  )),
            ),
          ));
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
