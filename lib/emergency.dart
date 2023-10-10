import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Emergency(),
    );
  }
}

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  File? image;
  double _latitude = 0;
  double _longitude = 0;

  TextEditingController _controllerNameSurname = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();
  TextEditingController _controllerExplain = TextEditingController();

  String _selectedFireType = 'Forest Fire';
  String _selectedSeverity = 'Mild';

  List<String> fireTypes = [
    'Forest Fire',
    'Building Fire',
    'Vehicle Fire',
  ];

  Future pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void ClearScreen() {
    _controllerExplain.clear();
    _controllerNameSurname.clear();
    _controllerPhoneNumber.clear();
    _latitude = 0;
    _longitude = 0;
    image = null;
    setState(() {});
  }




Future phone() async {
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
    }

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: image == null
                  ? SingleChildScrollView(child: Image.asset("assets/images/picture1.jpg", fit: BoxFit.cover))
                  : SingleChildScrollView(child: Image.file(image!, fit: BoxFit.cover)),
            ),
            height: 200,
            width: 400,
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      fixedSize: Size(400, 45),
                      foregroundColor: Colors.white,
                      shape: StadiumBorder()),
                  onPressed: () async {
                    pickImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          color: Colors.white, size: 30),
                      Text("Take Photo",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                _MySpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.pink,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        await _getLocation();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.gps_fixed, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text("Get Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Latitude:    $_latitude"),
                        Text("Longitude: $_longitude"),
                      ],
                    ),
                  ],
                ),
                _MySpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.fireplace_sharp,
                          size: 30,
                          color: Colors.red.shade700,
                        ),
                        SizedBox(width: 10),
                        DropdownButton(
                          underline: Container(),
                          borderRadius: BorderRadius.circular(20),
                          value: _selectedFireType,
                          items: fireTypes
                              .map(
                                (e) =>
                                    DropdownMenuItem(child: Text(e), value: e),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedFireType = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 30,
                          color: Colors.red.shade700,
                        ),
                        SizedBox(width: 10),
                        DropdownButton(
                          underline: Container(),
                          borderRadius: BorderRadius.circular(20),
                          value: _selectedSeverity,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSeverity = newValue!;
                            });
                          },
                          items: <String>['Mild', 'Moderate', 'Severe']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                _MySpace(),
                _TextField(
                    hintText: "Name Surname",
                    keyboardType: TextInputType.text,
                    icon: Icons.person_3,
                    controller: _controllerNameSurname),
                _MySpace(),
                _TextField(
                    hintText: "Phone",
                    keyboardType: TextInputType.phone,
                    icon: Icons.call,
                    controller: _controllerPhoneNumber),
                _MySpace(),
                _TextField(
                    hintText: "Additional explanation",
                    keyboardType: TextInputType.multiline,
                    icon: Icons.info_outline,
                    controller: _controllerExplain),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Send",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () async {
                        ClearScreen();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Your report has been reported to the authorities."),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.red.shade700,
                                      fixedSize: Size(100, 45),
                                      foregroundColor: Colors.white,
                                      shape: StadiumBorder(),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await phone();
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
                      },
                      icon:
                          Icon(Icons.send, color: Colors.blueAccent, size: 30),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
    } catch (e) {}
  }
}

class _MySpace extends StatelessWidget {
  const _MySpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 15);
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        icon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
