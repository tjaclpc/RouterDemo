import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_demo/router/router_annotation.dart';

@XRouter(
    name: "page1",
    deeplink: "demo://www.demo.com/page1?title=?&content=?&ext=?")
class Page1 extends StatefulWidget {
  Map<String, String> arguments;

  Page1(this.arguments);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page1();
  }
}

class _Page1 extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.arguments["title"] ?? "title"),
      ),
      body: Container(
        child: Center(
          child: Text(widget.arguments["content"] ?? "content"),
        ),
      ),
    );
  }
}
