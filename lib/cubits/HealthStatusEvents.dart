import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/widgets/AnimatedStatusIndicator.dart';
import 'package:grad_project/cubits/HealthStatusState.dart';
import 'package:grad_project/cubits/HeartRate_events.dart';
import 'package:grad_project/cubits/MQTT__Temp_events.dart';
import 'package:grad_project/cubits/OxygenRate_events.dart';

class HealthStatusCubit extends Cubit<HealthStatusState> {
  final HeartRateCubit heartRateCubit;
  final TemperatureCubit temperatureCubit;
  final OxygenRateCubit oxygenRateCubit;

  HealthStatusCubit({
    required this.heartRateCubit,
    required this.temperatureCubit,
    required this.oxygenRateCubit,
  }) : super(HealthStatusState.initial()) {
    _subscribeToCubits();
  }

  void _subscribeToCubits() {
    // Listen to heart rate changes
    heartRateCubit.stream.listen((heartRateState) {
      _updateStatus();
    });

    // Listen to temperature changes
    temperatureCubit.stream.listen((tempState) {
      _updateStatus();
    });

    // Listen to oxygen rate changes
    oxygenRateCubit.stream.listen((oxygenState) {
      _updateStatus();
    });

    // Initial update
    _updateStatus();
  }

  void _updateStatus() {
    final heartRate = int.tryParse(heartRateCubit.state.heartRate ?? '') ?? 0;
    final temperature = double.tryParse(temperatureCubit.state.temperature ?? '') ?? 0.0;
    final oxygenRate = oxygenRateCubit.state.oxygenRate ?? 0.0;

    String statusLabel;

    // Define normal and critical ranges
    bool isHeartRateNormal = heartRate >= 60 && heartRate <= 100;
    bool isHeartRateSlightlyOff = (heartRate >= 50 && heartRate < 60) || (heartRate > 100 && heartRate <= 120);
    bool isHeartRateCritical = heartRate < 50 || heartRate > 120;

    bool isTemperatureNormal = temperature >= 36.1 && temperature <= 37.2;
    bool isTemperatureSlightlyOff = (temperature >= 35.0 && temperature < 36.1) || (temperature > 37.2 && temperature <= 38.0);
    bool isTemperatureCritical = temperature < 35.0 || temperature > 38.0;

    bool isOxygenNormal = oxygenRate >= 95.0 && oxygenRate <= 100.0;
    bool isOxygenSlightlyOff = oxygenRate >= 90.0 && oxygenRate < 95.0;
    bool isOxygenCritical = oxygenRate < 90.0;

    // Determine status
    if (isHeartRateNormal && isTemperatureNormal && isOxygenNormal) {
      statusLabel = 'Very Good';
    } else if (isHeartRateCritical || isTemperatureCritical || isOxygenCritical) {
      statusLabel = 'Bad';
    } else if (isHeartRateSlightlyOff || isTemperatureSlightlyOff || isOxygenSlightlyOff) {
      statusLabel = 'Good';
    } else {
      statusLabel = 'Unknown';
    }

    emit(state.copyWith(
      statusItemData: StatusItemData(label: statusLabel),
      error: null,
    ));
  }

  @override
  Future<void> close() {
    // No need to close the dependent cubits here; they manage their own lifecycle
    return super.close();
  }
}