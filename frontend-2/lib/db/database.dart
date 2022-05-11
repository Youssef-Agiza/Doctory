import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_monitoring_system/models/doctorModel.dart';
import 'package:health_monitoring_system/models/paitentModel.dart';
import 'package:health_monitoring_system/models/adminModel.dart';
import 'package:health_monitoring_system/models/receptionistModel.dart';

import 'package:health_monitoring_system/screens/auth/components/registration/admin_registration.dart';

class Database {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('doctor');
  CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');
  CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');
  CollectionReference receptionistCollection =
  FirebaseFirestore.instance.collection('receptionist');

  Future<void> addAdmin(Admins admin) {
    return adminCollection
        .add({
          'Name': admin.adminName,
          'User Name': admin.userName,
          'Contact': admin.contNo,
          'Address': admin.address,
          'Password': admin.password
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }

  Future<void> addPatient(Patients patients) {
    return patientCollection
        .add({
          'Name': patients.name,
          'Birth Date': patients.birthDate,
          'Blood Group': patients.bloodGr,
          'Gender': patients.gender,
          'Government ID': patients.Government_ID,
          'Contact': patients.contNo,
          'Address': patients.address,
          'Password': patients.password
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }

  Future<void> addDoctor(Doctors doctors) {
    return doctorCollection
        .add({
          'Name': doctors.drName,
          'gender': doctors.gender,
          'Government no': doctors.Government_ID,
          'Contact': doctors.contNo,
          'Clini Address': doctors.address,
          'Password': doctors.password
        })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }
  Future<void> addReceptionist(Receptionist receptionist) {
    return receptionistCollection
        .add({
      'Name': receptionist.receptionistName,
      'User Name': receptionist.userName,
      'Contact': receptionist.contNo,
      'Address': receptionist.address,
      'Password': receptionist.password,
      'Birth Date': receptionist.birthDate
    })
        .then((value) => print('User added 12'))
        .catchError((error) => print("ERROR Failed" + error));
  }

}
