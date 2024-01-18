import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/Screens/UpdateInventery.dart';

import 'UpdateMenu.dart';

class InventaryManagment extends StatefulWidget {
  const InventaryManagment({Key? key}) : super(key: key);

  @override
  State<InventaryManagment> createState() => _InventaryManagmentState();
}

class _InventaryManagmentState extends State<InventaryManagment> {

  Query dbRef3 = FirebaseDatabase.instance.ref().child('Incr');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Incr');

  Widget listItem1({required Map Incr}) {
    return Container(decoration: BoxDecoration(   color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      height: 100,
     child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Name: ${Incr['Name'].toString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Quantity: ${Incr['Quantity'].toString()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add edit functionality if needed
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateInvent(IncrKey: Incr['key']),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    reference.child(Incr['key']).remove();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Incredients'),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef3,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

              Map Incr = snapshot.value as Map;
              Incr['key'] = snapshot.key;

              return listItem1(Incr: Incr);

            },
          ),
        )
    );
  }
}
