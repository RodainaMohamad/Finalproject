import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/services/DeletePatient_service.dart';
import 'package:grad_project/core/widgets/EditReport.dart';
import 'package:grad_project/core/widgets/addreport.dart';
import '../../API_integration/models/patientmodel.dart';
import '../../API_integration/models/PatientByIdModel.dart';

class PatientCardWidget extends StatefulWidget {
  final Patient patient;
  final int index;
  final VoidCallback? onDeleted;
  final String? reportId;
  final String? initialReportDetails;
  final DateTime? initialReportDate;
  final VoidCallback? onReportUpdated;
  final List<Report>? reports;

  const PatientCardWidget({
    Key? key,
    required this.patient,
    required this.index,
    this.onDeleted,
    this.reportId,
    this.initialReportDetails,
    this.initialReportDate,
    this.onReportUpdated,
    this.reports,
  }) : super(key: key);

  @override
  _PatientCardWidgetState createState() => _PatientCardWidgetState();
}

class _PatientCardWidgetState extends State<PatientCardWidget> {
  Report? _selectedReport;

  @override
  void initState() {
    super.initState();
    if (widget.reportId != null &&
        widget.initialReportDetails != null &&
        widget.initialReportDate != null) {
      _selectedReport = Report(
        id: int.tryParse(widget.reportId!),
        reportDetails: widget.initialReportDetails,
        uploadDate: widget.initialReportDate!.toIso8601String(),
      );
    } else if (widget.reports != null && widget.reports!.isNotEmpty) {
      _selectedReport = widget.reports!.reduce((a, b) {
        final aDate = DateTime.tryParse(a.uploadDate ?? '');
        final bDate = DateTime.tryParse(b.uploadDate ?? '');
        if (aDate == null || bDate == null) return a;
        return aDate.isAfter(bDate) ? a : b;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = screenWidth * 0.9;
        final cardHeight = cardWidth / 3.5;

        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            border: Border.all(color: Colors.white, width: 0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: cardHeight * 0.35,
                  height: cardHeight * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      widget.patient.profileImage ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.patient.name ?? 'Unknown',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: cardHeight * 0.14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        'SSN: ${widget.patient.ssn ?? 'N/A'} • Age: 25',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: cardHeight * 0.09,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 3),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Implement Check Profile
                                      },
                                      child: Container(
                                        height: cardHeight * 0.18,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff2C6768),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Text(
                                          'Check Profile',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: cardHeight * 0.08,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) {
                                            return Center(
                                              child: Container(
                                                width: screenWidth * 0.9,
                                                padding:
                                                const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xff2C999B),
                                                  borderRadius:
                                                  BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: AddReport(
                                                  patientId:
                                                  widget.patient.id ??
                                                      widget.index + 1,
                                                  onReportAdded: (newReport) {
                                                    widget.onReportUpdated
                                                        ?.call(); // Trigger update
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Report added successfully'),
                                                        backgroundColor:
                                                        Colors.green,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: cardHeight * 0.18,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff2C6768),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: Text(
                                          'Add Report',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: cardHeight * 0.08,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _buildPatientStatus(
                                widget.patient.status ?? 'Unknown',
                                cardHeight * 0.25),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                PopupMenuButton<String>(
                  color: const Color(0xFF1E5A5E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onSelected: (value) async {
                    if (value == 'delete') {
                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: Text(
                              'Are you sure you want to delete ${widget.patient.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );

                      if (confirmDelete) {
                        try {
                          final deleteService = DeletePatientService();
                          const String token = "YOUR_AUTH_TOKEN_HERE";
                          await deleteService.deletePatient(
                            widget.patient.id ?? widget.index + 1,
                            token: token,
                          );
                          widget.onDeleted?.call();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${widget.patient.name} deleted successfully'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to delete patient: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    } else if (value == 'edit') {
                      if (widget.reports == null || widget.reports!.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No report available to edit'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Select Report to Edit'),
                            content: StatefulBuilder(
                              builder: (context, setState) {
                                return DropdownButton<Report>(
                                  isExpanded: true,
                                  value: _selectedReport,
                                  hint: const Text('Select a report'),
                                  items: widget.reports!.map((report) {
                                    return DropdownMenuItem<Report>(
                                      value: report,
                                      child: Text(
                                        'Report ${report.id}: ${report.reportDetails ?? 'No details'}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (Report? newValue) {
                                    setState(() {
                                      _selectedReport = newValue;
                                    });
                                  },
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (_selectedReport != null) {
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return Center(
                                          child: Container(
                                            width: screenWidth * 0.9,
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff2C999B),
                                              borderRadius:
                                              BorderRadius.circular(25),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                            child: EditReport(
                                              patientId: widget.patient.id ??
                                                  widget.index + 1,
                                              reportId:
                                              _selectedReport!.id!.toString(),
                                              initialReportDetails:
                                              _selectedReport!.reportDetails ??
                                                  '',
                                              initialDate: DateTime.parse(
                                                  _selectedReport!.uploadDate!),
                                              onReportUpdated: (updatedReport) {
                                                widget.onReportUpdated?.call();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Report updated successfully'),
                                                    backgroundColor: Colors.green,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: const Text('Edit'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: cardHeight * 0.14,
                        ),
                      ),
                    ),
                    if (widget.reports != null && widget.reports!.isNotEmpty)
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(
                          'Edit Report',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: cardHeight * 0.14,
                          ),
                        ),
                      ),
                  ],
                  child: SizedBox(
                    width: cardHeight * 0.15,
                    height: cardHeight * 0.25,
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPatientStatus(String status, double sizeFactor) {
    List<Color> gradientColors;

    switch (status.toLowerCase()) {
      case 'very good':
      case 'good':
        gradientColors = [
          const Color(0xFF0EF816),
          const Color(0xFFE4C206),
        ];
        break;
      case 'bad':
        gradientColors = [
          const Color(0xFFFE4A49),
          const Color(0xFFE4C206),
        ];
        break;
      case 'very bad':
        gradientColors = [
          const Color(0xFFFE4A49),
          const Color(0xFFE4C206),
          const Color(0xFF0EF816),
        ];
        break;
      default:
        gradientColors = [Colors.grey, Colors.grey];
    }

    final circleDiameter = sizeFactor * 1.7;
    final innerCircleDiameter = circleDiameter * 0.65;
    final fontSize = innerCircleDiameter * 0.4;

    return Container(
      width: circleDiameter,
      height: circleDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          width: innerCircleDiameter,
          height: innerCircleDiameter,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Text(
            status,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF5DC1C3),
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}