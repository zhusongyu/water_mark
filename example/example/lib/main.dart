import 'package:flutter/material.dart';
import 'package:stamp_water_mark/water_mark.dart';

void main() => runApp(MyApp());
bool isZh = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaterMark Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  var mark = WaterMark();

  void showWaterMark() {
    mark
        .setMarkText(myController.text.isEmpty
            ? isZh
                ? '京东'
                : 'WaterMark'
            : myController.text.toString())
        .setMarkStyle(TextStyle(
            color: Color(0x08000000),
            fontSize: 16,
            decoration: TextDecoration.none))
        .show(context, rowCount: 3);
  }

  void showCustomerWaterMark() {
    mark
        .setWidget(Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 85, top: 240),
              width: 60,
              height: 20,
              child: Image.asset(
                "images/jd_mark_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        )))
        .show(context);
  }

  void removeWaterMark() {
    mark.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('WaterMark'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 160,
                height: 200,
                child: Image.network(
                  'https://picsum.photos/250?image=9',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: isZh ? '输入水印文字' : 'Please Input Mark Text'),
                    controller: myController,
                  )),
              FlatButton.icon(
                  onPressed: showWaterMark,
                  icon: Icon(Icons.branding_watermark),
                  label: Text(isZh ? '生成水印' : 'Show Mark')),
              FlatButton.icon(
                  onPressed: showCustomerWaterMark,
                  icon: Icon(Icons.widgets),
                  label: Text(isZh ? '自定义水印' : 'Customer Widget Mark')),
              FlatButton.icon(
                  onPressed: removeWaterMark,
                  icon: Icon(Icons.restore_from_trash),
                  label: Text(isZh ? '移除水印' : 'Remove Mark')),
              _testWidget()
            ],
          ),
        ));
  }
}

class _testWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _testWidgetState();
  }
}

class _testWidgetState extends State<_testWidget> {
  var mark = WaterMark();

  void showWaterMark() {
    mark
        .setMarkStyle(TextStyle(
            color: Color(0x08000000),
            fontSize: 16,
            decoration: TextDecoration.none))
        .show(context, rowCount: 3, insets: EdgeInsets.only(top: 200));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FlatButton(
        child: Text('data'),
        onPressed: () {
          mark.setMarkText('inputText').show(context, insets: EdgeInsets.only(top: 200));
          // showWaterMark();
        },
      ),
    );
  }
}
