import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()=> runApp(
  MaterialApp(
    title: "Weather App",
    home: HomePage(),
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String countryName="Nepal";
  String cityName = "Pokhara";
  String degree = "0";

  // Note Please change the API key
  // Create your free api from: openweathermap.org
  String apikey = "a6dca837e76926839490848ddddbd713";


  showWeather() async{
    String url = "http://api.openweathermap.org/data/2.5/weather?q=$cityName,$countryName&units=metric&appid="+apikey;
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var items = jsonDecode(response.body);
      
      setState((){
        degree = (items["main"]["temp"]).round().toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // For Country Name
                TextField(
                  onChanged: (val){
                    countryName = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Country Name"
                  ),
                ),
                 const SizedBox(height: 20),
              //  For City Name
               TextField(
                  onChanged: (val){
                    cityName = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "City Name"
                  ),
                ),
 const SizedBox(height: 20),
                MaterialButton(
                  height: 50,
                  color: const Color(0xFF0000FF),
                  child: const Text('Show Weather', style: TextStyle(fontSize: 21, color: Colors.white)),
                  onPressed: (){
                    showWeather();
                  },
                ),
                const SizedBox(height: 50),
                Text('Its $degree degree Celsius.', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold))
                ,const SizedBox(height: 50),
                const Text('#FLUTTERWITHBRP.', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}