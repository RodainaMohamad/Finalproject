import 'package:flutter/material.dart';
import 'package:grad_project/API_integration/models/GetNurseNodel.dart';
import 'package:grad_project/API_integration/services/DeleteNurse_service.dart'; // Import the service

class StaffCardWidget extends StatelessWidget {
  final Nurse nurse;
  final VoidCallback onNurseDeleted;

  const StaffCardWidget({
    Key? key,
    required this.nurse,
    required this.onNurseDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;
    final cardHeight = cardWidth / 4.5;

    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white, width: 0.6),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile image
          Container(
            width: cardHeight * 0.35,
            height: cardHeight * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/doctor.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Nurse Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nurse.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                Text(
                  'SSN: ${nurse.ssn}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.023,
                  ),
                ),
                Text(
                  'Role: ${nurse.role}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.023,
                  ),
                ),
                Text(
                  'Ward: ${nurse.ward}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.023,
                  ),
                ),
              ],
            ),
          ),

          // More options + status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton<String>(
                color: const Color(0xFF1E5A5E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onSelected: (value) async {
                  if (value == 'delete') {
                    try {
                      // Call the delete service
                      await DeleteNurseService().deleteNurse(nurse.id);
                      // Notify parent to refresh the list
                      onNurseDeleted();
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nurse ${nurse.name} deleted successfully'),
                        ),
                      );
                    } catch (e) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to delete nurse: $e'),
                        ),
                      );
                    }
                  } else if (value == 'edit') {
                    // TODO: Implement edit functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit functionality not implemented yet'),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(color: Colors.white)),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit', style: TextStyle(color: Colors.white)),
                  ),
                ],
                child: const Icon(Icons.more_vert, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}