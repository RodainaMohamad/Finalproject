class Patient {
  final String id;
  final String name;
  final String lastUpdate;
  final String profileImage;
  final String status; // << أضفنا الحالة هنا

  Patient({
    required this.id,
    required this.name,
    required this.lastUpdate,
    required this.profileImage,
    required this.status, // << و هنا كمان
  });

  // بيانات للعرض فقط
  static List<Patient> getDummyPatients() {
    return List.generate(
      10,
      (index) => Patient(
        id: 'ID${index + 1}',
        name: 'Dennisa Nodey',
        lastUpdate: '14/08/2023',
        profileImage: 'https://via.placeholder.com/40',
        status: _getRandomStatus(index), // << نولّد حالة وهمية
      ),
    );
  }

  static String _getRandomStatus(int index) {
    final statuses = ['Very Good', 'Good', 'Bad', 'Very Bad'];
    return statuses[index % statuses.length];
  }
}
