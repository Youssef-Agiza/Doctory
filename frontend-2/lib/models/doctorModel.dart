class Doctors {
  late String drName;
  late String address;
  late String Government_ID;
  late String contNo;
  late String gender = 'male';
  late String password;
  late String Birthdate;

  List<Map<String, dynamic>> getMap() {
    List<Map<String, dynamic>> mapList = [];
    mapList.add({'FName': drName});
    mapList.add({'Gender': gender});
    mapList.add({'Address': address});
    mapList.add({'Government ID': Government_ID});
    mapList.add({'Birthdate': Birthdate});
    mapList.add({'Contact': contNo});

    return mapList;
  }
}
