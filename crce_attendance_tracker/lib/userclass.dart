import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'userclass.g.dart';

@HiveType(typeId: 0)
class User{
  @HiveField(0)
  FirebaseUser user;

  User(this.user);
}