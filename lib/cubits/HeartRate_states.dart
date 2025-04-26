class HeartRateState {
  final bool isConnected;
  final String? heartRate;
  final String? error;

  HeartRateState({
    this.isConnected = false,
    this.heartRate,
    this.error,
  });

  HeartRateState copyWith({
    bool? isConnected,
    String? heartRate,
    String? error,
  }) {
    return HeartRateState(
      isConnected: isConnected ?? this.isConnected,
      heartRate: heartRate ?? this.heartRate,
      error: error ?? this.error,
    );
  }
}