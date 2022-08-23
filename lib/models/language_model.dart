import 'package:get/get.dart';

class LanguageModel {
  String? languageName;
  RxBool? isSelected;

  
  LanguageModel({this.languageName, this.isSelected});
  String? get getLanguageName => languageName;

  set setLanguageName(String? languageName) => this.languageName = languageName;

  get getIsSelected => isSelected;

  set setIsSelected(isSelected) => this.isSelected = isSelected;


}
