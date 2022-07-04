class CmdModel {
  String path_in = '';
  String path_out = '';
  List<String> routerFileList = [];
  String appName = '';
  ClassDataModel classDataModel = ClassDataModel();

  @override
  String toString() {
    return 'CmdModel{path_in: $path_in, path_out: $path_out, routerFileList: $routerFileList, appName: $appName, classDataModel: $classDataModel}';
  }
}

class ClassDataModel {
  String importStr = '';
  String className = 'RouteInfo';
  String caseSb = '';
  String caseDlSb = '';


  @override
  String toString() {
    return 'ClassDataModel{importStr: $importStr, className: $className, caseSb: $caseSb, caseDlSb: $caseDlSb}';
  }

  void appendImport(String import) {
    importStr += import;
  }
}
