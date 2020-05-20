import 'package:hive/hive.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  String uid;

  User({this.uid});
}