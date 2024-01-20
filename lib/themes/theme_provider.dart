import 'package:chatapp/themes/dark_mode.dart';
import 'package:chatapp/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier{

  //initial theme
   ThemeData _currentTheme=lightMode;

  //getter

  ThemeData get currentTheme=>_currentTheme;

  //setter
  set currentTheme(ThemeData newTheme){
    _currentTheme=newTheme;
    notifyListeners();
  }

  //isdark mode 
  bool get isDarkMode=>_currentTheme==darkMode;

//toggle theme to change the theme
  void toggleTheme(){
    if(_currentTheme==lightMode){
      currentTheme=darkMode;
    }else{
      currentTheme=lightMode;
    }
   
  }

}