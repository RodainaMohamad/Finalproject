class OxygenRateState {
  final bool isConnected;
  final String? oxygenRate;
  final String? error;

  OxygenRateState({
    this.isConnected = false,
    this.oxygenRate,
    this.error,
  });

  OxygenRateState copyWith({
    bool? isConnected,
    String? oxygenRate,
    String? error,
  }) {
    return OxygenRateState(
      isConnected: isConnected ?? this.isConnected,
      oxygenRate: oxygenRate ?? this.oxygenRate,
      error: error ?? this.error,
    );
  }
}