import 'package:flutter/material.dart';
import 'package:foodinvoiceapp/generate_bill.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const activeColor = Colors.green;
  String? selectedCategory;
  File? logoImage;
  String selectedCountryCode = "+91"; // default to India

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickLogo() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => logoImage = File(pickedFile.path));
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const pagePadding = EdgeInsets.all(16.0);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context,'/second');
            },
          ),
          title: const Text(
            "Business Details",
            style: TextStyle(
              fontFamily: 's1',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: pagePadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabeledDropdown(
                  labelText: "Business Category",
                  isRequired: true,
                  value: selectedCategory,
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
                if (selectedCategory == 'Food')
                  LabeledTextField(
                    labelText: "FSSAI Number",
                    isRequired: true,
                    hintText: "Enter FSSAI Number",
                  ),
                LabeledTextField(
                  labelText: "Business Type",
                  isRequired: true,
                  hintText: "Enter Business Type",
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Phone Number", true),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedCountryCode,
                                items: const [
                                  DropdownMenuItem(
                                      value: "+91", child: Text("+91")),
                                  DropdownMenuItem(
                                      value: "+1", child: Text("+1")),
                                  DropdownMenuItem(
                                      value: "+44", child: Text("+44")),
                                ],
                                onChanged: (val) {
                                  setState(() {
                                    selectedCountryCode = val!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              cursorColor: activeColor,
                              decoration: InputDecoration(
                                hintText: "Enter Phone Number",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 14),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: activeColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                LabeledTextField(
                  labelText: "Business Address",
                  isRequired: true,
                  hintText: "Enter Business Address",
                ),
                LabeledTextField(
                  labelText: "GSTIN Number",
                  isRequired: true,
                  hintText: "Enter GSTIN Number",
                ),
                // Phone number row with country code

                // Business logo
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Business Logo", true),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickLogo,
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey[100],
                          ),
                          child: logoImage == null
                              ? const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 32,
                              color: Colors.grey,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              logoImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool required) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 's1',
            color: Colors.black87,
          ),
        ),
        if (required)
          const Text(
            " *",
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}

/* -------------------------
   LabeledTextField
   ------------------------- */
class LabeledTextField extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const LabeledTextField({
    super.key,
    required this.labelText,
    this.isRequired = false,
    required this.hintText,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Colors.green;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 's1',
                  color: Colors.black87,
                ),
              ),
              if (isRequired)
                const Text(
                  " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: activeColor,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: activeColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------
   LabeledDropdown
   ------------------------- */
class LabeledDropdown extends StatelessWidget {
  final String labelText;
  final bool isRequired;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const LabeledDropdown({
    super.key,
    required this.labelText,
    this.isRequired = false,
    this.value,
    this.onChanged,
  });

  static const activeColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 's1',
                  color: Colors.black87,
                ),
              ),
              if (isRequired)
                const Text(
                  " *",
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () async {
              final selected = await _showCategorySelector(context,
                  current: value);
              if (selected != null && onChanged != null) onChanged!(selected);
            },
            child: Container(
              height: 48,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                value ?? "Select",
                style: TextStyle(
                  fontFamily: 's1',
                  fontSize: 15,
                  color:
                  value == null ? Colors.black.withOpacity(0.4) : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showCategorySelector(BuildContext context,
      {String? current}) {
    final categories = [
      'Retail',
      'Wholesale',
      'Online',
      'Service',
      'Food',
      'Manufacturing',
      'Healthcare',
      'Education',
      'Finance',
      'Logistics',
      'Real Estate',
      'Entertainment',
      'Technology',
      'Hospitality',
      'Agriculture',
      'Automotive',
      'Consulting',
      'Construction',
      'Media',
    ];

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Select Business Category",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 's1',
                ),
              ),
            ),
            const Divider(height: 1),
            ...categories.map((category) {
              final isSelected = category == current;
              return InkWell(
                onTap: () => Navigator.pop(context, category),
                child: Container(
                  color: isSelected
                      ? Colors.green.withOpacity(0.3)
                      : Colors.transparent,
                  padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontFamily: 's1',
                      fontSize: 14,
                      color: isSelected ? Colors.green : Colors.black,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
