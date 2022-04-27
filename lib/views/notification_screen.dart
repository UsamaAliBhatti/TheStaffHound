import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class NotificationsActivity extends StatelessWidget {
  const NotificationsActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 25,
          height: 25,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Constants.primaryColor,
              )),
        ),
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        title: AppText(
          text: 'The Staff Hound',
          textSize: 20,
          isBold: true,
          textColor: Constants.secondaryColor,
        ),
        titleSpacing: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
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
                        backgroundImage:
                            AssetImage(Constants.notificationImage),
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
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
