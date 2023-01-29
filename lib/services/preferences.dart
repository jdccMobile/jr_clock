import 'package:shared_preferences/shared_preferences.dart';


class Preferences{
  static late SharedPreferences _prefs;

  static String _email = '';
  static bool _isWorking = false;

  static Future initPreferences() async{
    _prefs = await SharedPreferences.getInstance();
  }

  // Email
  static String get email{
    return _prefs.getString('email') ?? '';
  }
  static set email(String email){
    _email = email;
    _prefs.setString('email', _email);
  }

  // Is working
  static bool get isWorking{
    return _prefs.getBool('isWorking') ?? _isWorking;
  }
  static set isWorking(bool isWorking){
    _isWorking = isWorking;
    _prefs.setBool('isWorking', _isWorking);
  }

}