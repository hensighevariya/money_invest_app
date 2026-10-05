// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(permissionName) =>
      "You have denied the ${permissionName} permission. Please go to device settings to enable ${permissionName} permissions.";

  static String m1(permissionName) =>
      "It looks like ${permissionName} access has been permanently disabled. Please go to your device settings to manually enable ${permissionName} permissions.";

  static String m2(seconds) => "${seconds} seconds";

  static String m3(version) => "v${version} Available!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Security Saas"),
    "cameraPermissionLabel": MessageLookupByLibrary.simpleMessage("Camera"),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "continueButtonLabel": MessageLookupByLibrary.simpleMessage("Continue"),
    "copiedToClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Copied to Clipboard",
    ),
    "dataNotFound": MessageLookupByLibrary.simpleMessage("Data Not Found"),
    "didntReceivedCode": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive code?",
    ),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "enterOtpHint": MessageLookupByLibrary.simpleMessage("Enter OTP"),
    "errorConfirmPasswordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Password and confirm password must be same!",
    ),
    "errorConfirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter confirm password!",
    ),
    "errorEmailAddressInvalidFormat": MessageLookupByLibrary.simpleMessage(
      "Please enter valid email address!",
    ),
    "errorEmailAddressRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter email address!",
    ),
    "errorEmailMobileRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter email address or mobile!",
    ),
    "errorFullNameInvalidFormat": MessageLookupByLibrary.simpleMessage(
      "Name can only contain alphabets and spaces!",
    ),
    "errorFullNameRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter full name!",
    ),
    "errorMobileInvalidFormat": MessageLookupByLibrary.simpleMessage(
      "Please enter valid mobile number!",
    ),
    "errorOtpCodeInvalid": MessageLookupByLibrary.simpleMessage(
      "Please enter valid otp code!",
    ),
    "errorOtpCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter otp code!",
    ),
    "errorPasswordInvalidLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "errorPasswordInvalidPattern": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters, uppercase, lowercase, number and special characters like !@#\$%^&*_,.?’:;",
    ),
    "errorPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter password!",
    ),
    "forgotPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your email or phone number to reset your password",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot Password",
    ),
    "internetErrorDescription": MessageLookupByLibrary.simpleMessage(
      "Looks like you are not connected to internet right now. Please check your internet connection and try again.",
    ),
    "internetErrorTitle": MessageLookupByLibrary.simpleMessage(
      "No Internet Connection!",
    ),
    "languageScreenTitle": MessageLookupByLibrary.simpleMessage("Language"),
    "loginButtonText": MessageLookupByLibrary.simpleMessage("Login"),
    "loginEmailHint": MessageLookupByLibrary.simpleMessage(
      "Mobile Number / Email",
    ),
    "loginForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "loginPasswordHint": MessageLookupByLibrary.simpleMessage("Password"),
    "loginSubtitle": MessageLookupByLibrary.simpleMessage(
      "Login to access your account",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome,"),
    "newPasswordHint": MessageLookupByLibrary.simpleMessage("New Password"),
    "notificationPermissionLabel": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "openSettingsButtonLabel": MessageLookupByLibrary.simpleMessage(
      "Open Settings",
    ),
    "otpVerificationScreenDescriptionEmail":
        MessageLookupByLibrary.simpleMessage(
          "We’ve just sent you a 6 digit code to your email",
        ),
    "otpVerificationScreenDescriptionMobile":
        MessageLookupByLibrary.simpleMessage(
          "We’ve just sent you a 6 digit code to your mobile number",
        ),
    "otpVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "OTP Verification",
    ),
    "otpVerifiedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "OTP verified successfully",
    ),
    "permissionDeniedDescription": m0,
    "permissionDeniedModalTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Denied",
    ),
    "permissionPermanentlyDeniedDescription": m1,
    "photosPermissionLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "profileBankAccount": MessageLookupByLibrary.simpleMessage("Bank Account"),
    "profileChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "profileHelpAndSupport": MessageLookupByLibrary.simpleMessage(
      "Help & Support",
    ),
    "profileLanguage": MessageLookupByLibrary.simpleMessage("Language"),
    "profileLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "profileLogout": MessageLookupByLibrary.simpleMessage("Logout"),
    "profileNotificationSettings": MessageLookupByLibrary.simpleMessage(
      "Notification Settings",
    ),
    "profilePersonalInformation": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "profileReferAndEarn": MessageLookupByLibrary.simpleMessage("Refer & Earn"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendCodeLink": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendIn": MessageLookupByLibrary.simpleMessage("Resend in "),
    "resendTimer": m2,
    "resetPasswordButtonLabel": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "resetPasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Your new password must be unique from those previously used.",
    ),
    "resetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Please enter your new password",
    ),
    "resetPasswordSuccessDescription": MessageLookupByLibrary.simpleMessage(
      "Your password has been updated securely, You can now use your new password to log in.",
    ),
    "resetPasswordSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password Successful",
    ),
    "resetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "searchCountryByNameOrCode": MessageLookupByLibrary.simpleMessage(
      "Search country by name or code",
    ),
    "serverErrorDescription": MessageLookupByLibrary.simpleMessage(
      "We are experiencing some server issues, we apologises for inconvenience. Please try again after few minutes.",
    ),
    "serverErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "splashSubtitle": MessageLookupByLibrary.simpleMessage(
      "Secure Investment. Transparent Trades.\nConsistent Returns.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage(
      "Grow Together\nInvest Smarter",
    ),
    "storagePermissionLabel": MessageLookupByLibrary.simpleMessage("Storage"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "successfullyResentCode": MessageLookupByLibrary.simpleMessage(
      "Successfully resent code!",
    ),
    "timeoutErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Request timeout! Please try again.",
    ),
    "tryAgainButtonLabel": MessageLookupByLibrary.simpleMessage("Try Again"),
    "underMaintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "Our platform is currently under maintenance to bring you a better experience. We\'ll be back shortly - thank you for your patience!",
    ),
    "underMaintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "We\'re Improving Things for You!",
    ),
    "unknownErrorDescription": MessageLookupByLibrary.simpleMessage(
      "It seems we have faced an error. Don\'t worry we will fix it as soon as possible. We\'ll see you in a moment.",
    ),
    "unknownErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "updateAvailableDescription": MessageLookupByLibrary.simpleMessage(
      "We have added lots of new feature and fixed some bugs to make your experience smooth.",
    ),
    "updateAvailableTitle": m3,
    "updateLaterButtonLabel": MessageLookupByLibrary.simpleMessage(
      "Update later",
    ),
    "updateNowButtonLabel": MessageLookupByLibrary.simpleMessage("Update Now"),
    "verifyButtonLabel": MessageLookupByLibrary.simpleMessage("Verify"),
    "whoopsThisInformationIsNotAvailableForAMoment":
        MessageLookupByLibrary.simpleMessage(
          "Whoops ... This information is not available for a moment",
        ),
  };
}
