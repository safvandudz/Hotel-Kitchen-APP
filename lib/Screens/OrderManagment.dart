import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  final String name;
  final String image;

  OtherPage({required this.name, required this.image});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  final userNameController = TextEditingController();
  final userImageController = TextEditingController();
  final chefEmailController = TextEditingController(); // Controller to store the selected chef's email
  late DatabaseReference dbRef;
  String Email = 'Cheff@gmail.com';
  List<String> Emails = ['Cheff@gmail.com','Cheff2@gmail.com','Chef3@gmail.com'];


  // Add a loading indicator flag
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.reference().child('Task');

    userNameController.text = widget.name;
    userImageController.text = widget.image;
    // chefEmailController.text = Email;
    // Fetch chef emails when the widget is initialized
    // fetchChefEmails();
  }

  // List<String> chefEmails = [];
  // String selectedChefEmail = '';

  // Future<void> fetchChefEmails() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .where('rool', isEqualTo: 'Cheff')
  //         .get();
  //
  //     List<String> fetchedEmails =
  //     snapshot.docs.map((doc) => doc['email'] as String).toList();
  //
  //     List<String> uniqueEmails = fetchedEmails.toSet().toList();
  //
  //     setState(() {
  //       chefEmails = uniqueEmails;
  //       isLoading = false;
  //     });
  //
  //     print('Fetched chef emails successfully: $uniqueEmails');
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     print('Error fetching chef emails: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              listItem(),
              SizedBox(height: 20),
              Text('Selected Chef Email: $Email'),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  Map<String, String> Task = {
                    'name': userNameController.text,
                    'image': userImageController.text,
                    'Email': Email,
                  };

                  dbRef.push().set(Task);

                },
                child: const Text('Insert Data'),
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

  Widget listItem() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
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
                  widget.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.network(widget.image),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          isLoading
              ? CircularProgressIndicator()
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Chef Email:'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  value: Email,
                  onChanged: (String? newValue) {
                    setState(() {
                      Email = newValue!;
                    });
                  },
                  items: Emails.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(fontFamily: 'Font2')),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void insertData() {
  //   try {
  //     if (Email.isEmpty) {
  //       // Show an error message if the chef email is not selected
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text('Error'),
  //             content: Text('Please select a chef email.'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //       return;
  //     }
  //
  //     Map<String, String> Cheff = {
  //       'name': userNameController.text,
  //       'image': userImageController.text,
  //       'selectedChefEmail': Email, // Use the selected email
  //     };
  //
  //     dbRef.push().set(Cheff);
  //     userNameController.clear();
  //     userImageController.clear();
  //     setState(() {
  //       Email = '';
  //     });
  //   } catch (e) {
  //     print('Error inserting data: $e');
  //   }
  // }

}
