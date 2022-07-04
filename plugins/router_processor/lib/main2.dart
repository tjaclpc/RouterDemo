import 'package:router_processor/cmd_model.dart';

CmdModel cmdModel = CmdModel();

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
  print(cmdModel.toString());
}
