import 'package:date_picker/calendar/calendar_controller.dart';
import 'package:date_picker/calendar/calendar_view.dart';
import 'package:date_picker/side_bar/side_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Date Picker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          top(),
          mid(),
          bottom(),
        ],
      ),
    );
  }

  Widget top() {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Basic Calendar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Basic Calendar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Basic Calendar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mid() {
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (CalendarController controller) {
        return Expanded(
          child: Row(
            children: [
              Side(),
              Container(
                width: 1,
                height: double.infinity,
                color: Colors.black.withOpacity(0.1),
              ),
              Expanded(
                child: Container(
                  // height: double.infinity,
                  color: const Color(0xFFF1F4F8),
                  child: Center(
                    child: Calendar(
                      onChanged: (model) {},
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget bottom() {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 32,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Generate"),
        ),
      ),
    );
  }
}
