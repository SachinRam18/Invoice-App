import 'package:flutter/material.dart';

class Bill extends StatefulWidget {
  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  String selectedTab = "Add Item"; // For toggle
  String selectedSquare = ""; // For drafts/kitchen active state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Color(0xFF000000),
            size: 30,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        title: Text(
          "Business Details",
          style: TextStyle(
            fontFamily: 's1',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
            decoration: TextDecoration.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_box,
              color: Color(0xFF000000),
              size: 30,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              // Draft & Kitchen Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSquareButton(Icons.drafts_sharp, "DRAFTS"),
                  _buildSquareButton(Icons.soup_kitchen, "KITCHEN"),
                ],
              ),
              const SizedBox(height: 30),

              // Toggle Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton("Add Item"),
                  const SizedBox(width: 12),
                  _buildToggleButton("Items"),
                ],
              ),
              const SizedBox(height: 30),

              // Content for selected toggle
              if (selectedTab == "Items")
                Text(
                  "Items will appear here",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )
              else
                Text(
                  "Add item form here",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Add order logic here
          },
          child: Text(
            "ADD ORDER",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 's1',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label) {
    bool isSelected = selectedTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = label;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 's1',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSquareButton(IconData icon, String label) {
    bool isSelected = selectedSquare == label;
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 3,
        ),
        onPressed: () {
          setState(() {
            selectedSquare = label;
          });
          print("$label button pressed");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 's1',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
