
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_demo/router/router_annotation.dart';

@XRouter(name: "noFound",deeplink: "demo://www.demo.com/noFound")
class PageNoFound extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageNoFound();
  }

}
class _PageNoFound extends State<PageNoFound>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("no"),
      ),
      body: Container(
        child: Center(
          child: Text("no found"),
        ),
      ),
    );
  }

}