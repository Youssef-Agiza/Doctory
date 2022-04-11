import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_signup/src/patient_profile.dart';
import 'package:flutter_login_signup/src/doctor_profile.dart';
import 'package:flutter_login_signup/src/admin_profile.dart';
import 'package:flutter_login_signup/src/receptionist_profile.dart';


class which_user extends StatefulWidget {
  which_user({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _which_userState createState() => _which_userState();
}

class _which_userState extends State<which_user> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _Adminbutton() {
    return InkWell(
        onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminProfile()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff7c4dff), Color(0xff7c4dff)])),
      child: Text(
        'Admin',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),);
  }

  Widget _Patientbutton() {

    return InkWell(
        onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PatientProfile()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff7c4dff), Color(0xff7c4dff)])),
      child: Text(
        'Patient',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
    );
  }

  Widget _Doctor() {
    return InkWell(
        onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DoctorProfile()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff7c4dff), Color(0xff7c4dff)])),
      child: Text(
        'Doctor',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ), );
  }
  Widget _resbutton() {

    return InkWell(
        onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ReceptionistProfile()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff7c4dff), Color(0xff7c4dff)])),
      child: Text(
        'Receptionist',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),);
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'What type of user are you?',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff7c4dff)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            height: height,
            child: Stack(children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(height: 20),
                        _Patientbutton(),
                        SizedBox(height: 20),
                        _Doctor(),
                        SizedBox(height: 20),
                        _Adminbutton(),

                      SizedBox(height: 20),
                        _resbutton(),
                      ],
                    ),
                  ))
              ,            Positioned(top: 40, left: 0, child: _backButton()),

            ])));
  }
}
