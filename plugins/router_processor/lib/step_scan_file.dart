import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'main.dart';

void scanDartFile(String path) {
  Directory lib = new Directory(path);
  for (FileSystemEntity item in lib.listSync()) {
    final FileStat file = item.statSync();
    if (file.type == FileSystemEntityType.file && item.path.endsWith('.dart')) {
      scanClassHasAnnotation(item.path);
    } else if (file.type == FileSystemEntityType.directory) {
      scanDartFile(item.path);
    }
  }
}

void scanClassHasAnnotation(String item) {
  final CompilationUnit astRoot = parseFile(
    path: item,
    featureSet: FeatureSet.fromEnableFlags(<String>[]), //ClassDeclarationImpl
  ).unit;
  for (CompilationUnitMember unitMember in astRoot.declarations) {
    for (final Annotation metadata in unitMember.metadata) {
      if (metadata is Annotation &&
          metadata.name.name == ("XRouter") &&
          metadata.parent is ClassDeclaration) {
        cmdModel.routerFileList.add(item);
      }
    }
  }
}
