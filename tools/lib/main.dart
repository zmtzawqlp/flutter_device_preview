import 'dart:io';

import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MediaQueryInfo(),
    );
  }
}

class MediaQueryInfo extends StatefulWidget {
  @override
  _MediaQueryInfoState createState() => _MediaQueryInfoState();
}

class _MediaQueryInfoState extends State<MediaQueryInfo> {
  AndroidDeviceInfo _android;
  IosDeviceInfo _ios;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future _init() async {
    final deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid) {

    _android = await deviceInfo.androidInfo;
    }
    else if(Platform.isIOS) {
    _ios = await deviceInfo.iosInfo;
    }
    this.setState(() {});
  }

  List<Widget> get _device {
    if (_android != null) {
      return <Widget>[
        Text("os: android"),
        Text("brand: " + _android.brand),
        Text("device: " + _android.device),
        Text("display: " + _android.display),
        Text("manufacturer: " + _android.manufacturer),
        Text("fingerprint: " + _android.fingerprint),
        Text("version: " + _android.version.toString()),
      ];
    }

    if (_ios != null) {
      return <Widget>[
        Text("os: ios"),
        Text("model: " + _ios.model),
        Text("name: " + _ios.name),
        Text("systemName: " + _ios.systemName),
        Text("systemVersion: " + _ios.systemVersion),
        Text("localizedModel: " + _ios.localizedModel),
      ];
    }

    return <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
            children: _device
              ..addAll([
                Text("devicePixelRatio: ${media.devicePixelRatio}"),
                Text("padding: ${media.padding}"),
                Text("size: ${media.size}"),
                Text("viewInsets: ${media.viewInsets}"),
                Text("textScaleFactor: ${media.textScaleFactor}"),
                Text("platformBrightness: ${media.platformBrightness}"),
                Text("boldText: ${media.boldText}"),
              ])),
      ),
    );
  }
}
