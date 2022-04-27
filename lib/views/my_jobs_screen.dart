import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class MyJobsActivity extends StatelessWidget {
  const MyJobsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          appBar: AppBar(
            backgroundColor: Constants.backgroundColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Constants.primaryColor,
                size: 30,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: AppText(
              text: 'My Jobs',
              textSize: 25,
              isBold: true,
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Applied',
                ),
                Tab(
                  text: 'Approved',
                ),
                Tab(
                  text: 'Rejected',
                ),
                Tab(
                  text: 'Waiting',
                ),
              ],
              labelColor: Constants.secondaryColor,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              unselectedLabelColor: Constants.primaryColor,
              isScrollable: true,
            ),
          ),
          body: TabBarView(children: [
            generateExampleListView(size),
            generateExampleListView(size),
            generateExampleListView(size),
            generateExampleListView(size),
          ]),
        ),
      ),
    );
  }

  ListView generateExampleListView(Size size) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {}),
          child: Card(
            elevation: 1,
            child: Container(
              width: size.width,
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(children: <Widget>[
                const CircleAvatar(
                  backgroundImage: AssetImage(Constants.notificationImage),
                  radius: 40,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      text: 'Notification Title',
                      textSize: 18,
                      isBold: true,
                      isStart: true,
                    ),
                    AppText(
                      text: 'April 13,2022',
                      textSize: 16,
                      isBold: true,
                      textColor: Colors.black,
                      isStart: true,
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
