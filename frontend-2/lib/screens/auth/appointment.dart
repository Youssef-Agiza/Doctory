import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getwidget/getwidget.dart';

class AppointmentAdd extends StatefulWidget {
  static const routeName = '/appointAdd';

  @override
  _AppointmentAddState createState() => _AppointmentAddState();
}

class _AppointmentAddState extends State<AppointmentAdd> {
  String dIndex;
  String tIndex;
  List<int> selectedIndexList = [];
  String docImage;
  bool pressed = false;
  List<int> selectedMIndex = [];
  List<int> selectedNIndex = [];
  bool mPressed = false;
  bool nPressed = false;
  final List<String> _mTime = ['9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM'];
  final List<String> _nTime = ['8:00 PM', '8:30 PM', '9:00 PM'];
  final _titleController = TextEditingController();
  bool _validate = false;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final String docName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'User Appointments',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('doctor')
                .where('docName', isEqualTo: docName)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = snapshot.data.docs;
              docImage = chatDocs[0].data()['docimageUrl'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 400,
                    padding: const EdgeInsets.only(top: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GFAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            chatDocs[0].data()['docimageUrl'],
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                chatDocs[0].data()['docSpec'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: const Text(
                                'Choose Your Slot',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              )),
                          Expanded(
                            child: GridView.builder(
                              physics: new NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  top: 5, left: 15, right: 4),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6, childAspectRatio: .6),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Text(
                                      DateFormat.E().format(DateTime.now()
                                          .add(Duration(days: index + 1))),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      height: 50,
                                      width: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          pressed = !pressed;
                                          setState(() {
                                            if (pressed) {
                                              selectedIndexList.clear();
                                              selectedIndexList.add(index);
                                              dIndex = DateFormat.E().format(
                                                  DateTime.now().add(Duration(
                                                      days: index + 1))) +
                                                  ', ' +
                                                  DateFormat.MMM().format(
                                                      DateTime.now().add(
                                                          Duration(
                                                              days:
                                                              index + 1))) +
                                                  ' ' +
                                                  DateFormat.d().format(
                                                      DateTime.now().add(
                                                          Duration(days: index + 1)));
                                              pressed = !pressed;
                                            } else
                                              selectedIndexList.remove(index);
                                          });
                                        },
                                        style: ButtonStyle(
                                            backgroundColor: selectedIndexList
                                                .contains(index)
                                                ? MaterialStateProperty.all(
                                                Colors.indigoAccent)
                                                : MaterialStateProperty.all(
                                                Colors.white)),
                                        child: Text(
                                          DateFormat.d().format(DateTime.now()
                                              .add(Duration(days: index + 1))),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: selectedIndexList
                                                  .contains(index)
                                                  ? Colors.white
                                                  : Colors.indigo),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ]),
                  ),
                  //date 115
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 15, left: 20),
                            child: const Text(
                              'Morning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            )),
                        Expanded(
                          flex: 5,
                          child: GridView.builder(
                            physics: new NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 20),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                          )),
                                      backgroundColor:
                                      selectedMIndex.contains(index) &&
                                          mPressed
                                          ? MaterialStateProperty.all(
                                          Colors.indigoAccent)
                                          : MaterialStateProperty.all(
                                          Colors.white)),
                                  onPressed: () {
                                    mPressed = !mPressed;
                                    nPressed = false;
                                    selectedNIndex.clear();
                                    setState(() {
                                      if (mPressed) {
                                        selectedMIndex.clear();
                                        selectedMIndex.add(index);
                                        tIndex = _mTime[index];
                                      } else
                                        selectedMIndex.remove(index);
                                    });
                                  },
                                  child: Text(
                                    _mTime[index],
                                    style: TextStyle(
                                        color: selectedMIndex.contains(index) &&
                                            mPressed
                                            ? Colors.white
                                            : Colors.indigo),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        //morning 211
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: const Text(
                              'Night',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            )),
                        Expanded(
                          flex: 4,
                          child: GridView.builder(
                            physics: new NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 20),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30.0),
                                          )),
                                      backgroundColor:
                                      selectedNIndex.contains(index) &&
                                          nPressed
                                          ? MaterialStateProperty.all(
                                          Colors.indigoAccent)
                                          : MaterialStateProperty.all(
                                          Colors.white)),
                                  onPressed: () {
                                    nPressed = !nPressed;
                                    mPressed = false;
                                    selectedMIndex.clear();
                                    setState(() {
                                      if (nPressed) {
                                        selectedNIndex.clear();
                                        selectedNIndex.add(index);
                                        tIndex = _nTime[index];
                                      } else
                                        selectedNIndex.remove(index);
                                    });
                                  },
                                  child: Text(
                                    _nTime[index],
                                    style: TextStyle(
                                        color: selectedNIndex.contains(index) &&
                                            nPressed
                                            ? Colors.white
                                            : Colors.indigo),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        //night 281
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 30, right: 30),
                    width: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.greenAccent[400]),
                            ),
                            onPressed: () async {
                              if (dIndex == null && tIndex == null) {
                                confirmationDialog(
                                    context,
                                    FontAwesome5.calendar_times,
                                    Colors.red,
                                    'No Date & Time Slot Selected');
                              } else if (dIndex == null) {
                                confirmationDialog(
                                    context,
                                    FontAwesome5.calendar_times,
                                    Colors.red,
                                    'No Date Slot Selected');
                              } else if (tIndex == null) {
                                confirmationDialog(context, Icons.timer_off,
                                    Colors.red, 'No Time Slot Selected');
                              } else {
                                addAppointDialog(context, docName);
                              }
                            },
                            icon: const Icon(Icons.sanitizer),
                            label: const Text('Book')),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Entypo.cancel),
                            label: const Text('Cancel')),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void addAppointDialog(BuildContext context, String docName) async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              errorText: _validate
                                  ? 'Please enter only valid Username'
                                  : null,
                              labelText:
                              'Enter your Username to confirm Appointment',
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  final enteredTitle = _titleController.text;
                                  if (enteredTitle !=
                                      userData.data()['username']) {
                                    setState(() {
                                      _validate = true;
                                    });
                                  } else {
                                    setState(() {
                                      _validate = false;
                                    });
                                    FirebaseFirestore.instance
                                        .collection('appointments')
                                        .add(({
                                      'appointName':
                                      userData.data()['username'],
                                      'docImg': docImage,
                                      'userId': user.uid,
                                      'appointTime': tIndex,
                                      'appointDate': dIndex,
                                      'appointDoc': docName,
                                    }));
                                    Navigator.of(context).pop();
                                    confirmationDialog(
                                        context,
                                        Icons.timer,
                                        Colors.green[800],
                                        'Appointment Confirmed!!');
                                  }
                                },
                                child: Text('Add Appointment')),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        )
                      ])),
            ),
          );
        });
  }

  void confirmationDialog(
      BuildContext context, IconData icon, Color color, String value) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        icon,
                        size: 60,
                        color: color,
                      ),
                      height: 60,
                    ),
                    Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
