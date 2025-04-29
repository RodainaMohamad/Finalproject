import 'package:flutter/material.dart';

class StaffCardWidget extends StatelessWidget {
  final bool isActive;

  const StaffCardWidget({
    Key? key,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.15,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.white, width: 1),
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
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/default_profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Shrouck Ahmed',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                        Text(
                          'ID: 20254831',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  
                  Column(
                    children: [
                      PopupMenuButton<String>(
                        color: const Color(0xFF1E5A5E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),

                      const SizedBox(height: 15), 

                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? Color(0xFF0EF816)
                              : Color(0xFFFF0000), 
                          boxShadow: [
                            BoxShadow(
                              color: isActive
                                  ? Color(0xFF0EF816)
                                  : Color(0xFFFF0000), 
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
