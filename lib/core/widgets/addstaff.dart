import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/services/AddStaff_service.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({Key? key}) : super(key: key);

  @override
  _AddStaffScreenState createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ssnController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final AddNurseService _nurseService = AddNurseService(); // Initialize service

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _ssnController.dispose();
    _roleController.dispose();
    _wardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2C999B),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff2C999B),
                borderRadius: BorderRadius.circular(53),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add New Staff',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SSN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _ssnController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Role',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _roleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ward',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _wardController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          String name = _nameController.text.trim();
                          String ssn = _ssnController.text.trim();
                          String role = _roleController.text.trim();
                          String ward = _wardController.text.trim();
                          const String token = "YOUR_AUTH_TOKEN_HERE"; // Replace with actual token if needed
                          if (name.isEmpty || ssn.length < 13 || role.isEmpty || ward.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                _animationController.forward(from: 0);
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ScaleTransition(
                                        scale: _scaleAnimation,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Failed',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        name.isEmpty
                                            ? 'Please enter a name'
                                            : ssn.length < 13
                                            ? 'SSN must be at least 13 digits'
                                            : role.isEmpty
                                            ? 'Please enter a role'
                                            : 'Please enter a ward',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xff2C999B),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text(
                                          'Retry',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            try {
                              await _nurseService.addNurse(
                                name: name,
                                ssn: ssn,
                                role: role,
                                ward: ward,
                                token: token,
                              );
                              showDialog(
                                context: context,
                                builder: (context) {
                                  _animationController.forward(from: 0);
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Color(0xFF2C999B),
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Success',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'You have successfully added new\nStaff',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context); // Close AddStaffScreen
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xff2C999B),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text(
                                            'Done',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  _animationController.forward(from: 0);
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ScaleTransition(
                                          scale: _scaleAnimation,
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          'Failed',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          e.toString().replaceFirst('Exception: ', ''),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xff2C999B),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text(
                                            'Retry',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Add Staff',
                          style: TextStyle(
                            color: Color(0xff2C999B),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}