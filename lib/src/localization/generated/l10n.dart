// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Security Saas`
  String get appName {
    return Intl.message('Security Saas', name: 'appName', desc: '', args: []);
  }

  /// `It seems we have faced an error. Don't worry we will fix it as soon as possible. We'll see you in a moment.`
  String get unknownErrorDescription {
    return Intl.message(
      'It seems we have faced an error. Don\'t worry we will fix it as soon as possible. We\'ll see you in a moment.',
      name: 'unknownErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get unknownErrorTitle {
    return Intl.message(
      'Something went wrong!',
      name: 'unknownErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Request timeout! Please try again.`
  String get timeoutErrorMessage {
    return Intl.message(
      'Request timeout! Please try again.',
      name: 'timeoutErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `We are experiencing some server issues, we apologises for inconvenience. Please try again after few minutes.`
  String get serverErrorDescription {
    return Intl.message(
      'We are experiencing some server issues, we apologises for inconvenience. Please try again after few minutes.',
      name: 'serverErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Looks like you are not connected to internet right now. Please check your internet connection and try again.`
  String get internetErrorDescription {
    return Intl.message(
      'Looks like you are not connected to internet right now. Please check your internet connection and try again.',
      name: 'internetErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get permissionDeniedModalTitle {
    return Intl.message(
      'Permission Denied',
      name: 'permissionDeniedModalTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have denied the {permissionName} permission. Please go to device settings to enable {permissionName} permissions.`
  String permissionDeniedDescription(Object permissionName) {
    return Intl.message(
      'You have denied the $permissionName permission. Please go to device settings to enable $permissionName permissions.',
      name: 'permissionDeniedDescription',
      desc: '',
      args: [permissionName],
    );
  }

  /// `Open Settings`
  String get openSettingsButtonLabel {
    return Intl.message(
      'Open Settings',
      name: 'openSettingsButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `It looks like {permissionName} access has been permanently disabled. Please go to your device settings to manually enable {permissionName} permissions.`
  String permissionPermanentlyDeniedDescription(Object permissionName) {
    return Intl.message(
      'It looks like $permissionName access has been permanently disabled. Please go to your device settings to manually enable $permissionName permissions.',
      name: 'permissionPermanentlyDeniedDescription',
      desc: '',
      args: [permissionName],
    );
  }

  /// `Camera`
  String get cameraPermissionLabel {
    return Intl.message(
      'Camera',
      name: 'cameraPermissionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Storage`
  String get storagePermissionLabel {
    return Intl.message(
      'Storage',
      name: 'storagePermissionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photosPermissionLabel {
    return Intl.message(
      'Photos',
      name: 'photosPermissionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notificationPermissionLabel {
    return Intl.message(
      'Notification',
      name: 'notificationPermissionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Copied to Clipboard`
  String get copiedToClipboardHint {
    return Intl.message(
      'Copied to Clipboard',
      name: 'copiedToClipboardHint',
      desc: '',
      args: [],
    );
  }

  /// `We're Improving Things for You!`
  String get underMaintenanceTitle {
    return Intl.message(
      'We\'re Improving Things for You!',
      name: 'underMaintenanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Our platform is currently under maintenance to bring you a better experience. We'll be back shortly - thank you for your patience!`
  String get underMaintenanceDescription {
    return Intl.message(
      'Our platform is currently under maintenance to bring you a better experience. We\'ll be back shortly - thank you for your patience!',
      name: 'underMaintenanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `We have added lots of new feature and fixed some bugs to make your experience smooth.`
  String get updateAvailableDescription {
    return Intl.message(
      'We have added lots of new feature and fixed some bugs to make your experience smooth.',
      name: 'updateAvailableDescription',
      desc: '',
      args: [],
    );
  }

  /// `Update later`
  String get updateLaterButtonLabel {
    return Intl.message(
      'Update later',
      name: 'updateLaterButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get updateNowButtonLabel {
    return Intl.message(
      'Update Now',
      name: 'updateNowButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageScreenTitle {
    return Intl.message(
      'Language',
      name: 'languageScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `v{version} Available!`
  String updateAvailableTitle(Object version) {
    return Intl.message(
      'v$version Available!',
      name: 'updateAvailableTitle',
      desc: '',
      args: [version],
    );
  }

  /// `Please enter email address!`
  String get errorEmailAddressRequired {
    return Intl.message(
      'Please enter email address!',
      name: 'errorEmailAddressRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email address!`
  String get errorEmailAddressInvalidFormat {
    return Intl.message(
      'Please enter valid email address!',
      name: 'errorEmailAddressInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainButtonLabel {
    return Intl.message(
      'Try Again',
      name: 'tryAgainButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong!`
  String get serverErrorTitle {
    return Intl.message(
      'Something went wrong!',
      name: 'serverErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection!`
  String get internetErrorTitle {
    return Intl.message(
      'No Internet Connection!',
      name: 'internetErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter full name!`
  String get errorFullNameRequired {
    return Intl.message(
      'Please enter full name!',
      name: 'errorFullNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter otp code!`
  String get errorOtpCodeRequired {
    return Intl.message(
      'Please enter otp code!',
      name: 'errorOtpCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid otp code!`
  String get errorOtpCodeInvalid {
    return Intl.message(
      'Please enter valid otp code!',
      name: 'errorOtpCodeInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password!`
  String get errorPasswordRequired {
    return Intl.message(
      'Please enter password!',
      name: 'errorPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters, uppercase, lowercase, number and special characters like !@#$%^&*_,.?’:;`
  String get errorPasswordInvalidPattern {
    return Intl.message(
      'Password must be at least 8 characters, uppercase, lowercase, number and special characters like !@#\$%^&*_,.?’:;',
      name: 'errorPasswordInvalidPattern',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password!`
  String get errorConfirmPasswordRequired {
    return Intl.message(
      'Please enter confirm password!',
      name: 'errorConfirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password and confirm password must be same!`
  String get errorConfirmPasswordNotMatch {
    return Intl.message(
      'Password and confirm password must be same!',
      name: 'errorConfirmPasswordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Grow Together\nInvest Smarter`
  String get splashTitle {
    return Intl.message(
      'Grow Together\nInvest Smarter',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `Secure Investment. Transparent Trades.\nConsistent Returns.`
  String get splashSubtitle {
    return Intl.message(
      'Secure Investment. Transparent Trades.\nConsistent Returns.',
      name: 'splashSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome,`
  String get loginTitle {
    return Intl.message('Welcome,', name: 'loginTitle', desc: '', args: []);
  }

  /// `Login to access your account`
  String get loginSubtitle {
    return Intl.message(
      'Login to access your account',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number / Email`
  String get loginEmailHint {
    return Intl.message(
      'Mobile Number / Email',
      name: 'loginEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPasswordHint {
    return Intl.message(
      'Password',
      name: 'loginPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get loginForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'loginForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message('Login', name: 'loginButtonText', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or phone number to reset your password`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your email or phone number to reset your password',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButtonLabel {
    return Intl.message(
      'Continue',
      name: 'continueButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerificationTitle {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOtpHint {
    return Intl.message('Enter OTP', name: 'enterOtpHint', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Verify`
  String get verifyButtonLabel {
    return Intl.message(
      'Verify',
      name: 'verifyButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get resetPasswordSubtitle {
    return Intl.message(
      'Please enter your new password',
      name: 'resetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordHint {
    return Intl.message(
      'New Password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButtonLabel {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `Data Not Found`
  String get dataNotFound {
    return Intl.message(
      'Data Not Found',
      name: 'dataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Whoops ... This information is not available for a moment`
  String get whoopsThisInformationIsNotAvailableForAMoment {
    return Intl.message(
      'Whoops ... This information is not available for a moment',
      name: 'whoopsThisInformationIsNotAvailableForAMoment',
      desc: '',
      args: [],
    );
  }

  /// `Search country by name or code`
  String get searchCountryByNameOrCode {
    return Intl.message(
      'Search country by name or code',
      name: 'searchCountryByNameOrCode',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get errorPasswordInvalidLength {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'errorPasswordInvalidLength',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid mobile number!`
  String get errorMobileInvalidFormat {
    return Intl.message(
      'Please enter valid mobile number!',
      name: 'errorMobileInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email address or mobile!`
  String get errorEmailMobileRequired {
    return Intl.message(
      'Please enter email address or mobile!',
      name: 'errorEmailMobileRequired',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password Successful`
  String get resetPasswordSuccessTitle {
    return Intl.message(
      'Reset Password Successful',
      name: 'resetPasswordSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been updated securely, You can now use your new password to log in.`
  String get resetPasswordSuccessDescription {
    return Intl.message(
      'Your password has been updated securely, You can now use your new password to log in.',
      name: 'resetPasswordSuccessDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be unique from those previously used.`
  String get resetPasswordDesc {
    return Intl.message(
      'Your new password must be unique from those previously used.',
      name: 'resetPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `We’ve just sent you a 6 digit code to your email`
  String get otpVerificationScreenDescriptionEmail {
    return Intl.message(
      'We’ve just sent you a 6 digit code to your email',
      name: 'otpVerificationScreenDescriptionEmail',
      desc: '',
      args: [],
    );
  }

  /// `We’ve just sent you a 6 digit code to your mobile number`
  String get otpVerificationScreenDescriptionMobile {
    return Intl.message(
      'We’ve just sent you a 6 digit code to your mobile number',
      name: 'otpVerificationScreenDescriptionMobile',
      desc: '',
      args: [],
    );
  }

  /// `OTP verified successfully`
  String get otpVerifiedSuccessfully {
    return Intl.message(
      'OTP verified successfully',
      name: 'otpVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive code?`
  String get didntReceivedCode {
    return Intl.message(
      'Didn’t receive code?',
      name: 'didntReceivedCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend in `
  String get resendIn {
    return Intl.message('Resend in ', name: 'resendIn', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCodeLink {
    return Intl.message(
      'Resend Code',
      name: 'resendCodeLink',
      desc: '',
      args: [],
    );
  }

  /// `{seconds} seconds`
  String resendTimer(Object seconds) {
    return Intl.message(
      '$seconds seconds',
      name: 'resendTimer',
      desc: '',
      args: [seconds],
    );
  }

  /// `Successfully resent code!`
  String get successfullyResentCode {
    return Intl.message(
      'Successfully resent code!',
      name: 'successfullyResentCode',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Name can only contain alphabets and spaces!`
  String get errorFullNameInvalidFormat {
    return Intl.message(
      'Name can only contain alphabets and spaces!',
      name: 'errorFullNameInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Personal Information`
  String get profilePersonalInformation {
    return Intl.message(
      'Personal Information',
      name: 'profilePersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get profileBankAccount {
    return Intl.message(
      'Bank Account',
      name: 'profileBankAccount',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get profileChangePassword {
    return Intl.message(
      'Change Password',
      name: 'profileChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get profileNotificationSettings {
    return Intl.message(
      'Notification Settings',
      name: 'profileNotificationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get profileLanguage {
    return Intl.message(
      'Language',
      name: 'profileLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get profileLanguageEnglish {
    return Intl.message(
      'English',
      name: 'profileLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Refer & Earn`
  String get profileReferAndEarn {
    return Intl.message(
      'Refer & Earn',
      name: 'profileReferAndEarn',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get profileHelpAndSupport {
    return Intl.message(
      'Help & Support',
      name: 'profileHelpAndSupport',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get profileLogout {
    return Intl.message('Logout', name: 'profileLogout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logoutDesc {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutDesc',
      desc: '',
      args: [],
    );
  }

  /// `KYC`
  String get profileKyc {
    return Intl.message('KYC', name: 'profileKyc', desc: '', args: []);
  }

  /// `Verified`
  String get profileKycVerified {
    return Intl.message(
      'Verified',
      name: 'profileKycVerified',
      desc: '',
      args: [],
    );
  }

  /// `KYC`
  String get kycTitle {
    return Intl.message('KYC', name: 'kycTitle', desc: '', args: []);
  }

  /// `Proof Of Identity`
  String get kycProofOfIdentity {
    return Intl.message(
      'Proof Of Identity',
      name: 'kycProofOfIdentity',
      desc: '',
      args: [],
    );
  }

  /// `To ensure the safety of all users, a one-time verification is required. The KYC process (Know Your Customer) guarantees that only real individuals and registered institutions can access protected features like event creation, ticket sales, sponsorships, and location rentals.`
  String get kycDescription1 {
    return Intl.message(
      'To ensure the safety of all users, a one-time verification is required. The KYC process (Know Your Customer) guarantees that only real individuals and registered institutions can access protected features like event creation, ticket sales, sponsorships, and location rentals.',
      name: 'kycDescription1',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded documents are reviewed only by authorized admins who are responsible for the verification process. Your data is handled with strict confidentiality and will never be shared with third parties.`
  String get kycDescription2 {
    return Intl.message(
      'Uploaded documents are reviewed only by authorized admins who are responsible for the verification process. Your data is handled with strict confidentiality and will never be shared with third parties.',
      name: 'kycDescription2',
      desc: '',
      args: [],
    );
  }

  /// `This helps protect the community from fake accounts, fraud, and identity misuse.`
  String get kycDescription3 {
    return Intl.message(
      'This helps protect the community from fake accounts, fraud, and identity misuse.',
      name: 'kycDescription3',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Identity Type`
  String get kycChooseIdentityType {
    return Intl.message(
      'Choose Your Identity Type',
      name: 'kycChooseIdentityType',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get kycIdCard {
    return Intl.message('ID Card', name: 'kycIdCard', desc: '', args: []);
  }

  /// `Passport`
  String get kycPassport {
    return Intl.message('Passport', name: 'kycPassport', desc: '', args: []);
  }

  /// `Driving License`
  String get kycDrivingLicense {
    return Intl.message(
      'Driving License',
      name: 'kycDrivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Upload {documentType}`
  String kycUploadIdCard(Object documentType) {
    return Intl.message(
      'Upload $documentType',
      name: 'kycUploadIdCard',
      desc: '',
      args: [documentType],
    );
  }

  /// `First Document`
  String get kycFirstDocument {
    return Intl.message(
      'First Document',
      name: 'kycFirstDocument',
      desc: '',
      args: [],
    );
  }

  /// `Second Document`
  String get kycSecondDocument {
    return Intl.message(
      'Second Document',
      name: 'kycSecondDocument',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get kycSaveButton {
    return Intl.message('Save', name: 'kycSaveButton', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
