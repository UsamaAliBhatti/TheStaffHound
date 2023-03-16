// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:the_staff_hound/constants.dart';
import 'package:the_staff_hound/custom_widgets/app_text.dart';

import '../controllers/signup_controller.dart';

class SignUpActivity extends StatelessWidget {
  var controller = Get.put(SignUpController());

  SignUpActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.backgroundColor,
          elevation: 0,
          leading: InkWell(
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Constants.primaryColor,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            AppText(
              text: 'Create Account',
              textSize: 20,
              isBold: true,
            ),
            const SizedBox(
              height: 20,
            ),
            AppText(
              text: 'Welcome',
              textSize: 25,
              isBold: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppText(
              text: 'its easier to sign up',
              textSize: 18,
            ),
            Obx(() => Stepper(
                physics: const NeverScrollableScrollPhysics(),
                currentStep: controller.currentStep.value,
                onStepTapped: (index) {
                  if (index == 0) {
                    controller.currentStep.value = 0;
                  } else if (index == 1) {
                    var isComplete =
                        controller.formKeys[0].currentState!.validate();
                    if (isComplete) {
                      controller.currentStep.value = 1;
                    } else {
                      Fluttertoast.showToast(
                          msg: 'please complete the first form');
                    }
                  } else if (index == 2) {
                    var isFirstComplete =
                        controller.formKeys[0].currentState!.validate();
                    var isSecondComplete =
                        controller.formKeys[1].currentState!.validate();
                    if (isFirstComplete && isSecondComplete) {
                      controller.currentStep.value = 2;
                    } else {
                      Fluttertoast.showToast(
                          msg: 'please complete the both forms');
                    }
                  } else {
                    controller.currentStep.value = 0;
                  }
                  /* if (index == 1 &&
                      !controller.formKeys[0].currentState!.validate()) {
                    
                  } else if (index == 2 &&
                      (!controller.formKeys[0].currentState!.validate() ||
                          !controller.formKeys[1].currentState!.validate())) {
                    print('Please complete both forms');
                  } else {
                    controller.currentStep.value = index;
                  } */
                },
                steps: accountRegisterFormSteps(),
                type: StepperType.vertical,
                controlsBuilder: (context, _) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (controller.currentStep.value != 0)
                            ? SizedBox(
                                width: 100,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    controller.currentStep.value == 0
                                        ? null
                                        : controller.currentStep.value--;
                                  },
                                  style: TextButton.styleFrom(
                                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                                      backgroundColor:
                                          Constants.buttonBackgroundColor,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25))),
                                  child: AppText(
                                    text: 'Back',
                                    isBold: true,
                                    textSize: 15,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 100,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                if (controller.currentStep.value < 2) {
                                  if (controller
                                      .formKeys[controller.currentStep.value]
                                      .currentState!
                                      .validate()) {
                                    controller.currentStep.value++;
                                  }
                                  // print(controller.currentStep.value);
                                } else {
                                  controller.userSignUpMethod();
                                  /*  if (controller.formKeys[0].currentState!
                                            .validate() &&
                                        controller.formKeys[1].currentState!
                                            .validate()) {
                                      controller.userSignUpMethod();
                                      print(controller.currentStep.value);
                                    } */
                                  /* Get.to(
                                        () => const ForgotPasswordActivity()); */
                                }
                              },
                              style: TextButton.styleFrom(
                                  // padding: const EdgeInsets.symmetric(horizontal: 30),
                                  backgroundColor:
                                      Constants.buttonBackgroundColor,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: AppText(
                                text: (controller.currentStep.value == 2)
                                    ? 'Sign Up'
                                    : 'Next',
                                isBold: true,
                                textSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }))
          ],
        ));
  }

  List<Step> accountRegisterFormSteps() {
    return [
      Step(
          isActive: controller.currentStep.value >= 0,
          title: AppText(
            text: 'Account',
            textSize: 20,
            isBold: true,
          ),
          content: getAccountDetails()),
      Step(
        title: AppText(
          text: 'Address',
          textSize: 20,
          isBold: true,
        ),
        content: getAddressForm(),
        isActive: controller.currentStep.value >= 1,
      ),
      Step(
        title: AppText(
          text: 'Add a Branch',
          textSize: 20,
          isBold: true,
        ),
        content: getBranches(),
        isActive: controller.currentStep.value >= 2,
      ),
    ];
  }

// Account Details Form
  Widget getAccountDetails() {
    return Form(
        key: controller.formKeys[0],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Full Name",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
                prefixIcon: const Icon(
                  Icons.person_rounded,
                  color: Constants.primaryColor,
                ),
              ),
              onSaved: (value) {
                controller.nameController.text = value!;
              },
              validator: (value) {
                return controller.validateName(value);
              },
              keyboardType: TextInputType.emailAddress,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 2.0),
                  ),
                  labelText: "Email",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                  prefixIcon:
                      const Icon(Icons.email, color: Constants.primaryColor)),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Constants.primaryColor,
                fontSize: 18,
              ),
              onSaved: (value) {
                controller.emailController.text = value!;
              },
              validator: (value) {
                return controller.validateEmail(value);
              },
            ),
            const SizedBox(height: 20),
            InternationalPhoneNumberInput(
              textFieldController: controller.phoneContoller,
              onInputChanged: (phoneNumber) {
                // controller.phoneContoller.text = phoneNumber.phoneNumber!;
              },
              onSaved: (value) {
                controller.phoneContoller.text = value.phoneNumber!;
              },
              validator: (value) {
                return controller.validatePhone(value);
              },
              selectorTextStyle: const TextStyle(color: Colors.black),
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Phone Number",
              ),
              selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG),
            ),
            /*  TextFormField(
              onSaved: (value) {
                controller.phoneContoller.text = value!;
              },
              validator: (value) {
                return controller.validatePhone(value);
              },
              controller: controller.phoneContoller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 2.0),
                  ),
                  labelText: "Phone Number",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                  prefixIcon: Image.asset(Constants.ic_phone)),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Constants.primaryColor,
                fontSize: 18,
              ),
            ), */
            const SizedBox(height: 20),
            TextFormField(
              onSaved: (value) {
                controller.passwordController.text = value!;
              },
              validator: (value) {
                return controller.validatePassword(value);
              },
              controller: controller.passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Password",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
                prefixIcon: Image.asset(Constants.passwordIcon),
              ),
              keyboardType: TextInputType.emailAddress,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              onSaved: (value) {
                controller.reEnterPasswordController.text = value!;
              },
              validator: (value) {
                return controller.validateReEnterPassword(value);
              },
              controller: controller.reEnterPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, width: 2.0),
                  ),
                  labelText: "Re-Enter Password",
                  labelStyle: const TextStyle(
                      color: Constants.primaryColor, fontSize: 17),
                  prefixIcon: Image.asset(Constants.passwordIcon)),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Constants.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.isPrivacyPolicyChecked.value =
                        !controller.isPrivacyPolicyChecked.value;
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            // color: /*isChecked ? primaryColor : */Colors.grey,
                            border: Border.all(
                                color: controller.isPrivacyPolicyChecked.value
                                    ? Constants.primaryColor
                                    : Constants.textHintColor),
                            borderRadius: BorderRadius.circular(3.0)),
                        width: 20,
                        height: 20,
                        child: controller.isPrivacyPolicyChecked.value
                            ? const Icon(Icons.check,
                                color: Constants.primaryColor, size: 18)
                            : null,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15),
                        child: Text(
                          'I have read the',
                          style: TextStyle(
                              color: Constants.primaryColor, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'privacy policy',
                            style: TextStyle(
                              color: Constants.secondaryColor,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            /* const SizedBox(
              height: 20,
            ),
            InkWell(
              child: AppButton(
                text: "Sign Up",
                textSize: 20,
                buttonWidth: 250,
              ),
              onTap: () {
                // Get.to(() => DashboardActivity());
                controller.userSignUpMethod();
              },
            ),
            const SizedBox(
              height: 20,
            ),*/
          ],
        ));
  }

  // Address Form
  Widget getAddressForm() {
    return Form(
        key: controller.formKeys[1],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Current Location',
                    style:
                        TextStyle(color: Constants.primaryColor, fontSize: 20),
                  ),
                ),
                /*  InkWell(
                    onTap: () {
                      controller.isCurrentLocationSelected.value =
                          !controller.isCurrentLocationSelected.value;
                    },
                    child: */
                IconButton(
                    splashColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      controller.isCurrentLocationSelected.value =
                          !controller.isCurrentLocationSelected.value;
                      if (controller.isCurrentLocationSelected.value) {
                        await controller.getCurrentLocation();
                      } else {
                        controller.clearAddress();
                      }
                    },
                    icon: controller.isCurrentLocationSelected.isFalse
                        ? Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color:
                                    controller.isCurrentLocationSelected.value
                                        ? Constants.secondaryColor
                                        : Constants.textHintColor,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ))
                        : const Icon(
                            Icons.adjust_sharp,
                            color: Constants.secondaryColor,
                            size: 30,
                          ))
              ],
            ),
            TextFormField(
              controller: controller.streetTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Street",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
              ),
              onSaved: (value) {
                controller.streetTextController.text = value!;
              },
              validator: (value) {
                return controller.validateStreet(value);
              },
              keyboardType: TextInputType.text,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.zipcodeTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Zip Code",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
              ),
              onSaved: (value) {
                controller.zipcodeTextController.text = value!;
              },
              validator: (value) {
                return controller.validateZipCode(value);
              },
              keyboardType: TextInputType.number,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.cityTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "City",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
              ),
              onSaved: (value) {
                controller.cityTextController.text = value!;
              },
              validator: (value) {
                return controller.validateCity(value);
              },
              keyboardType: TextInputType.text,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.stateTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "State",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
              ),
              onSaved: (value) {
                controller.stateTextController.text = value!;
              },
              validator: (value) {
                return controller.validateState(value);
              },
              keyboardType: TextInputType.text,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.countryTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                      color: Constants.primaryColor, width: 2.0),
                ),
                labelText: "Country",
                labelStyle: const TextStyle(
                    color: Constants.primaryColor, fontSize: 17),
              ),
              onSaved: (value) {
                controller.countryTextController.text = value!;
              },
              validator: (value) {
                return controller.validateCountry(value);
              },
              keyboardType: TextInputType.text,
              style:
                  const TextStyle(color: Constants.primaryColor, fontSize: 18),
            ),
          ],
        ));
  }

  // Add a Branch Layout
  getBranches() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MultiSelectDialogField(
            dialogHeight: controller.dropdownItemsList.length * 60,
            items: controller.dropdownItemsList,
            title: AppText(
              text: 'Select Branch',
              isBold: true,
              textSize: 18,
              textColor: Colors.black,
            ),
            selectedColor: Constants.primaryColor,
            buttonText: const Text(
              'Select Branch',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Constants.primaryColor,
                ),
                borderRadius: BorderRadius.circular(30)),
            onConfirm: (values) {
              controller.selectedBranchesList.value = [];
              for (int i = 0; i < values.length; i++) {
                Branch datum = values[i] as Branch;
                controller.selectedBranchesList.add(datum.id);
                print(values);
              }
              print(controller.selectedBranchesList.toJson());
            }),
        /* Expanded(
          child: ListView.builder(
            itemCount: controller.selectedBranchesList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  )
                ],
              );
            },
          ),
        ) */
      ],
    );

    /* DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide:
              const BorderSide(color: Constants.primaryColor, width: 2.0),
        ),
      ),
      hint: AppText(
        text: 'Select your branch',
        textSize: 15,
      ),
      style: const TextStyle(height: 0.0),
      iconSize: 30,
      items: controller.branchModel.data?.map((item) {
        return DropdownMenuItem(
          value: item.id,
          child: AppText(
            text: item.name,
            textColor: Colors.black,
            textSize: 15,
          ),
        );
      }).toList(),
      onChanged: (int? newVal) {
        controller.branchId.value = newVal!;
        print(newVal);
      },
    ); */
  }
}
