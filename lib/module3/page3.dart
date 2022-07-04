import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_demo/router/router_annotation.dart';

@XRouter(
    name: "page3",
    deeplink: "demo://www.demo.com/page3?title=?&content=?&ext=?")
class Page3 extends StatefulWidget {
  Map<String, String> arguments;

  Page3(this.arguments);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page3();
  }
}

class _Page3 extends State<Page3> {
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
