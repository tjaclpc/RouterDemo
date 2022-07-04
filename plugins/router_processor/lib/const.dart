 String rootFile = """
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
{0}
class RouterInfo{
  static Widget getWidgetByName(String name,
      {Map<String, String> arguments = const{}}) {
    Widget widget = Container();
    switch (name) {
      {1}
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
      {2}
      default:
        widget = PageNoFound();
        break;
    }
    return widget;
  }

  static String getDlPre(String deeplink) {
    Uri uri = Uri.parse(deeplink);
    if (uri.hasQuery) {
      String dpPrefix = deeplink.substring(
          0, deeplink.length - (uri.query.length + 1));
      return dpPrefix;
    } else {
      return deeplink;
    }
  }

  static String getDlPreUri(Uri uri) {
    if (uri.hasQuery) {
      String deeplink = uri.toString();
      String dpPrefix = deeplink.substring(
          0, deeplink.length - (uri.query.length + 1));
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

""";