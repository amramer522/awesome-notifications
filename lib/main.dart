import 'dart:io';

import 'package:awesome_a_notification/MyNotifications.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lolo/lolo.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoLoNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTimerShown = false;
  bool isSelectedTimeShown = false;
  String selectedTime = "";
  var countController = CountDownController();

  @override
  void initState() {
    super.initState();
    LoLoNotifications.listen(context, HomeScreen());
  }

  @override
  void dispose() {
    super.dispose();
    LoLoNotifications.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  LoLoNotifications.notifyNow();
                },
                child: const Text("Notify Now")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // countController.restart();
                    isTimerShown = true;
                    LoLoNotifications.notifyEvery();
                    setState(() {});
                  },
                  child: const Text("Make Interval Alarm"),
                ),
                // StreamBuilder(builder: (context, snapshot) => Text(),stream: Timer.run(() { }),)
                // Text("")
                SizedBox(
                  width: 10,
                ),
                isTimerShown
                    ? CircularCountDownTimer(
                        duration: 60,
                        initialDuration: 0,
                        controller: countController,
                        isReverse: true,
                        autoStart: isTimerShown,
                        fillColor: Colors.transparent,
                        height: 40,
                        width: 40,
                        onComplete: () {
                          isTimerShown = false;
                          setState(() {});
                        },
                        ringColor: Colors.blue,
                      )
                    : SizedBox.shrink()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((value) {
                        if (value != null) {
                          selectedTime = "${value.hour}:${value.minute}";
                          isSelectedTimeShown = true;
                          LoLoNotifications.notifyAtSpecificTime(
                              hour: value.hour, minute: value.minute);
                          setState(() {});
                        }
                      });
                    },
                    child: const Text("Select Time")),
                SizedBox(
                  width: 10,
                ),
                selectedTime.isNotEmpty
                    ? Text(selectedTime)
                    : const SizedBox.shrink(),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  // countController.pause();
                  isTimerShown = false;
                  selectedTime = "";
                  setState(() {});
                  print("cancelAllSchedules");
                  await LoLoNotifications.cancelAllScheduledNotifications();
                },
                child: const Text("Cancel scheduled Alarms")),
          ],
        ),
      ),
    );
  }
}
