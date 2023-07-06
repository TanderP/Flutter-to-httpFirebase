// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // to remove debug banner
    );
  }
}

// define my app the add class for Homescreen
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String dataBaseUrl =
      "https://tdr1-89467-default-rtdb.asia-southeast1.firebasedatabase.app/";
  void sendData() async {
    final response = await http.put(
      Uri.parse(
          "$dataBaseUrl/counter.json"), // to add data to the database in firebase
      body: json.encode(
        {
          "counter": counterFireBase,
        },
      ),
    );
    // to send to the firebase
  }

  void sendNewData() async {
    final response = await http.post(
      Uri.parse(
          "$dataBaseUrl/counter2.json"), // to add data to the database in firebase
      body: json.encode(
        {
          "counter": counterFireBase,
        },
      ),
    );
    // to send to the firebase
  }

  void getData1() async {
    final response = await http.get(
      Uri.parse("$dataBaseUrl.json"), // to add data to the database in firebase
    );
    final data = json.decode(response.body);
    setState(() {
      getDataFB = data["DataSTr"].toString();
    });
    // to get data directly from the firebase
  }

  void getData2() async {
    final response = await http.get(
      Uri.parse(
          "$dataBaseUrl/DataString.json"), // to add data to the database in firebase
    );
    final data = json.decode(response.body);
    setState(() {
      getDataFB2 = data["DataFile1'"].toString();
    });
    // to get data from firebase child
  }

  int counterFireBase = 0;
  String getDataFB = "NULL";
  String getDataFB2 = "NULL";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "First Page",
          style: TextStyle(
            color: Colors.amber,
          ),
        )),
      ),

      body: Row(
        children: [
          Column(
            children: [
              FloatingActionButton(
                onPressed: () {
                  print("Clicked");
                  setState(() {
                    counterFireBase++;
                    sendData();
                    getData1();
                    getData2();
                    sendNewData();
                  });
                },
                child: const Icon(Icons.add),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "$getDataFB",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "$getDataFB2",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // naviagtor to new page

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          print("Clicked");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
