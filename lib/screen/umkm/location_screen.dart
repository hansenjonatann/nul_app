import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nul_app/controller/location_controller.dart';
import 'package:nul_app/core.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:nul_app/controller/tag_controller.dart';
import 'package:text_area/text_area.dart';

LocationController _locationC = Get.put(LocationController());

class UMKMLocationScreen extends StatelessWidget {
  const UMKMLocationScreen({super.key});

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
              const SizedBox(height: 10.0),
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
                                    ? location.tags!.first.slug
                                    : '-';
                                return Dismissible(
                                  key: Key(location.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    bool? result =
                                        await Get.defaultDialog<bool>(
                                      contentPadding: const EdgeInsets.all(8),
                                      title: 'Delete Confirmation',
                                      middleText:
                                          'Are you sure want to delete this location?',
                                      textConfirm: 'Yes',
                                      textCancel: 'Cancel',
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        _locationC.deleteLocation(
                                            id: location.id ?? 0);
                                      },
                                      onCancel: () {
                                        Get.back(result: false);
                                      },
                                    );
                                    return result ?? false;
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
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
                                    subtitle: Text('# $firstTagName'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 20),
                                        Text('${location.rating}'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(_formCreateLocation());
        },
        backgroundColor: appPrimary,
        child: const Icon(Icons.add, color: appWhite),
      ),
    );
  }
}

Widget _formCreateLocation() {
  final TextEditingController _nameC = TextEditingController();
  final TextEditingController _descC = TextEditingController();
  CategoryController _categoryC = Get.put(CategoryController());
  TagController _tagC = Get.put(TagController());

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(color: appWhite),
    child: SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
              hidden: false,
              label: 'Name',
              fieldController: _nameC,
              hint: 'Your Location Name'),
          const SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description',
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 4.0,
              ),
              TextArea(
                borderRadius: 10,
                borderColor: Colors.black,
                textEditingController: _descC,
                suffixIcon: Icons.attach_file_rounded,
                onSuffixIconPressed: () => {},
                validation: false,
                errorText: 'Please type a reason!',
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              _locationC.pickFile();
            },
            child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text('Upload an image'))),
          ),
          const SizedBox(
            height: 10.0,
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
          const SizedBox(
            height: 10.0,
          ),
          Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: const Text('Select Category'),
                  items: _categoryC.categories.value
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _categoryC.selectedCategory.value = value;
                  },
                  value: _categoryC.selectedCategory.value,
                ),
              )),
          const SizedBox(height: 20),
          Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: const Text('Select Tag'),
                  items: _tagC.tags
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item.name.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    _tagC.selectedTag.value = value;
                  },
                  value: _tagC.selectedTag.value,
                ),
              )),
          const SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              _locationC.createLocation(
                  name: _nameC.text,
                  categoryId: _categoryC.selectedCategory.value?.id ?? 0,
                  tagIds: [_tagC.selectedTag.value?.id ?? 0],
                  desc: _descC.text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}
