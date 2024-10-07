import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String stringResponse;
  late Map mapResponse;
  late Map dataResponse;
  late List listResponse;

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        // dataResponse = mapResponse['data'];
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Center(
              child: Text("API Integration",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w200)),
            )),
        //   body: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Center(
        //         child: Container(
        //           width: 400,
        //           height: 200,
        //           decoration: BoxDecoration(
        //               color: Colors.blue.shade200,
        //               borderRadius: BorderRadius.circular(20)),
        //           child: Center(
        //             // child: Text(stringResponse.toString()),
        //             // child: mapResponse == null
        //             //     ? Text("Loading")
        //             //     : Text(mapResponse['data'].toString()),
        //             // ignore: unnecessary_null_comparison
        //             child: listResponse == null
        //                 ? Text("Loading")
        //                 : Text(listResponse[1].toString()),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(listResponse[index]['avatar']),
                    ),
                    Text(listResponse[index]["id"].toString()),
                    Text(listResponse[index]["first_name"].toString()),
                    Text(listResponse[index]["last_name"].toString()),
                  ],
                ),
              );
            },
            // ignore: unnecessary_null_comparison
            itemCount: listResponse == null ? 0 : listResponse.length));
  }
}
