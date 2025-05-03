import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/addDoctor.dart';
import 'package:grad_project/core/widgets/addguardian.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff2C999B),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                    color: secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Add New Guardian',
                  style: TextStyle(
                    color: primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Close Menu dialog
                  _showAddScreenDialog(context, 'guardian');
                },
              ),
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Add New Doctor',
                  style: TextStyle(
                    color: primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Close Menu dialog
                  _showAddScreenDialog(context, 'doctor');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Utility function to show the Menu dialog
void showMenuDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Menu(),
  );
}

void _showAddScreenDialog(BuildContext context, String type) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            color: const Color(0xff2C999B),
            borderRadius: BorderRadius.circular(35),
          ),
          child: _buildAddScreenContent(type),
        ),
      );
    },
  );
}

Widget _buildAddScreenContent(String type) {
  switch (type) {
    case 'guardian':
      return const AddGuardianScreen();
    case 'doctor':
      return const AddDoctorScreen();
    default:
      return const Center(child: Text('Invalid screen type'));
  }
}