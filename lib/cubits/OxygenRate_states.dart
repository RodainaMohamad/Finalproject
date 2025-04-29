class OxygenRateState {
  final bool isConnected;
  final double? oxygenRate;
  final String? error;

  OxygenRateState({
    this.isConnected = false,
    this.oxygenRate,
    this.error,
  });

  OxygenRateState copyWith({
    bool? isConnected,
    double? oxygenRate,
    String? error,
  }) {
    return OxygenRateState(
      isConnected: isConnected ?? this.isConnected,
      oxygenRate: oxygenRate ?? this.oxygenRate,
      error: error ?? this.error,
    );
  }
}