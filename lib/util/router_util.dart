import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_demo/util/route_info.dart';

class RouterUtil {
  static void pushPage(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  static void pushName(BuildContext context, String name) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RouterInfo.getWidgetByName(name)));
  }

  static void pushDeeplink(BuildContext context, String deeplink) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RouterInfo.getWidgetByDl(deeplink)));
  }
}
