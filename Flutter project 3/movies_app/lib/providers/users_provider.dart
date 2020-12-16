import 'package:flutter/material.dart';
import 'package:movies_app/models/firebase_handler.dart';
import 'package:movies_app/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider with ChangeNotifier {
  Users currentUser;

  Future<void> saveUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('email', currentUser.email);
    preferences.setString('userId', currentUser.userId);
    preferences.setString('idToken', currentUser.idToken);
    preferences.setString('refreshToken', currentUser.refreshToken);
    preferences.setString('expiryDate', currentUser.expiryDate.toString());
  }

  Future<void> removeUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('email');
    preferences.remove('userId');
    preferences.remove('idToken');
    preferences.remove('refreshToken');
    preferences.remove('expiryDate');
  }

  Future<String> register(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.register(email, password);
      await saveUserData();
      return null; // this means that there's no errors ..
    } catch (e) {
      // there are 3 types of errors واحدة منهم مش ممكن ترجع اللي هي رقم 2 ;
      // to print the error message :
      //print(e.response.data['error']['message']);
      String errorCode = e.response.data['error']['message'];
      if (errorCode == 'EMAIL_EXISTS') {
        return 'The email address is already in use by another account';
      } else {
        return 'We have blocked all requests from this device due to unusual activity. Try again later';
      }
    }
  }

  Future<String> logIn(String email, String password) async {
    try {
      currentUser = await FireBaseHandler.instance.logIn(email, password);
      await saveUserData();
      return null; // this means that there's no errors ..
    } catch (e) {
      String errorCode = e.response.data['error']['message'];
      if (errorCode == 'EMAIL_NOT_FOUND') {
        return 'There is no user corresponding to this email. The user may have been deleted.';
      } else if (errorCode == 'INVALID_PASSWORD') {
        return 'The password is invalid.';
      } else {
        return 'The user account has been disabled by an administrator.';
      }
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('idToken')) {
      currentUser = Users.fromPrefrences(preferences);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> refreshTokenIfNecessry() async {
    if (DateTime.now().isAfter(currentUser.expiryDate)) {
      try {
        currentUser = await FireBaseHandler.instance.refreshToken(currentUser);
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return true;
    }
  }
}
