import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubits/OxygenRate_states.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class OxygenRateCubit extends Cubit<OxygenRateState> {
  late MqttServerClient client;
  final String topic = 'device/sensor/spo2';  // Specific SpO2 topic

  OxygenRateCubit() : super(OxygenRateState()) {
    _connectToMqtt();
  }

  Future<void> _connectToMqtt() async {
    client = MqttServerClient.withPort(
      'fc8731aef5304f3aad37fa03be01e517.s1.eu.hivemq.cloud',
      'FLUTTER_O2_client_${DateTime.now().millisecondsSinceEpoch}',
      8883,
    );

    client.secure = true;
    client.onBadCertificate = (dynamic cert) => true;
    client.setProtocolV311();

    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    client.onUnsubscribed = _onUnsubscribed;
    client.pongCallback = _onPong;

    client.logging(on: true);

    final connMess = MqttConnectMessage()
        .withClientIdentifier('FLUTTER_O2_client_${DateTime.now().millisecondsSinceEpoch}')
        .authenticateAs('finalProject', 'Fb123456')
        .startClean()
        .keepAliveFor(60);

    client.connectionMessage = connMess;

    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        await client.connect();
        emit(state.copyWith(isConnected: true, error: null));
        return;
      } catch (e) {
        retryCount++;
        if (retryCount == maxRetries) {
          emit(state.copyWith(
            isConnected: false,
            error: 'Failed to connect after $maxRetries attempts: $e',
          ));
          return;
        }
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  void _onConnected() {
    client.subscribe(topic, MqttQos.atMostOnce);
  }

  void _onDisconnected() {
    emit(state.copyWith(isConnected: false));
    Future.delayed(Duration(seconds: 5), _connectToMqtt);
  }

  void _onSubscribed(String topic) {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      // Parse oxygen rate value (assuming format "96" or "SpO2: 96%")
      final o2Value = _parseOxygenRate(pt);

      if (o2Value != null) {
        emit(state.copyWith(oxygenRate: o2Value, error: null));
      } else {
        emit(state.copyWith(error: 'Invalid SpO2 data: $pt'));
      }
    }, onError: (error) {
      emit(state.copyWith(error: 'MQTT update error: $error'));
    });
  }

  String? _parseOxygenRate(String payload) {
    // Handle different possible formats:
    // 1. Just the number: "96"
    // 2. Labeled value: "SpO2: 96%"
    // 3. Other formats

    final numericRegex = RegExp(r'\d+');
    final match = numericRegex.firstMatch(payload);
    final value = match?.group(0);

    // Validate it's a reasonable SpO2 value (0-100)
    if (value != null) {
      final intValue = int.tryParse(value);
      if (intValue != null && intValue >= 0 && intValue <= 100) {
        return value;
      }
    }
    return null;
  }

  void _onUnsubscribed(String? topic) {}
  void _onPong() {}

  @override
  Future<void> close() {
    client.disconnect();
    return super.close();
  }
}