import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF1FCFF),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ✅ Top Row: Title + Leave Button
              Row(

                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF240075)),
                    onPressed: () {
                      Navigator.pop(context); // Go back
                    },
                  ),
                  const Text(
                    "Business Details",
                    style: TextStyle(
                      fontFamily: 'LibreCaslonText',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF240075),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ✅ Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      BusinessCategoryDropdown(),
                      LabeledTextField(
                        labelText: "GSTIN Number",
                        hintText: "Enter GSTIN Number",
                      ),
                      LabeledTextField(
                        labelText: "Business Address",
                        hintText: "Enter Business Address",
                      ),
                      LabeledTextField(
                        labelText: "Business Type",
                        hintText: "Enter Business Type",
                      ),
                      LabeledTextField(
                        labelText: "What is your business category",
                        hintText: "Select",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class LabeledTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;

  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // spacing between fields
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // align to left
        children: [
          Text(
            labelText,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'LibreCaslonText',
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF2F7FF),
              hint: Text("$hintText",style: TextStyle(fontFamily: 'LibreCaslonText',color: Color(0xFF737373))),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF240075)),
                borderRadius: BorderRadius.circular(10), // rounded corners
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF7D4BEC)), // 👈 when focused
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessCategoryDropdown extends StatefulWidget {
  const BusinessCategoryDropdown({super.key});

  @override
  State<BusinessCategoryDropdown> createState() => _BusinessCategoryDropdownState();
}

class _BusinessCategoryDropdownState extends State<BusinessCategoryDropdown> {
  final List<String> categories = [
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
  String? selectedCategory; // Selected value

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What is your business category",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'LibreCaslonText',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F7FF),
            border: Border.all(color: const Color(0xFF7D4BEC)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              hint: const Text("Select",style: TextStyle(fontFamily: 'LibreCaslonText',)),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (selectedCategory == 'Food')
          const LabeledTextField(
            labelText: "FSSAI Number",
            hintText: "Enter FSSAI Number",
          ),
      ],
    );
  }
}
