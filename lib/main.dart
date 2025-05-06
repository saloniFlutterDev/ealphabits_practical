import 'package:ealphabits_practical/core/services/socket_services.dart';
import 'package:ealphabits_practical/home_main.dart';
import 'package:ealphabits_practical/utils/base_loader.dart';
import 'package:ealphabits_practical/utils/socket_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/local_data/shared_pref_utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // local storage initialization
  await SharedPreferenceUtils.init();
  // firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // app loader initialization
  await BaseLoader.instance.init();

  // Socket initialization
  // SocketService socketService = SocketService();
  // socketService.initialize(SocketConstant.SOCKET_URL);

  runApp(const MyApp());
}
