import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:build_runner/src/generate/build_impl.dart' as build_impl;
import 'package:source_gen/source_gen.dart';
import 'package:flutter_wills_gen/flutter_wills_gen.dart';

/// Example of how to use source_gen with [BuiltValueGenerator].
///
/// Import the generators you want and pass them to [build] as shown,
/// specifying which files in which packages you want to run against.
Future main(List<String> args) async {
  await build_impl.build([
    new BuildAction(
        new PartBuilder([
          new WillsGenerator()
        ]),
        'nodebb',
        inputs: const ['lib/models/*.dart'])
  ], deleteFilesByDefault: true, skipBuildScriptCheck: true);
}