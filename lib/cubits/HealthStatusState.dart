import 'package:equatable/equatable.dart';
import 'package:grad_project/core/widgets/AnimatedStatusIndicator.dart';

class HealthStatusState extends Equatable {
  final StatusItemData statusItemData;
  final String? error;

  const HealthStatusState({
    required this.statusItemData,
    this.error,
  });

  factory HealthStatusState.initial() => HealthStatusState(
    statusItemData: StatusItemData(label: 'Unknown'),
    error: null,
  );

  HealthStatusState copyWith({
    StatusItemData? statusItemData,
    String? error,
  }) {
    return HealthStatusState(
      statusItemData: statusItemData ?? this.statusItemData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [statusItemData, error];
}