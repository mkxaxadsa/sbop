import 'package:shared_preferences/shared_preferences.dart';

bool onboard = true;
String userName = '';
String userSurname = '';
String userNickname = '';
String userBirthday = '';
String userImage = '';

Future<void> getData() async {
  final prefs = await SharedPreferences.getInstance();
  // await prefs.remove('onboard');
  onboard = prefs.getBool('onboard') ?? true;
  userName = prefs.getString('userName') ?? '';
  userSurname = prefs.getString('userSurname') ?? '';
  userNickname = prefs.getString('userNickname') ?? '';
  userBirthday = prefs.getString('userBirthday') ?? '';
  userImage = prefs.getString('userImage') ?? '';
}

Future<void> saveData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboard', false);
}

Future<void> saveProfile(
  String name,
  String surname,
  String nickName,
  String birthday,
) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userName', name);
  prefs.setString('userSurname', surname);
  prefs.setString('userNickname', nickName);
  prefs.setString('userBirthday', birthday);
  userName = name;
  userSurname = surname;
  userNickname = nickName;
  userBirthday = birthday;
}

Future<void> saveProfileImage(String image) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('userImage', image);
  userImage = image;
}
