import 'package:flutter/material.dart';

void main() => runApp(prescription());

class prescription extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<prescription> {
  List<DynamicWidget> listDynamic = [];
  List<String> data = [];

  Icon floatingIcon = new Icon(Icons.add);

  addDynamic() {
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);

      data = [];
      listDynamic = [];
    }
    setState(() {});

    listDynamic.add(new DynamicWidget());
  }

  submitData() {
    floatingIcon = new Icon(Icons.arrow_back);
    data = [];
    listDynamic.forEach((widget) => data.add(widget.controller.text));
    setState(() {});
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Flexible(
        flex: 1,
        child: Card(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return Padding(
                padding:EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     Container(
                      margin:EdgeInsets.only(left: 10.0),
                      child: Text("${index + 1} : ${data[index]}"),
                    ),
                     Divider()
                  ],
                ),
              );
            },
          ),
        ));

    Widget dynamicTextField = new Flexible(
      flex: 2,
      child: new ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    Widget submitButton = Container(
      child: RaisedButton(
        onPressed: submitData,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Submit Data'),
        ),
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Appointment'),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              data.length == 0 ? dynamicTextField : result,
              data.length == 0 ? submitButton : Container(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Add Appointment'),
      ),
    );
  }
}
