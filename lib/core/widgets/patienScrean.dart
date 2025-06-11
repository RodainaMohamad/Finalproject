import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/AddReportModel.dart';
import 'package:grad_project/API_integration/models/PatientByIdModel.dart';
import 'package:grad_project/API_integration/models/patientmodel.dart';
import 'package:grad_project/API_integration/services/PatientIdDetails_service.dart';
import 'package:grad_project/core/widgets/patiencard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addpatient.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> with WidgetsBindingObserver {
  bool _isExpanded = false;
  final PatientIdDetailsService _patientService = PatientIdDetailsService();
  List<PatientByIdModel> _allPatients = [];
  List<PatientByIdModel> _displayedPatients = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  bool _prefsError = false;
  late SharedPreferences _prefs;
  bool _prefsInitialized = false;
  List<int> _knownPatientIds = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
    Future.delayed(Duration.zero, () => setState(() => _isExpanded = true));
    _searchController.addListener(() => _handleSearch(_searchController.text));
  }

  Future<void> _initializeApp() async {
    await _initSharedPreferences();
    await _loadKnownPatientIds();
    await _loadAllPatients();
  }

  Future<void> _initSharedPreferences() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      setState(() => _prefsInitialized = true);
    } catch (e) {
      print('Error initializing SharedPreferences: $e');
      setState(() => _prefsInitialized = false);
    }
  }

  Future<void> _loadKnownPatientIds() async {
    if (!_prefsInitialized) return;

    try {
      final ids = _prefs.getStringList('knownPatientIds');
      if (ids != null) {
        setState(() {
          _knownPatientIds = ids.map(int.parse).toList();
        });
      }
    } catch (e) {
      print('Error loading known patient IDs: $e');
    }
  }

  Future<void> _loadAllPatients() async {
    setState(() => _isLoading = true);

    try {
      List<PatientByIdModel> loadedPatients = [];
      List<int> successfulIds = [];

      for (int id in _knownPatientIds) {
        try {
          final patient = await _patientService.getPatientById(id);
          loadedPatients.add(patient);
          successfulIds.add(id);
          print('Successfully loaded patient $id with ${patient.reports?.length ?? 0} reports');
        } catch (e) {
          print('Error loading patient $id: $e');
        }
      }

      int nextId = _knownPatientIds.isEmpty ? 1 : (_knownPatientIds.reduce((a, b) => a > b ? a : b) + 1);
      int newPatientsFound = 0;

      for (int i = 0; i < 10; i++) {
        try {
          final patient = await _patientService.getPatientById(nextId + i);
          loadedPatients.add(patient);
          successfulIds.add(patient.id!);
          newPatientsFound++;
          print('Discovered new patient ${patient.id}');
        } catch (e) {
          print('Error discovering patient ${nextId + i}: $e');
        }
      }

      setState(() {
        _allPatients = loadedPatients;
        _displayedPatients = List.from(_allPatients);
        _knownPatientIds = successfulIds.toSet().toList();
      });

      if (_prefsInitialized) {
        await _prefs.setStringList(
            'knownPatientIds', _knownPatientIds.map((id) => id.toString()).toList());
        await _savePatientsLocally();
      }

      if (newPatientsFound > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Found $newPatientsFound new patients')));
      }
    } catch (e) {
      print('Error loading all patients: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error loading patients. Showing cached data.')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _savePatientsLocally() async {
    if (!_prefsInitialized) return;

    try {
      final patientsJson = _allPatients.map((p) => jsonEncode(p.toJson())).toList();
      await _prefs.setStringList('patients', patientsJson);
    } catch (e) {
    print('Error saving patients locally: $e');
    setState(() => _prefsError = true);
    }
  }

  void _handleSearch(String query) {
    if (query.isEmpty) {
      setState(() => _displayedPatients = List.from(_allPatients));
    } else {
      setState(() {
        _displayedPatients = _allPatients
            .where((patient) =>
        patient.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
            .toList();
      });
    }
  }

  void _updateReportData(int patientId, AddReportModel newReport) {
    setState(() {
      final patientIndex = _allPatients.indexWhere((p) => p.id == patientId);
      if (patientIndex != -1) {
        final newReportData = Report(
          id: newReport.id,
          uploadDate: newReport.uploadDate,
          diagnosis: newReport.diagnosis,
          medication: newReport.medication,
        );
        _allPatients[patientIndex].reports ??= [];
        _allPatients[patientIndex].reports!.add(newReportData);
        _displayedPatients = List.from(_allPatients);
      }
    });
    if (_prefsInitialized) {
      _savePatientsLocally();
    }
  }

  void _onReportUpdated(int patientId) {
    setState(() {
      _displayedPatients = List.from(_allPatients);
    });
    if (_prefsInitialized) {
      _savePatientsLocally();
    }
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
            if (_prefsError)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Local storage unavailable. Data may not persist between sessions.',
                  style: TextStyle(color: Colors.red[200]),
                ),
              ),
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
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No patients found'),
                    ElevatedButton(
                      onPressed: _loadAllPatients,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
                  : RefreshIndicator(
                onRefresh: _loadAllPatients,
                child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: itemAspectRatio,
                  ),
                  itemCount: _displayedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = _displayedPatients[index];
                    final latestReport = patient.reports != null &&
                        patient.reports!.isNotEmpty
                        ? patient.reports!.reduce((a, b) {
                      final aDate =
                      DateTime.tryParse(a.uploadDate ?? '');
                      final bDate =
                      DateTime.tryParse(b.uploadDate ?? '');
                      if (aDate == null || bDate == null) return a;
                      return aDate.isAfter(bDate) ? a : b;
                    })
                        : null;
                    return PatientCardWidget(
                      patient: Patient(
                        id: patient.id,
                        name: patient.name,
                        ssn: patient.ssn,
                        profileImage: patient.profileImage,
                        status: patient.status,
                        reportId: latestReport?.id?.toString(),
                        reportDetails: latestReport?.diagnosis,
                        reportDate: latestReport?.uploadDate != null
                            ? DateTime.tryParse(latestReport!.uploadDate!)
                            : null,
                      ),
                      index: index,
                      onDeleted: () async {
                        setState(() {
                          _allPatients
                              .removeWhere((p) => p.id == patient.id);
                          _displayedPatients = List.from(_allPatients);
                          _knownPatientIds.remove(patient.id);
                        });
                        if (_prefsInitialized) {
                          await _savePatientsLocally();
                          await _prefs.setStringList('knownPatientIds',
                              _knownPatientIds.map((id) => id.toString()).toList());
                        }
                      },
                      reportId: latestReport?.id?.toString(),
                      initialDiagnosis: latestReport?.diagnosis,
                      initialReportDate: latestReport?.uploadDate != null
                          ? DateTime.tryParse(latestReport!.uploadDate!)
                          : null,
                      onReportUpdated: () => _onReportUpdated(patient.id!),
                      reports: patient.reports,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: AddPatientScreen(
                  onPatientAdded: (newPatient) async {
                    setState(() {
                      final patient = PatientByIdModel.fromJson(newPatient.toJson());
                      _allPatients.add(patient);
                      _displayedPatients = List.from(_allPatients);
                      if (patient.id != null && !_knownPatientIds.contains(patient.id)) {
                        _knownPatientIds.add(patient.id!);
                      }
                    });
                    if (_prefsInitialized) {
                      await _savePatientsLocally();
                      await _prefs.setStringList('knownPatientIds',
                          _knownPatientIds.map((id) => id.toString()).toList());
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Patient added successfully!')));
                  },
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color(0xFF52B696),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    super.dispose();
  }
}