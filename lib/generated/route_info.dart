import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:router_demo/module1/page1.dart';
import 'package:router_demo/module2/page2.dart';
import 'package:router_demo/module3/page3.dart';
import 'package:router_demo/nofound/no_found.dart';
import 'package:router_demo/ofound/no_found.dart';

class RouterInfo {
  static Widget getWidgetByName(String name,
      {Map<String, String> arguments = const {}}) {
    Widget widget = Container();
    switch (name) {
      case "page1":
        widget = Page1(arguments);
        break;
      case "page2":
        widget = Page2(arguments);
        break;
      case "page3":
        widget = Page3(arguments);
        break;
      case "oFound":
        widget = PageOFound();
        break;

      default:
        widget = PageNoFound();
        break;
    }
    return widget;
  }

  static Widget getWidgetByDl(String deeplink) {
    Uri uri = Uri.parse(deeplink);
    Widget widget = Container();
    String dpPreview = getDlPreUri(uri);

    switch (dpPreview) {
      case "demo://www.demo.com/page1":
        widget = Page1(getDlParamUri(uri));
        break;
      case "demo://www.demo.com/page2":
        widget = Page2(getDlParamUri(uri));
        break;
      case "demo://www.demo.com/page3":
        widget = Page3(getDlParamUri(uri));
        break;
      case "demo://www.demo.com/oFound":
        widget = PageOFound();
        break;

      default:
        widget = PageNoFound();
        break;
    }
    return widget;
  }

  static String getDlPre(String deeplink) {
    Uri uri = Uri.parse(deeplink);
    if (uri.hasQuery) {
      String dpPrefix =
          deeplink.substring(0, deeplink.length - (uri.query.length + 1));
      return dpPrefix;
    } else {
      return deeplink;
    }
  }

  static String getDlPreUri(Uri uri) {
    if (uri.hasQuery) {
      String deeplink = uri.toString();
      String dpPrefix =
          deeplink.substring(0, deeplink.length - (uri.query.length + 1));
      return dpPrefix;
    } else {
      return uri.toString();
    }
  }

  static Map<String, String> getDlParam(String deeplink) {
    Uri uri = Uri.parse(deeplink);
    if (uri.hasQuery) {
      return uri.queryParameters;
    } else {
      return Map();
    }
  }

  static Map<String, String> getDlParamUri(Uri uri) {
    if (uri.hasQuery) {
      return uri.queryParameters;
    } else {
      return Map();
    }
  }
}
