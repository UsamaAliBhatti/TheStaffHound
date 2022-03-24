import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';

import '../controllers/resume_controller.dart';
import '../custom_widgets/app_text.dart';

// ignore: must_be_immutable
class ResumeViewActivity extends StatelessWidget {
  var resumeController = Get.put(ResumeController());
  ResumeViewActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: <Widget>[
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Colors.amber,
                            /* image: DecorationImage(
                                image: FileImage(
                                  File(
                                    resumeController.selectedImagepath.value,
                                  ),
                                ),
                                fit: BoxFit.fill) */
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              AppText(
                                text: 'Usama Ali',
                                textColor: Constants.primaryColor,
                                isBold: true,
                                isStart: true,
                                textSize: 23,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Icon(
                                    Icons.phone,
                                    color: Constants.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText(
                                    text: '0310-4241301',
                                    textSize: 13,
                                    textColor: Colors.black,
                                    isBold: true,
                                    isStart: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.email,
                                    color: Constants.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: AppText(
                                      text: 'usamaali786@gmail.com',
                                      textSize: 13,
                                      textColor: Colors.black,
                                      isBold: true,
                                      isStart: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Icon(
                                    Icons.home,
                                    color: Constants.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: AppText(
                                      text: 'Lahore',
                                      textSize: 13,
                                      textColor: Colors.black,
                                      isBold: true,
                                      isStart: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    Container(
                      width: size.width,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Constants.textHintColor.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          AppText(
                            text: 'About Me ',
                            textColor: Constants.primaryColor,
                            textSize: 20,
                            isBold: true,
                            isStart: true,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Constants.textHintColor.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                        text: 'Education',
                        textColor: Constants.primaryColor,
                        textSize: 20,
                        isBold: true,
                        isStart: true,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Constants.textHintColor.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppText(
                        text: 'Experience',
                        textColor: Constants.primaryColor,
                        textSize: 20,
                        isBold: true,
                        isStart: true,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Constants.textHintColor.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Skills',
                                  textColor: Constants.primaryColor,
                                  textSize: 20,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Languages',
                                  textColor: Constants.primaryColor,
                                  textSize: 20,
                                  isBold: true,
                                  isStart: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              /*  Positioned(
                bottom: 30,
                right: 1,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: 120,
                  height: 60,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => const ResumeViewActivity());
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: 'Save',
                              textSize: 20,
                              isBold: true,
                              textColor: Colors.white,
                            )
                          ]),
                      style: TextButton.styleFrom(
                          backgroundColor: Constants.secondaryColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)))),
                ))
          ],
        ),, */
            ])),
      ),
    );
  }
}
