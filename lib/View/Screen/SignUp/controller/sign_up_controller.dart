import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final Rx<Country> selectedCountry = Country(
    phoneCode: '52',
    countryCode: 'MX',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Mexico',
    example: '5512345678',
    displayName: 'Mexico (MX) [+52]',
    displayNameNoCountryCode: 'Mexico (MX)',
    e164Key: '52-MX-0',
  ).obs;

  void pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        selectedCountry.value = country;
      },
    );
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2004, 3, 18),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void submitSignUp() {
    // Handle signup logic and navigate to OTP Verification Screen
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
