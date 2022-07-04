

class RouterInfo{



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



}