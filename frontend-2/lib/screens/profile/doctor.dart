import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../addPatientDetails.dart';

class DoctorHomeScreen extends StatelessWidget {
  String user = "Name";

  DoctorHomeScreen(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome " + user),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Splash_Screen.jpeg",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            child: SafeArea(
              child: myProfile(context),
            ),
          )
        ],
      ),
    );
  }

  Widget myProfile(BuildContext buildContext) {
    return Row(
      children: [
        Container(
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: const Center(
                  child: Text(
                'Profile',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    fontStyle: FontStyle.normal),
              )),
            )),
        Container(
            width: 180,
            height: 180,
            padding: const EdgeInsets.all(20.0),
            // width: 200,
            // height: 200,
            // padding: const EdgeInsets.all(20.0),
            child: GestureDetector(child : Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),

              ),
              child:const Center(child: Text('View Appointments')),

            ) ,)),
      ],
    );
  }
}
