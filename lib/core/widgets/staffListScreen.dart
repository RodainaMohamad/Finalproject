import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/GetNurseNodel.dart';
import 'package:grad_project/API_integration/services/GetNurse_service.dart';
import 'package:grad_project/core/widgets/addstaff.dart';
import 'package:grad_project/core/widgets/staffcard.dart';

class NurseListScreen extends StatefulWidget {
  const NurseListScreen({Key? key}) : super(key: key);

  @override
  State<NurseListScreen> createState() => _NurseListScreenState();
}

class _NurseListScreenState extends State<NurseListScreen> {
  bool _isExpanded = false;
  Future<List<Nurse>>? _futureNurses;

  @override
  void initState() {
    super.initState();
    _loadNurses();
    Future.delayed(Duration.zero, () {
      setState(() {
        _isExpanded = true;
      });
    });
  }

  void _loadNurses() {
    setState(() {
      _futureNurses = NurseService().fetchNurses();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const Row(
              children: [
                Expanded(
                    child: Divider(color: Colors.white, thickness: 2, endIndent: 8)),
                Text(
                  'My Staff',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Expanded(
                    child: Divider(color: Colors.white, thickness: 2, indent: 8)),
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
              child: FutureBuilder<List<Nurse>>(
                future: _futureNurses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.white));
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No staff found',
                            style: TextStyle(color: Colors.white)));
                  }

                  final staffList = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 149 / 47,
                    ),
                    itemCount: staffList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: StaffCardWidget(
                          nurse: staffList[index],
                          onNurseDeleted: _loadNurses,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddStaffScreen(),
          );
          if (result == true) {
            _loadNurses();
          }
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF52B696A)),
      ),
    );
  }
}