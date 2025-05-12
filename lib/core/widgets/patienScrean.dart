import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/patientmodel.dart';
import 'package:grad_project/API_integration/services/AddPatient_service.dart';
import 'package:grad_project/core/widgets/patiencard.dart';
import 'addpatient.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  bool _isExpanded = false;
  final AddPatientService _patientService = AddPatientService();
  List<Patient> _allPatients = []; // Store ALL patients
  List<Patient> _displayedPatients = []; // Patients to display
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllPatients(); // Load all patients initially
    Future.delayed(Duration.zero, () {
      setState(() => _isExpanded = true);
    });

    // Listen to search input changes
    _searchController.addListener(() {
      _handleSearch(_searchController.text);
    });
  }

  Future<void> _loadAllPatients() async {
    setState(() => _isLoading = true);
    try {
      // Fetch all patients (assuming an endpoint exists or using empty name)
      final response = await _patientService.getPatientsByName('');
      _allPatients = response
          .asMap()
          .entries
          .map((entry) => Patient.fromAddPatientModel(entry.value, entry.key))
          .toList();
      _displayedPatients = List.from(_allPatients); // Show all by default
    } catch (e) {
      print('Error loading all patients: $e');
      _allPatients = [];
      _displayedPatients = [];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleSearch(String query) async {
    if (query.isEmpty) {
      // Show all patients when search is empty
      setState(() => _displayedPatients = List.from(_allPatients));
    } else {
      // Fetch patients by name from API
      setState(() => _isLoading = true);
      try {
        final response = await _patientService.getPatientsByName(query);
        setState(() {
          _displayedPatients = response
              .asMap()
              .entries
              .map((entry) => Patient.fromAddPatientModel(entry.value, entry.key))
              .toList();
        });
      } catch (e) {
        print('Error searching patients: $e');
        setState(() => _displayedPatients = []);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double itemAspectRatio = 149 / 47;

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
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    endIndent: 8,
                  ),
                ),
                Text(
                  'My Patients',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 8,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search by name',
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _displayedPatients.isEmpty
                  ? const Center(child: Text('No patients found'))
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: itemAspectRatio,
                ),
                itemCount: _displayedPatients.length,
                itemBuilder: (context, index) {
                  return PatientCardWidget(
                      patient: _displayedPatients[index]);
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
              return AddPatientScreen(
                onPatientAdded: (newPatient) {
                  // Convert AddPatientModel to Patient and add to lists
                  setState(() {
                    final patient = Patient.fromAddPatientModel(
                        newPatient, _allPatients.length);
                    _allPatients.add(patient);
                    _displayedPatients = List.from(_allPatients); // Update displayed list
                  });
                },
              );
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color(0xFF52B696A),
        ),
      ),
    );
  }
}