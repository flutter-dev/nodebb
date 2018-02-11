import 'dart:async';

import 'package:build_runner/build_runner.dart';
import 'package:build_runner/src/generate/build_impl.dart' as build_impl;
import 'package:built_value_generator/built_value_generator.dart';
import 'package:built_redux/generator.dart';
import 'package:source_gen/source_gen.dart';

/// Example of how to use source_gen with [BuiltValueGenerator].
///
/// Import the generators you want and pass them to [build] as shown,
/// specifying which files in which packages you want to run against.
Future main(List<String> args) async {
  await build_impl.build([
    new BuildAction(
        new PartBuilder([
          new BuiltValueGenerator(),
          new BuiltReduxGenerator()
        ]),
        'nodebb',
        inputs: const ['lib/models/*.dart', 'lib/actions/*.dart', 'lib/reducers/*.dart'])
  ], deleteFilesByDefault: true, skipBuildScriptCheck: true);
}