import 'package:flutter/material.dart';
import 'package:aws_interop/aws_sdk.dart' as aws;
import 'dart:async';
import 'package:html/dom.dart' as dom;
import 'package:js/js.dart';
import 'package:jsifier/jsifier.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:stripe_js/stripe_js.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    var uploadButton = new Container(
        width: double.infinity, height: 70.0,
        padding: const EdgeInsets.all(0.0),
        child: new RaisedButton(
            child: const Text("アップロードボタン"),
            onPressed: buttonPressed
        )
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: uploadButton

      ),
    );
  }
}

  void buttonPressed(){

  }

Future upload() async {
  var accessKey = '';
  var secretKey = '';
  var region = '';
  var bucketName = '';

  aws.config.credentials = new aws.Credentials(accessKey, secretKey);
  aws.config.region = region;

  var params = {'Bucket': bucketName, 'Key': ''};
  var options = {'params': params};
  var bucket = new aws.S3(options);
//  var uploadFileBtn = querySelector('#uploadFileBtn');
//  var uploadFileBtn =

  uploadFileBtn.onClick.listen((evt) async {
    var request = new aws.PutObjectRequest();
    request.Body = await getFileBody();
    request.Key = "sample.txt";
    request.Bucket = bucketName;
    bucket.putObject(request, allowInterop((err, data) {
      print('error: $err');
      print('data: $data');
    }));
//    bucket.putObject(request, callback)
  });
}

Future<List<int>> getFileBody() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Movies/flutter_test';
  await new Directory(dirPath).create(recursive: true);
  final String filePath = '$dirPath/${timestamp()}.mp4';

}