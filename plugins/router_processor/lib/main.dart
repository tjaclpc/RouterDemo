import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';


import 'package:router_processor/cmd_model.dart';
import 'package:router_processor/const.dart';
import 'package:router_processor/step_generate_file.dart';
import 'package:router_processor/step_scan_file.dart';
import 'package:yaml/yaml.dart';

//
String default_generate_name = "route_info.dart";
CmdModel cmdModel = CmdModel();
List<String> excludeStr = ["noFound"];

void main(List<String> args) {
  print("hello");
  //

  if (args.length == 0) {
    return;
  }
  // parse command
  cmdModel = new CmdModel();
  cmdModel.classDataModel = new ClassDataModel();
  //读取输入输出路径
  int index_pi = args.indexOf("-pi");
  if (index_pi != -1) {
    //存在 -pi 指令
    cmdModel.path_in = args[index_pi + 1];
  } else {
    throw Exception("-pi not null");
  }

  int index_po = args.indexOf("-po");
  if (index_po != -1) {
    //存在 -po 指令
    cmdModel.path_out = args[index_po + 1];
  }

  //获取输入路径下所有 添加xroute 注解的类
  scanDartFile(cmdModel.path_in);
  //测试打印扫描到的注解文件，
  // testPrintRouterFileList();
  //构造router数据
  generateRouterClassData();
  //生成 router 文件
  generateRouterFile();
  // print(cmdModel.toString());
}





void testPrintRouterFileList() {
  for (String item in cmdModel.routerFileList) {
    print(item);
  }
}


