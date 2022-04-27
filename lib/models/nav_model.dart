import 'package:flutter/material.dart';

class NavModel {
  String _navName;
  String _navIcon;

  NavModel(this._navName, this._navIcon);

  get getNavName => _navName;

  set setNavName(navName) => _navName = navName;

  get getIcon => _navIcon;

  set setIcon(icon) => _navIcon = icon;

  
}
