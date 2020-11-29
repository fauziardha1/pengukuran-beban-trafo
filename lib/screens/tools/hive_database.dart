import 'package:hive/hive.dart';

class HiveDatabase {
  String boxName = "memory";
  static var box;

  static getBox() async {
    box = await Hive.openBox("memory");
    return box;
  }
}
