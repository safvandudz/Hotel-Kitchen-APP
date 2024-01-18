import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'OrderManagment.dart';
import 'UpdateRecord.dart';

class Cheff extends StatefulWidget {
  const Cheff({Key? key}) : super(key: key);

  @override
  State<Cheff> createState() => _CheffState();
}

class _CheffState extends State<Cheff> {

  Query dbRef = FirebaseDatabase.instance.ref().child('Task');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Task');

  Widget listItem({required Map Task}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
      child: Container(
        height: 180,decoration: BoxDecoration(
        color: Colors.amberAccent,borderRadius: BorderRadius.circular(30),
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    Task['name'],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(width: 100,height: 150,child:Image.network(Task['image']),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
  void navigateToOtherPage(String name, String image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtherPage(name: name, image: image),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              Map Task = snapshot.value as Map;
              Task['key'] = snapshot.key;

              return listItem(Task: Task);

            },
          ),
        )
    );
  }
}