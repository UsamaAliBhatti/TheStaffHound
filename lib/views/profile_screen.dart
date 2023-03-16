// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/controllers/profile_controller.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';
import 'package:the_staff_hound/main.dart';

class ProfileActivity extends StatelessWidget {
  var profileController = Get.put(ProfileController());
  ProfileActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Obx(
          () => Visibility(
            visible: profileController.isLoaded.value,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView(
              children: [
                SizedBox(
                  width: size.width,
                  height: 290,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: size.width,
                        height: 290,
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
                            CircleAvatar(
                              backgroundColor: Constants.secondaryColor,
                              radius: 70,
                              child:
                                  Image.asset(Constants.placeholderUserImage),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return AppText(
                                text: profileController
                                    .nameText.value.capitalizeFirstofEach,
                                textColor: Colors.white,
                                textSize: 30,
                                isBold: true,
                              );
                            })
                          ],
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
                          top: 10,
                          left: 15,
                          child: InkWell(
                            onTap: (() {
                              Get.back(result: 'refresh');
                            }),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25,
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppText(
                          text: 'Candidate',
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
                          text: profileController.emailText.value,
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
                          text: profileController.phoneNumberText.value,
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
                          text: profileController
                              .addressText.value.capitalizeFirstofEach,
                          isStart: true,
                          textSize: 18,
                        ),
                      )
                    ],
                  );
                }),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                      text: TextSpan(
                          text: 'Change password? ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tapped');
                                openPasswordUpdateDialog(size);
                              },
                            text: 'CLICK HERE',
                            style: const TextStyle(
                              color: Constants.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ))
                      ])),
                )
              ],
            ),
          ),
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
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
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Constants.secondaryColor,
                    child: Image.asset(Constants.placeholderUserImage),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                  child: Form(
                      key: profileController.profileFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: profileController.nameTextController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Name",
                            ),
                            onSaved: (value) {
                              profileController.nameText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateNameTextField(value!);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              isDense: true,
                            ),
                            enabled: false,
                            readOnly: true,
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
                            enabled: false,
                            readOnly: true,
                            controller:
                                profileController.phoneNumberTextController,
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Phone Number",
                            ),
                            /*    onSaved: (value) {
                              profileController.phoneNumberText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validatePhoneTextField(value!);
                            }, */
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.streetTextController,
                            keyboardType: TextInputType.streetAddress,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Street",
                            ),
                            onSaved: (value) {
                              profileController.streetText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateStreetTextField(value!);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.zipCodeTextController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "ZipCode",
                            ),
                            onSaved: (value) {
                              profileController.zipcodeText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateZipCodeTextField(value!);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.cityTextController,
                            keyboardType: TextInputType.streetAddress,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "City",
                            ),
                            onSaved: (value) {
                              profileController.cityText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateCityTextField(value!);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.stateTextController,
                            keyboardType: TextInputType.streetAddress,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "State",
                            ),
                            onSaved: (value) {
                              profileController.stateText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateStateTextField(value!);
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: profileController.countryTextController,
                            keyboardType: TextInputType.streetAddress,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: "Country",
                            ),
                            onSaved: (value) {
                              profileController.countryText.value = value!;
                            },
                            validator: (value) {
                              return profileController
                                  .validateCountryTextField(value!);
                            },
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
                    profileController.updateMyProfile();
                  },
                  child: AppText(
                    text: "Save",
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

  void openPasswordUpdateDialog(Size size) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 5, bottom: 30),
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Constants.backgroundColor,
          ),
          child: Form(
            key: profileController.resetPasswordFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 50),
                    alignment: Alignment.center,
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey),
                  ),
                  TextFormField(
                    controller: profileController.oldPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter your old password here",
                    ),
                    onSaved: (value) {
                      profileController.oldPasswordController.text = value!;
                    },
                    validator: (value) {
                      return profileController.validateOldPassword(value!);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: profileController.newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      hintText: 'Enter your new passoword here',
                      isDense: true,
                    ),
                    onSaved: (value) {
                      profileController.newPasswordController.text = value!;
                    },
                    validator: (value) {
                      return profileController.validateNewPassword(value!);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: profileController.reenterPasswordTextController,
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Re-Enter your new password here",
                    ),
                    onSaved: (value) {
                      profileController.reenterPasswordTextController.text =
                          value!;
                    },
                    validator: (value) {
                      return profileController.validateReEnterPassword(value!);
                    },
                  ),
                  const SizedBox(
                    height: 40,
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
                      profileController.updatePasswordMethod();
                    },
                    child: AppText(
                      text: "Save",
                      textSize: 20,
                      isBold: true,
                    ),
                  ),
                ],
              ),
            ),
          )),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }
}
