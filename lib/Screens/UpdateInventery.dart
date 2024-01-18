import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateInvent extends StatefulWidget {

  const UpdateInvent({Key? key, required this.IncrKey}) : super(key: key);

  final String IncrKey;

  @override
  State<UpdateInvent> createState() => _UpdateInventState();
}

class _UpdateInventState extends State<UpdateInvent> {

  final  usernameController = TextEditingController();
  final  userQuantityController= TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Incr');
    getProductData();
  }

  void getProductData() async {
    DataSnapshot snapshot = await dbRef.child(widget.IncrKey).get();

    Map Incr = snapshot.value as Map;

    usernameController.text = Incr['Name'];
    userQuantityController.text = Incr['Quantity'];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating Inventory'),
      ),
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Updating data in Firebase Realtime Database',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: userQuantityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity',
                  hintText: 'Enter Quantity',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {

                  Map<String, String> Incr = {
                    'Name': usernameController.text,
                    'Quantity': userQuantityController.text,
                  };

                  dbRef.child(widget.IncrKey).update(Incr)
                      .then((value) => {
                    Navigator.pop(context)
                  });

                },
                child: const Text('Update Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}