import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:router_processor/route_info.dart';
import 'package:yaml/yaml.dart';

import 'const.dart';
import 'main.dart';

void generateRouterClassData() {
  //get yaml file
  parseYaml();

  //analysis import
  generateRouterClassDataImport();
  generateRouterClassDataCase();
}

void generateRouterClassDataCase() {
  for (String item in cmdModel.routerFileList) {
    StringBuffer caseSb = new StringBuffer();
    StringBuffer caseDlSb = new StringBuffer();
    final CompilationUnit astRoot = parseFile(
      path: item,
      featureSet: FeatureSet.fromEnableFlags(<String>[]), //ClassDeclarationImpl
    ).unit;
    String curClassName = '';//类名
    bool hasParam = false;//构造器是否含参数
    for (CompilationUnitMember unitMember in astRoot.declarations) {
      for (final Annotation metadata in unitMember.metadata) {
        if (metadata is Annotation &&
            metadata.name.name == ("XRouter") &&
            metadata.parent is ClassDeclaration) {
          NodeList<CompilationUnitMember> units = astRoot.declarations;
          //解析类信息
          for (CompilationUnitMember temp in units) {
            if (temp is ClassDeclarationImpl) {
              if (temp.extendsClause is ExtendsClauseImpl &&
                  temp.extendsClause?.superclass.name.name ==
                      "StatefulWidget") {
                curClassName = temp.name.name.toString();
                for (SyntacticEntity curEntity
                    in temp.extendsClause!.parent!.childEntities) {
                  if (curEntity is ConstructorDeclarationImpl &&
                      curEntity.parameters is FormalParameterListImpl) {
                    if (curEntity.parameters.parameters.isNotEmpty) {
                      hasParam = true;
                    }
                  }
                }
              }
            }
          }
          //解析注解信息
          NodeList<Expression>? nodeList = metadata.arguments?.arguments;
          for (Expression item in nodeList!) {
            if (item is NamedExpressionImpl) {
              if (item.name.toString() == "name:") {
                String name_expression = item.expression.toSource();
                if (name_expression.startsWith("\"")) {
                  name_expression =
                      name_expression.substring(1, name_expression.length - 1);
                }
                if (excludeStr.contains(name_expression)) {
                  break;
                }
                caseSb.writeln("case ${item.expression.toSource()}:");
                caseSb.writeln(
                    " widget = ${curClassName}(${hasParam ? "arguments" : ""});");
                caseSb.writeln("break;");
              }

              if (item.name.toString() == "deeplink:") {
                String deeplink = item.expression.toSource();
                if (deeplink.startsWith("\"")) {
                  deeplink = deeplink.substring(1, deeplink.length - 1);
                }
                Uri uri = Uri.parse(deeplink);
                String dpPreview = "\"" + RouterInfo.getDlPreUri(uri) + "\"";
                caseDlSb.writeln("case ${dpPreview}:");
                caseDlSb.writeln(
                    " widget = ${curClassName}(${hasParam ? "getDlParamUri(uri)" : ""});");
                caseDlSb.writeln("break;");
              }
            }
          }
        }

        cmdModel.classDataModel.caseSb += caseSb.toString();
        cmdModel.classDataModel.caseDlSb += caseDlSb.toString();
      }
    }
  }
}

void generateRouterClassDataImport() {
  for (String item in cmdModel.routerFileList) {
    File tmpFile = new File(item);
    int lib_index = tmpFile.path.lastIndexOf("\\lib\\");
    String relativite_path =
        tmpFile.path.substring(lib_index + 5, tmpFile.path.length);
    String imp = '';
    if (relativite_path.contains("\\")) {
      int path_index = relativite_path.lastIndexOf("\\");
      imp =
          "import 'package:${cmdModel.appName}/${relativite_path.substring(0, path_index)}/${relativite_path.substring(path_index + 1, relativite_path.length)}';\n";
    } else {
      imp = "import 'package:${cmdModel.appName}/${relativite_path}';\n";
    }
    cmdModel.classDataModel.appendImport(imp);
  }
  print("imp----${cmdModel.classDataModel.toString()}");
}

void parseYaml() {
  final String pubspecPath = p.join(
      cmdModel.path_in.substring(0, cmdModel.path_in.length - 4),
      'pubspec.yaml');
  final File pubspec = File(pubspecPath);
  if (!pubspec.existsSync()) {
    print("not found yaml file");
    return;
  }
  YamlMap yamlMap = loadYaml(pubspec.readAsStringSync());
  yamlMap.nodes.forEach((key, value) {
    if (key.toString() == "name") {
      print("appName:$value");
      cmdModel.appName = value.toString();
    }
  });
}

void generateRouterFile() {
  File dstFile;
  if (cmdModel.path_out.isEmpty) {
    dstFile = new File(cmdModel.path_in + "/" + default_generate_name);
  } else {
    if (cmdModel.path_out.endsWith(".dart")) {
      dstFile = new File(cmdModel.path_out);
    } else {
      dstFile = new File(cmdModel.path_out + "/" + default_generate_name);
    }
  }
  if (dstFile.existsSync()) {
    dstFile.deleteSync();
  }
  dstFile.createSync();
  rootFile = rootFile.replaceAll('{0}', cmdModel.classDataModel.importStr);
  rootFile = rootFile.replaceAll('{1}', cmdModel.classDataModel.caseSb);
  rootFile = rootFile.replaceAll('{2}', cmdModel.classDataModel.caseDlSb);

  dstFile.writeAsStringSync(rootFile);
  formatFile(dstFile);
}

final DartFormatter _formatter = DartFormatter(pageWidth: 100);

Future<void> formatFile(File file) async {
  if (file == null) {
    return;
  }

  if (!file.existsSync()) {
    print('format error: ${file!.absolute!.path} doesn\'t exist\n');
    return;
  }

  processRunSync(
    executable: 'flutter',
    arguments: 'format ${file!.absolute?.path}',
    runInShell: true,
  );
}

void processRunSync({
  required String executable,
  required String arguments,
  bool runInShell = false,
}) {
  final ProcessResult result = Process.runSync(
    executable,
    arguments.split(' '),
    runInShell: runInShell,
  );
  if (result.exitCode != 0) {
    throw Exception(result.stderr);
  }
  print('${result.stdout}');
}
