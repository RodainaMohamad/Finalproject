import 'package:flutter/material.dart';

import '../../API_integration/models/patientmodel.dart';
import 'addreport.dart';

class PatientCardWidget extends StatelessWidget {
  final Patient patient;

  const PatientCardWidget({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final cardWidth = screenWidth * 0.4;
        final cardHeight = 80.0;

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white, width: 0.6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 4, top: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: cardHeight * 0.45,
                          height: cardHeight * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              patient.profileImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Dennisa Nedry',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: cardHeight * 0.15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'ID: 20254831 • Location: Assut • Age: 23',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: cardHeight * 0.1,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                        PopupMenuButton<String>(
                          color: const Color(0xFF1E5A5E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onSelected: (value) {
                            if (value == 'delete') {
                              // حذف العنصر
                            } else if (value == 'edit') {
                              // تعديل العنصر
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: cardHeight * 0.2,
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: cardHeight * 0.2,
                                ),
                              ),
                            ),
                          ],
                          child: SizedBox(
                            width: cardHeight * 0.2,
                            height: cardHeight * 0.25,
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 24, right: 8, bottom: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                   
                                },
                                child: Container(
                                  height: cardHeight * 0.225,
                                  width: cardWidth * 0.28,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2C6768),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Text(
                                    'Check Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: cardHeight * 0.1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
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
                                          child: AddReport(),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: cardHeight * 0.225,
                                  width: cardWidth * 0.28,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2C6768),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Text(
                                    'Add Report',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: cardHeight * 0.1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _buildPatientStatus(
                                patient.status, cardHeight * 0.35),
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

    final circleDiameter = sizeFactor * 1.2;
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
              color: Color(0xFF5DC1C3),
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
