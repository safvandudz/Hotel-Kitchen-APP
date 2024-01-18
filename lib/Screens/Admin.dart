import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/Screens/MenuManagment.dart';
import 'package:login_firebase/Screens/Orders.dart';

import 'Inventary Managment.dart';
import 'OrderManagment.dart';
import 'login.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 30),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  Order(),));
          },child: Padding(
            padding: const EdgeInsets.only(left: 25,top:25),
            child: Container(width: 300,height: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.blue),child: Center(child:
            Text('Order Managment',style: TextStyle(fontSize: 20,color: Colors.white),)),),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const InventaryManagment(),));
          },child: Padding(
          padding: const EdgeInsets.only(left: 25,top:25),
          child: Container(width: 300,height: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.blue),child: Center(child:
          Text('Inventary Managment',style: TextStyle(fontSize: 20,color: Colors.white),)),),
        ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MenuManagment(),));
          },child: Padding(
          padding: const EdgeInsets.only(left: 25,top:25),
          child: Container(width: 300,height: 100,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.blue),child: Center(child:
          Text('Menu Managment',style: TextStyle(fontSize: 20,color: Colors.white),)),),
        ),
        )
      ]),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

//
// IconButton(
// onPressed: () {
// logout(context);
// },
// icon: Icon(
// Icons.logout,
// ),
// )
