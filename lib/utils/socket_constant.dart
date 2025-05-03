class SocketConstant {
  SocketConstant._();

  static String SOCKET_URL = "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self";

  //Socket Transport Constant
  static const String websocket = "websocket";
  static const String polling = "polling";

  //Socket Listeners
  static const String messageListener = "messageListener";
  static const String temporaryWithoutAck = "temporaryWithoutAck";
  static const String temporaryWithAck = "temporaryWithAck";

}