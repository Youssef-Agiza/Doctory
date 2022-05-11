class Patients {
  late String name;
  late String  birthDate;
  late String address;
  late String Government_ID;
  late String contNo;
  String gender = 'male';
  String bloodGr = 'A+';
  late String password;


  List<Map<String, dynamic>> getMap() {
    List<Map<String, dynamic>> mapList = [];
    mapList.add({'Name': name});
    mapList.add({'Gender': gender});
    mapList.add({'Blood': bloodGr});
    mapList.add({'Password': password});
    mapList.add({'Birth': birthDate});
    mapList.add({'Address': address});
    mapList.add({'Government ID': Government_ID});
    mapList.add({'Contact': contNo});

    return mapList;
  }
}
