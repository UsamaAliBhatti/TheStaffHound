// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController scrollController;
  List<Tab> jobDescriptionTabs = <Tab>[
    const Tab(
      text: 'Job Description',
    ),
    const Tab(
      text: 'Company Info',
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    tabController =
        TabController(length: jobDescriptionTabs.length, vsync: this);
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    scrollController.dispose();
  }
}
