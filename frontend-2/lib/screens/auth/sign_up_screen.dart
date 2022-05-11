import 'package:health_monitoring_system/constants.dart';
import 'package:health_monitoring_system/models/doctorModel.dart';
import 'package:health_monitoring_system/models/adminModel.dart';
import 'package:health_monitoring_system/models/paitentModel.dart';
import 'package:health_monitoring_system/models/receptionistModel.dart';
import 'package:health_monitoring_system/screens/auth/components/registration/doctor_registration.dart';
import 'package:health_monitoring_system/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'components/registration/admin_registration.dart';
import 'components/registration/receptionist_registration.dart';

import 'components/registration/patient_registration.dart';
import 'package:health_monitoring_system/db/database.dart';

class SignUpScreen extends StatelessWidget {
  // It's time to validate the text field
  final Database _db = Database();
  final Doctors _doctors = Doctors();
  final Patients _patients = Patients();
  final Admins _admin = Admins();
  final Receptionist _receptionist = Receptionist();
  final _formKey = GlobalKey<FormState>();


  int user = 1;

  SignUpScreen(this.user, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [

          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              )),
                          child: const Text(
                            "Sign In!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    if (user == 0)
                      PatientRegistration(formKey: _formKey, patients: _patients),
                    if (user == 1)
                      DoctorRegistration(formKey: _formKey, doctors: _doctors),

                    if (user == 2) adminRegristration(formKey: _formKey, admins: _admin),

                    if (user == 3) receptionistRegristration(formKey: _formKey, receptionist: _receptionist),


                    const SizedBox(height: defaultPadding * 2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            _formKey.currentState!.save();
                            if (user == 0) {
                              _db.addPatient(_patients);
                            }
                            if (user == 1) {
                              _db.addDoctor(_doctors);
                            }
                            if(user == 2){
                              _db.addAdmin(_admin);
                            }
                            if(user == 3){
                              _db.addReceptionist(_receptionist);
                            }
                          }
                        },
                        child: const Text("Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
