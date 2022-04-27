import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: ListView(
          children: [
            SizedBox(
              width: size.width,
              height: 290,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: size.width,
                      height: 270,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Constants.primaryColor.withOpacity(1.0),
                          Constants.secondaryColor.withOpacity(1.0)
                        ],
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Constants.secondaryColor,
                            radius: 70,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppText(
                            text: 'Usama Ali',
                            textColor: Colors.white,
                            textSize: 30,
                            isBold: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 10,
                      child: IconButton(
                          onPressed: () {
                            openProfileDialog(size);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 30,
                            color: Colors.white,
                          ))),
                  Positioned(
                      bottom: 2,
                      child: InkWell(
                        onTap: (() {
                          Get.back();
                        }),
                        child: Container(
                          width: size.width / 2,
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              AppText(
                                text: 'Back to home',
                                textSize: 16,
                                textColor: Colors.white,
                                isBold: true,
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppText(
                    text: 'Account Info',
                    textSize: 30,
                    isBold: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Constants.secondaryColor,
                    child: Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: AppText(
                    text: 'Email',
                    textSize: 20,
                    isBold: true,
                    isStart: true,
                  ),
                  subtitle: AppText(
                    text: 'usamaali185.ua@gmail.com',
                    isStart: true,
                    textSize: 18,
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Constants.secondaryColor,
                    child: Icon(
                      Icons.phone_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: AppText(
                    text: 'Phone Number',
                    textSize: 20,
                    isBold: true,
                    isStart: true,
                  ),
                  subtitle: AppText(
                    text: '0310-4241301',
                    isStart: true,
                    textSize: 18,
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Constants.secondaryColor,
                    child: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  title: AppText(
                    text: 'Address',
                    textSize: 20,
                    isBold: true,
                    isStart: true,
                  ),
                  subtitle: AppText(
                    text: 'Lahore',
                    isStart: true,
                    textSize: 18,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// Profile Dialog
  void openProfileDialog(Size size) {
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 5, bottom: 30),
          width: size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Constants.backgroundColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 50),
                  alignment: Alignment.center,
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey),
                ),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: Constants.secondaryColor,
                      ),
                      Positioned(
                          bottom: 2,
                          right: 0.5,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Colors.red),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter your name",
                        ),
                        /*  controller: companyNameController,
                          onSaved: (value) {
                            companyNameText.value = value!;
                          },
                          validator: (value) {
                            return validateCompanyNameTextField(value!);
                          }, */
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter your email",
                        ),
                        /*  controller: companyNameController,
                          onSaved: (value) {
                            companyNameText.value = value!;
                          },
                          validator: (value) {
                            return validateCompanyNameTextField(value!);
                          }, */
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter your phone number",
                        ),
                        /*  controller: companyNameController,
                          onSaved: (value) {
                            companyNameText.value = value!;
                          },
                          validator: (value) {
                            return validateCompanyNameTextField(value!);
                          }, */
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Enter your address",
                        ),
                        /*  controller: companyNameController,
                          onSaved: (value) {
                            companyNameText.value = value!;
                          },
                          validator: (value) {
                            return validateCompanyNameTextField(value!);
                          }, */
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        Constants.buttonBackgroundColor),
                    elevation: MaterialStateProperty.all(2),
                    fixedSize: MaterialStateProperty.all(const Size(150, 60)),
                    shadowColor: MaterialStateProperty.all(Colors.grey),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: AppText(
                    text: "Save".toUpperCase(),
                    textSize: 20,
                    isBold: true,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        enterBottomSheetDuration: const Duration(milliseconds: 500),
        exitBottomSheetDuration: const Duration(milliseconds: 500));
  }
}
