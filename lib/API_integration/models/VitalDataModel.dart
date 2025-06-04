class VitalData {
  final String timestamp;
  final Map<String, dynamic> values;
  final String prediction;
  final int status;
  final List<String> tips;

  VitalData({
    required this.timestamp,
    required this.values,
    required this.prediction,
    required this.status,
    required this.tips,
  });

  factory VitalData.fromJson(Map<String, dynamic> json) {
    return VitalData(
      timestamp: json['timestamp'],
      values: Map<String, dynamic>.from(json['values']),
      prediction: json['prediction'],
      status: json['status'],
      tips: List<String>.from(json['tips']),
    );
  }
}