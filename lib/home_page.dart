import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:savefire/data.dart';
import 'package:savefire/emergency.dart';
import 'package:savefire/fireall.dart';
import 'package:savefire/firemap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _nameState();
}

class _nameState extends State<HomePage> {
  ProjeData data = ProjeData();

  int _currentBottomNavigationBarItem = 1;

  PageController _pageController = PageController(initialPage: 1);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showFireNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'fire_notification_channel_id',
      'Fire Notification',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Bildirim kimliği
      'Urgent! There is a Fire Near You',
      'Please move to the safe area.',
      platformChannelSpecifics,
      payload: 'yangin',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentBottomNavigationBarItem,
        color: Colors.black,
        backgroundColor: Colors.white,
        items: [
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: Colors.white),
            child: Icon(
              Icons.emergency_share_outlined,
              color: Colors.white,
            ),
            label: 'Emergency',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.map, color: Colors.white),
            label: 'Fire Map',
          ),
          CurvedNavigationBarItem(
            labelStyle: TextStyle(color: Colors.white),
            child: Icon(Icons.info, color: Colors.white),
            label: 'Fire All',
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 600), curve: Curves.linear);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                showFireNotification();
              },
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/mainlogo.png"),
              ),
            ),
            Text(data.projeTitle),
          ],
        ),
        actions: [
          Center(
            child: IconButton(
                onPressed: () async {
                  try {
                    Uri tel = Uri(
                      scheme: 'tel',
                      path: "112",
                    );
                    if (!await canLaunchUrl(tel)) {
                      print("Phone is calling");
                      await launchUrl(tel);
                    } else {
                      print("Application not found");
                    }
                  } catch (e) {}
                },
                icon: Icon(Icons.fire_truck_outlined)),
          )
        ],
      ),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [Emergency(), FireMap(), FireAll()]),
    );
  }
}

class _AppBarGradient extends StatelessWidget {
  const _AppBarGradient({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color.fromRGBO(3, 13, 35, 100),
            Color.fromRGBO(16, 2, 6, 100),
          ],
        ),
      ),
    );
  }
}

enum Images { picture1 }

extension ImagePath on Images {
  String get assetPath {
    return "assets/images/${this.toString()}.jpg";
  }
}
