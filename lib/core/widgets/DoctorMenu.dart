import 'package:flutter/material.dart';
import 'package:grad_project/core/constants/colours/colours.dart';
import 'package:grad_project/core/widgets/addDoctor.dart';
import 'package:grad_project/core/widgets/addguardian.dart';
import 'package:grad_project/core/widgets/addpatient.dart';
import 'package:grad_project/core/widgets/addreport.dart';

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
                Container(
                  child:  Text(
                    'Menu',
                    style: TextStyle(
                      color: secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
              title:  Container(
                decoration: BoxDecoration(color:secondary,borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Add New Patient',
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
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPatientScreen(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Container(
                decoration: BoxDecoration(color:secondary,borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Add New report',
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
                  Navigator.pop(context); // Close dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddReport(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showMenuDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Menu(),
  );
}