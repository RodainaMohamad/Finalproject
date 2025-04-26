class TemperatureState {
  final String temperature;
  final bool isConnected;
  final String? error;

  TemperatureState({
    this.temperature = "0.0",
    this.isConnected = false,
    this.error,
  });

  TemperatureState copyWith({
    String? temperature,
    bool? isConnected,
    String? error,
  }) {
    return TemperatureState(
      temperature: temperature ?? this.temperature,
      isConnected: isConnected ?? this.isConnected,
      error: error ?? this.error,
    );
  }
}