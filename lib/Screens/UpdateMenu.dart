import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateMenu extends StatefulWidget {

  const UpdateMenu({Key? key, required this.MenuKey}) : super(key: key);

  final String MenuKey;

  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

class _UpdateMenuState extends State<UpdateMenu> {

  final  usernameController = TextEditingController();
  final  userimageController= TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Menu');
    getProductData();
  }

  void getProductData() async {
    DataSnapshot snapshot = await dbRef.child(widget.MenuKey).get();

    Map Menu = snapshot.value as Map;

    usernameController.text = Menu['Name'];
    userimageController.text = Menu['Rate'];

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating Menu'),
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
                controller: userimageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Rate',
                  hintText: 'Enter Rate',
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

                  Map<String, String> Menu = {
                    'Name': usernameController.text,
                    'Rate': userimageController.text,
                  };

                  dbRef.child(widget.MenuKey).update(Menu)
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