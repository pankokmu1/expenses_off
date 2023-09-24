import 'dart:convert';
import 'dart:io';

T fixture<T>(String name) =>
    json.decode(File('test/fixtures/$name').readAsStringSync()) as T;
