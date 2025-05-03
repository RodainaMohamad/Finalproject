class OxygenRateState {
  final bool isConnected;
  final double? oxygenRate;
  final String? rawValue;  // Add this line
  final String? error;

  OxygenRateState({
    this.isConnected = false,
    this.oxygenRate,
    this.rawValue,  // Add this
    this.error,
  });

  OxygenRateState copyWith({
    bool? isConnected,
    double? oxygenRate,
    String? rawValue,  // Add this
    String? error,
  }) {
    return OxygenRateState(
      isConnected: isConnected ?? this.isConnected,
      oxygenRate: oxygenRate ?? this.oxygenRate,
      rawValue: rawValue ?? this.rawValue,  // Add this
      error: error ?? this.error,
    );
  }
}