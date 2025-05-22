import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nul_app/constants/color.dart';
import 'package:nul_app/constants/url.dart';
import 'package:nul_app/controller/auth/auth_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final authC = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final dobC = TextEditingController();
  final countryC = TextEditingController();
  final gender = RxnString();

  @override
  Widget build(BuildContext context) {
    final user = authC.userProfile.value;

    nameC.text = user.name.toString();
    emailC.text = user.email.toString();
    phoneC.text = user.phone.toString();
    dobC.text = user.dob.toString();
    countryC.text = user.country.toString();
    gender.value = user.gender;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: GoogleFonts.montserrat()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Obx(() {
                final image = authC.selectedFile.value;
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        authC.pickFile();
                      },
                      child: user.pictureUrl != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  '${API_DEV_URL}api${user.pictureUrl}'))
                          : CircleAvatar(
                              radius: 50, child: const Icon(Icons.add_a_photo)),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              const SizedBox(
                height: 12.0,
              ),
              _buildInput("Name", nameC),
              const SizedBox(height: 12),
              _buildInput("Email", emailC, readOnly: true),
              const SizedBox(height: 12),
              Obx(() => _buildGenderDropdown(gender)),
              const SizedBox(height: 12),
              _buildInput("Phone", phoneC, keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _selectDate(context, dobC),
                child: AbsorbPointer(child: _buildInput("Date of Birth", dobC)),
              ),
              const SizedBox(height: 12),
              _buildInput("Country", countryC),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: appPrimary),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authC.updateProfile(
                      name: nameC.text,
                      email: emailC.text,
                      phone: phoneC.text,
                      dob: dobC.text,
                      country: countryC.text,
                      gender: gender.value.toString(),
                    );
                  }
                },
                child: const Text("Save Changes",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller,
      {bool readOnly = false,
      TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildGenderDropdown(RxnString selectedGender) {
    return DropdownButtonFormField<String>(
      value: selectedGender.value,
      decoration: const InputDecoration(
        labelText: "Gender",
        border: OutlineInputBorder(),
      ),
      items: ['Male', 'Female', 'Other'].map((gender) {
        return DropdownMenuItem(value: gender, child: Text(gender));
      }).toList(),
      onChanged: (value) => selectedGender.value = value,
      validator: (value) =>
          value == null || value.isEmpty ? 'Select gender' : null,
    );
  }

  void _selectDate(
      BuildContext context, TextEditingController dobController) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(dobController.text) ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = picked.toIso8601String().split('T')[0];
    }
  }
}
