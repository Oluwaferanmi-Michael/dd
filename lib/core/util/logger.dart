import 'dart:developer' as dev show log;

extension Log on Object {
  void log([String? prefix]) => dev.log('$prefix : ${toString()}');
}