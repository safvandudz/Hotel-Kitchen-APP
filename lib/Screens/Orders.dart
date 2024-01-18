import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/Screens/Cheff.dart';

import 'OrderManagment.dart';
import 'UpdateRecord.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  Query dbRef = FirebaseDatabase.instance.ref().child('Product');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Product');

  Widget listItem({required Map Product}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 10,right: 10),
      child: Container(
        height: 124,decoration: BoxDecoration(
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
                    Product['name'],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Container(width: 100,height: 50,child:Image.network(Product['image']),),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(ProductKey: Product['key'])));
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
                GestureDetector(
                  onTap: () {
                    reference.child(Product['key']).remove();
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
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: GestureDetector(
                    onTap: () {
                      navigateToOtherPage(Product['name'], Product['image']);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
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

              Map Product = snapshot.value as Map;
              Product['key'] = snapshot.key;

              return listItem(Product: Product);

            },
          ),
        )
    );
  }
}