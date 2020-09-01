library water_mark;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stamp_water_mark/measure_widget_size.dart';

/// @description: water mark can used in page for security .
/// @author: weichunsheng@jd.com
/// @date: 2020/8/31 11:44 AM
/// @version: 1.0
///
class WaterMark {
  static final WaterMark _singleton = WaterMark._internal();

  factory WaterMark() {
    return _singleton;
  }

  WaterMark._internal();

  WaterMark build() {
    return _singleton;
  }

  WaterMark setMarkText(String inputText) {
    markText = inputText;
    customerWidget = null;
    return _singleton;
  }

  WaterMark setMarkStyle(TextStyle inputStyle) {
    markStyle = inputStyle;
    return _singleton;
  }

  WaterMark setWidget(Widget inputWidget) {
    customerWidget = inputWidget;
    return _singleton;
  }

  OverlayEntry _overlayEntry;
  String markText = 'WaterMark';
  TextStyle markStyle = const TextStyle(
      color: Color(0x08000000), fontSize: 16, decoration: TextDecoration.none);

  /// widget location all screen
  Widget customerWidget;

  /// add water mark
  Future<bool> show(BuildContext context,
      {int rowCount = 4, int columnCount = 10}) async {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }
    OverlayState overlayState = Overlay.of(context);
    if (customerWidget != null) {
      _overlayEntry = OverlayEntry(
          builder: (context) => Opacity(child: customerWidget, opacity: 0.35));
    } else {
      _overlayEntry = OverlayEntry(
          builder: (context) => MarkWidget(
                rowCount: rowCount,
                columnCount: columnCount,
                text: markText,
                textStyle: markStyle,
              ));
    }
    overlayState.insert(_overlayEntry);
    Future.delayed(Duration(seconds: 1), () {});
    return Future.value(true);
  }

  /// remove water mark
  Future<bool> remove() async {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

class MarkWidget extends StatelessWidget {
  const MarkWidget({
    Key key,
    @required this.rowCount,
    @required this.columnCount,
    @required this.text,
    @required this.textStyle,
  }) : super(key: key);

  final int rowCount;
  final int columnCount;
  final String text;
  final TextStyle textStyle;

  //暂时不不用
  //Size screenSize;

  @override
  Widget build(BuildContext context) {
    //screenSize = MediaQuery.of(context).size;
    return IgnorePointer(
      child: Container(
          child: Column(
        children: buildMarkList(),
      )),
    );
  }

  List<Widget> buildItem() {
    List<Widget> list = [];
    for (var i = 0; i < rowCount; i++) {
      final widget = Expanded(
        child: Center(
          child: MeasureSize(
            child: Transform.rotate(
                angle: -pi / 12, child: Text(text, style: textStyle)),
            onChange: (size) {
              //if (screenSize != null && size != null) {
              //todo
              //如果有需要动态计算水印个数，可以通过屏幕宽高，以及单个水印Widget的宽高，
              // 以及水印间距，算出需要展示水印个数,然后动态展示，
              // 别忘了把Widget换成有状态的动态刷新
              //eg:间距为0个数
              //rowCount = (screenSize.width ~/ size.width) ;
              //columnCount = (screenSize.height ~/ size.height);
              //}
            },
          ),
        ),
      );
      list.add(widget);
    }
    return list;
  }

  List<Widget> buildMarkList() {
    List<Widget> list = [];
    for (var i = 0; i < columnCount; i++) {
      final widget = Expanded(
          child: Row(
        children: buildItem(),
      ));
      list.add(widget);
    }
    return list;
  }
}
