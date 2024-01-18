import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/Screens/Admin.dart';
import 'package:login_firebase/Screens/OrderManagment.dart';
import 'package:login_firebase/Screens/login.dart';
import 'package:provider/provider.dart';

import 'Screens/Inventary Managment.dart';
import 'Screens/MenuManagment.dart';
import 'Screens/Orders.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'Screens/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
   MaterialApp( // Use MaterialApp instead of GetMaterialApp
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
    ),
  );
}
