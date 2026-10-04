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

  static String m2(version) => "v${version} Available!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("Security Saas"),
    "cameraPermissionLabel": MessageLookupByLibrary.simpleMessage("Camera"),
    "copiedToClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Copied to Clipboard",
    ),
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
    "errorFullNameRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter full name!",
    ),
    "errorOtpCodeInvalid": MessageLookupByLibrary.simpleMessage(
      "Please enter valid otp code!",
    ),
    "errorOtpCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter otp code!",
    ),
    "errorPasswordInvalidPattern": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters, uppercase, lowercase, number and special characters like !@#\$%^&*_,.?’:;",
    ),
    "errorPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter password!",
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
    "notificationPermissionLabel": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "openSettingsButtonLabel": MessageLookupByLibrary.simpleMessage(
      "Open Settings",
    ),
    "permissionDeniedDescription": m0,
    "permissionDeniedModalTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Denied",
    ),
    "permissionPermanentlyDeniedDescription": m1,
    "photosPermissionLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "serverErrorDescription": MessageLookupByLibrary.simpleMessage(
      "We are experiencing some server issues, we apologises for inconvenience. Please try again after few minutes.",
    ),
    "serverErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "splashSubtitle": MessageLookupByLibrary.simpleMessage(
      "Secure Investment. Transparent Trades.\nConsistent Returns.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage(
      "Grow Together\nInvest Smarter",
    ),
    "storagePermissionLabel": MessageLookupByLibrary.simpleMessage("Storage"),
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
    "updateAvailableTitle": m2,
    "updateLaterButtonLabel": MessageLookupByLibrary.simpleMessage(
      "Update later",
    ),
    "updateNowButtonLabel": MessageLookupByLibrary.simpleMessage("Update Now"),
  };
}
