import 'package:get/get.dart';

class NavModel {
  String? navName;
  String? navIcon;
  RxBool? isNavSelected;

  NavModel({this.navName, this.navIcon, this.isNavSelected});

  get getNavName => navName;

  set setNavName(navName) => navName = navName;

  get getIcon => navIcon;

  set setIcon(icon) => navIcon = icon;

  get getIsSelected => isNavSelected!.value;
  set setIsSelected(isSelected) => isNavSelected!.value = isSelected;
}
