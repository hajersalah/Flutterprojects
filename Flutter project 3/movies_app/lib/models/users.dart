import 'package:shared_preferences/shared_preferences.dart';

class Users {
  final String userId, email;
  String idToken, refreshToken;
  DateTime expiryDate;

  Users.fromJson(dynamic json)
      : this.userId = json['localId'],
        this.email = json['email'],
        this.idToken = json['idToken'],
        this.refreshToken = json['refreshToken'],
        this.expiryDate =
            DateTime.now().add(Duration(seconds: int.parse(json['expiresIn'])));

  Users.fromPrefrences(SharedPreferences preferences)
      : this.userId = preferences.get('userId'),
        this.email = preferences.get('email'),
        this.idToken = preferences.get('idToken'),
        this.refreshToken = preferences.get('refreshToken'),
        this.expiryDate = DateTime.parse(preferences.get('expiryDate'));
}
