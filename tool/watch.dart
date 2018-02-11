// Copyright (c) 2016, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';
import 'package:build_runner/build_runner.dart';
import 'package:build_runner/src/generate/watch_impl.dart' as watch_impl;
import 'package:built_value_generator/built_value_generator.dart';
import 'package:built_redux/generator.dart';
import 'package:source_gen/source_gen.dart';

/// Example of how to use source_gen with [BuiltValueGenerator].
///
/// This script runs a watcher that continuously rebuilds generated source.
///
/// Import the generators you want and pass them to [watch] as shown,
/// specifying which files in which packages you want to run against.
Future main(List<String> args) async {
    await watch_impl.watch([
      new BuildAction(
          new PartBuilder([
            new BuiltValueGenerator(),
            new BuiltReduxGenerator()
          ]),
          'nodebb',
          inputs: const ['lib/models/*.dart', 'lib/actions/*.dart', 'lib/reducers/*.dart'])
    ], deleteFilesByDefault: true, skipBuildScriptCheck: true);
}