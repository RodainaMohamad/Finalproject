import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubits/MQTT__Temp_states.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  late MqttServerClient client;

  TemperatureCubit() : super(TemperatureState()) {
    _connectToMqtt();
  }

  Future<void> _connectToMqtt() async {
    client = MqttServerClient.withPort(
      'fc8731aef5304f3aad37fa03be01e517.s1.eu.hivemq.cloud',
      'FLUTTER_client_${DateTime.now().millisecondsSinceEpoch}',
      8883,
    );

    // Set secure connection
    client.secure = true;
    client.onBadCertificate = (dynamic cert) => true;

    // Set protocol
    client.setProtocolV311();

    // Set callbacks
    client.onConnected = _onConnected;
    client.onDisconnected = _onDisconnected;
    client.onSubscribed = _onSubscribed;
    client.onUnsubscribed = _onUnsubscribed;
    client.pongCallback = _onPong;

    // Connection logging
    client.logging(on: true);

    // Connect options
    final connMess = MqttConnectMessage()
        .withClientIdentifier('FLUTTER_client_${DateTime.now().millisecondsSinceEpoch}')
        .authenticateAs('finalProject', 'Fb123456')
        .startClean()
        .keepAliveFor(60);

    client.connectionMessage = connMess;

    // Attempt connection with retries
    int retryCount = 0;
    const maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        //print('Attempting MQTT connection (attempt ${retryCount + 1})...');
        await client.connect();
        //print('MQTT Connection successful');
        emit(state.copyWith(isConnected: true, error: null));
        return; // Success
      } catch (e) {
        retryCount++;
        //print('MQTT Connection failed: $e');
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
    //print('!!!!!!Connected to MQTT server!!!!!!!');
    client.subscribe('device/sensor/temperature', MqttQos.atMostOnce);
  }

  void _onDisconnected() {
    //print('Disconnected from MQTT server. Reconnecting...');
    emit(state.copyWith(isConnected: false));
    Future.delayed(Duration(seconds: 5), () {
      _connectToMqtt();
    });
  }

  void _onSubscribed(String topic) {
    print('Subscribed to $topic');
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('Raw message: $pt');

      // Extract just the numeric temperature value
      final regex = RegExp(r'[\d.]+');
      final match = regex.firstMatch(pt);
      final tempValue = match?.group(0);

      if (tempValue != null && double.tryParse(tempValue) != null) {
        emit(state.copyWith(temperature: tempValue, error: null));
      } else {
        emit(state.copyWith(error: 'Invalid temperature format: $pt'));
      }
    });
  }

  void _onUnsubscribed(String? topic) {}
  void _onPong() {}

  @override
  Future<void> close() {
    client.disconnect();
    return super.close();
  }
}