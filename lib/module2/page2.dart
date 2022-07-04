import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_demo/router/router_annotation.dart';

@XRouter2(name: "zzz", deeplink: "vvv")
@XRouter(name: "page2", deeplink: "demo://www.demo.com/page2")
class Page2 extends StatefulWidget {
  Map<String, String> arguments;

  Page2(this.arguments);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Page2();
  }
}

class _Page2 extends State<Page2> {
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
