import 'package:flutter/material.dart';
import 'package:grad_project/core/widgets/staffcard.dart';

import 'addstaff.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _isExpanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> staffMembers = [];
    return Scaffold(
      backgroundColor: const Color(0xff2C999B),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuart,
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_isExpanded ? 16 : 0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    endIndent: 8,
                  ),
                ),
                const Text(
                  'My Staff',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  child: Divider(color: Colors.white, thickness: 2, indent: 8),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,  
                  crossAxisSpacing: 5,  
                  mainAxisSpacing: 5,  
                  childAspectRatio: 149 / 47, 
                ),
                itemCount: staffMembers.length, 
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,  
                    child: StaffCardWidget(),    
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddStaffScreen();   
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: const Color(0xFF52B696A),
        ),
      ),
    );
  }
}
