import 'package:ealphabits_practical/core/services/socket_services.dart';
import 'package:ealphabits_practical/home_main.dart';
import 'package:ealphabits_practical/utils/base_loader.dart';
import 'package:ealphabits_practical/utils/socket_constant.dart';
import 'package:flutter/material.dart';

void main() async {
  // app loader initialization
  await BaseLoader.instance.init();
  // Socket initialization
  // SocketService socketService = SocketService();
  // socketService.initialize(SocketConstant.SOCKET_URL);

  runApp(const MyApp());
}

