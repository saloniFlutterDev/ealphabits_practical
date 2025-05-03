import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ealphabits_practical/utils/base_strings.dart';
import 'package:ealphabits_practical/utils/base_widgets.dart';
import 'package:ealphabits_practical/utils/socket_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket _socket;

  factory SocketService() => _instance;

  SocketService._internal();

  //Todo: Socket Setup
  void initialize(String url) {
    print("Step 1");
    _socket = IO.io(
      url,
     IO.OptionBuilder()
          .setTransports([SocketConstant.websocket, SocketConstant.polling])
          .enableAutoConnect()
          .enableForceNewConnection()
          .build(),
    );
    print("Step 2");
    //Todo: Socket Connection Establishment
    reconnect();

    //Todo: Socket Connection Listeners
    _socket.onReconnect((_) {
      debugPrint("Reconnected to socket.");
    });
    _socket.onReconnectError((error) {
      debugPrint("Reconnect error: $error");
    });
    _socket.onConnect((_) async {
      print("Socket connected");
    });
    _socket.onDisconnect((_) {
      debugPrint("Socket disconnected");
    });
    _socket.onError((error) {
      debugPrint("Socket error: $error");
    });

    //Todo: Socket Methods Listeners
    on(SocketConstant.messageListener, (value) {
      debugPrint("Received Message > > > $value");
    });
  }

  socketCall({required Function function, Function? errorCallback}) async {
    if (await isConnected() && isSocketConnected()) {
      function();
    } else {
      if (errorCallback != null) {
        errorCallback();
      }
      BaseWidgets.toastMessage(title: BaseStrings.noInternetConnection);
    }
  }

  bool isSocketConnected() {
    return _socket.connected;
  }

  //Todo: Send data to Socket Method
  void emit({required String event, required dynamic data, Function(dynamic)? ackCallback, bool print = true}) async {
    bool connected = await isConnected();
    if (_socket.connected && connected) {
      if (ackCallback != null) {
        _socket.emitWithAck(event, data, ack: ackCallback);
      } else {
        _socket.emit(event, data);
      }
    } else {
      _socket.connect();
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }

  //Todo: Enable Listen data to Socket Method
  void on(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  //Todo: Disable Listen data to Socket Method
  void off(String event) {
    _socket.off(event);
  }

  //Todo: Disconnect Socket Method
  void disconnect() {
    _socket.disconnect();
  }

  //Todo: Connect Socket Method
  void reconnect() {
    debugPrint("Connect call");
    _socket.connect();
  }


  ///Todo: Method calls
  //Connect user call
  Future<void> temporaryWithoutAck() async {
    emit(event: SocketConstant.temporaryWithoutAck, data: {});
  }
}
