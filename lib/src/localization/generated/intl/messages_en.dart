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

  static String m0(documentType) => "Upload ${documentType}";

  static String m1(method) => "Paid (${method})";

  static String m2(percent) => "${percent}% Monthly Return";

  static String m3(permissionName) =>
      "You have denied the ${permissionName} permission. Please go to device settings to enable ${permissionName} permissions.";

  static String m4(permissionName) =>
      "It looks like ${permissionName} access has been permanently disabled. Please go to your device settings to manually enable ${permissionName} permissions.";

  static String m5(seconds) => "${seconds} seconds";

  static String m6(qty, price) => "BUY ${qty} @ ${price}";

  static String m7(price) => "₹ ${price} / month";

  static String m8(percent) => "Save ${percent}%";

  static String m9(qty, price) => "SELL ${qty} @ ${price}";

  static String m10(price) => "₹ ${price} / year";

  static String m11(version) => "v${version} Available!";

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
    "homeActiveInvestments": MessageLookupByLibrary.simpleMessage(
      "Active Investments",
    ),
    "homeHello": MessageLookupByLibrary.simpleMessage("Hello,"),
    "homeInvestNow": MessageLookupByLibrary.simpleMessage("Invest Now"),
    "homeMonthlyReturn": MessageLookupByLibrary.simpleMessage("Monthly Return"),
    "homeMyBonds": MessageLookupByLibrary.simpleMessage("My Bonds"),
    "homePerMonth": MessageLookupByLibrary.simpleMessage("Per Month"),
    "homeRealTradesProof": MessageLookupByLibrary.simpleMessage(
      "Real Trades. Real Proof.",
    ),
    "homeReferAndEarn": MessageLookupByLibrary.simpleMessage("Refer & Earn"),
    "homeSubscribeNow": MessageLookupByLibrary.simpleMessage("Subscribe Now"),
    "homeTotalInvestment": MessageLookupByLibrary.simpleMessage(
      "Total Investment",
    ),
    "homeTotalReturnsReceived": MessageLookupByLibrary.simpleMessage(
      "Total Returns Received",
    ),
    "homeTradeDiary": MessageLookupByLibrary.simpleMessage("Trade Diary"),
    "homeTransparentTrading": MessageLookupByLibrary.simpleMessage(
      "Transparent Trading",
    ),
    "homeViewDetails": MessageLookupByLibrary.simpleMessage("View Details >"),
    "internetErrorDescription": MessageLookupByLibrary.simpleMessage(
      "Looks like you are not connected to internet right now. Please check your internet connection and try again.",
    ),
    "internetErrorTitle": MessageLookupByLibrary.simpleMessage(
      "No Internet Connection!",
    ),
    "investAmount": MessageLookupByLibrary.simpleMessage("Investment Amount"),
    "investAsPerAgreement": MessageLookupByLibrary.simpleMessage(
      "As per agreement",
    ),
    "investCompletePayment": MessageLookupByLibrary.simpleMessage(
      "Complete Payment",
    ),
    "investCustom": MessageLookupByLibrary.simpleMessage("Custom"),
    "investDebitCreditCard": MessageLookupByLibrary.simpleMessage(
      "Debit/Credit Card",
    ),
    "investDownloadPdf": MessageLookupByLibrary.simpleMessage("Download PDF"),
    "investGPay": MessageLookupByLibrary.simpleMessage("GPay"),
    "investImpsNeft": MessageLookupByLibrary.simpleMessage(
      "IMPS / NEFT (Virtual Account)",
    ),
    "investInvestmentAgreement": MessageLookupByLibrary.simpleMessage(
      "INVESTMENT AGREEMENT",
    ),
    "investInvestmentBond": MessageLookupByLibrary.simpleMessage(
      "Investment Bond",
    ),
    "investInvestorName": MessageLookupByLibrary.simpleMessage("Investor Name"),
    "investMaturityTerms": MessageLookupByLibrary.simpleMessage(
      "Maturity Terms",
    ),
    "investMonthlyReturnRate": MessageLookupByLibrary.simpleMessage(
      "Monthly Return Rate",
    ),
    "investNetBanking": MessageLookupByLibrary.simpleMessage("Net Banking"),
    "investNewInvestment": MessageLookupByLibrary.simpleMessage(
      "New Investment",
    ),
    "investOr": MessageLookupByLibrary.simpleMessage("OR"),
    "investOthers": MessageLookupByLibrary.simpleMessage("Others"),
    "investPaymentMethod": MessageLookupByLibrary.simpleMessage(
      "Payment Method",
    ),
    "investPaymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "Payment Successful!",
    ),
    "investPaytm": MessageLookupByLibrary.simpleMessage("Paytm"),
    "investPhonePe": MessageLookupByLibrary.simpleMessage("PhonePe"),
    "investProceedToPay": MessageLookupByLibrary.simpleMessage(
      "Proceed to Pay",
    ),
    "investSecuredByRazorpay": MessageLookupByLibrary.simpleMessage(
      "Secured by Razorpay",
    ),
    "investSelectUpiApp": MessageLookupByLibrary.simpleMessage(
      "Select UPI App",
    ),
    "investStartDate": MessageLookupByLibrary.simpleMessage("Start Date"),
    "investTransactionId": MessageLookupByLibrary.simpleMessage(
      "Transaction ID",
    ),
    "investUpi": MessageLookupByLibrary.simpleMessage("UPI (Recommended)"),
    "investViewInvestmentDetails": MessageLookupByLibrary.simpleMessage(
      "View Investment Details",
    ),
    "kycAadhaarCard": MessageLookupByLibrary.simpleMessage("Aadhaar Card"),
    "kycAccountHolderName": MessageLookupByLibrary.simpleMessage(
      "Account Holder Name",
    ),
    "kycBackImage": MessageLookupByLibrary.simpleMessage("Back Image"),
    "kycBankDetails": MessageLookupByLibrary.simpleMessage("Bank Details"),
    "kycChooseIdentityType": MessageLookupByLibrary.simpleMessage(
      "Choose Your Identity Type",
    ),
    "kycDescription1": MessageLookupByLibrary.simpleMessage(
      "To ensure the safety of all users, a one-time verification is required. The KYC process (Know Your Customer) guarantees that only real individuals and registered institutions can access protected features like event creation, ticket sales, sponsorships, and location rentals.",
    ),
    "kycDescription2": MessageLookupByLibrary.simpleMessage(
      "Uploaded documents are reviewed only by authorized admins who are responsible for the verification process. Your data is handled with strict confidentiality and will never be shared with third parties.",
    ),
    "kycDescription3": MessageLookupByLibrary.simpleMessage(
      "This helps protect the community from fake accounts, fraud, and identity misuse.",
    ),
    "kycDocumentNumber": MessageLookupByLibrary.simpleMessage(
      "Document Number",
    ),
    "kycDocumentType": MessageLookupByLibrary.simpleMessage("Document Type"),
    "kycDrivingLicense": MessageLookupByLibrary.simpleMessage(
      "Driving License",
    ),
    "kycFirstDocument": MessageLookupByLibrary.simpleMessage("First Document"),
    "kycFrontImage": MessageLookupByLibrary.simpleMessage("Front Image"),
    "kycHintDocNumber": MessageLookupByLibrary.simpleMessage("1234 5678 9012"),
    "kycHintName": MessageLookupByLibrary.simpleMessage("John Doe"),
    "kycIdCard": MessageLookupByLibrary.simpleMessage("ID Card"),
    "kycPanCard": MessageLookupByLibrary.simpleMessage("PAN Card"),
    "kycPassport": MessageLookupByLibrary.simpleMessage("Passport"),
    "kycProofOfIdentity": MessageLookupByLibrary.simpleMessage(
      "Proof Of Identity",
    ),
    "kycSaveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "kycSecondDocument": MessageLookupByLibrary.simpleMessage(
      "Second Document",
    ),
    "kycSubmitForVerification": MessageLookupByLibrary.simpleMessage(
      "Submit for Verification",
    ),
    "kycSubtitle": MessageLookupByLibrary.simpleMessage(
      "Complete your KYC to start investing",
    ),
    "kycTitle": MessageLookupByLibrary.simpleMessage("KYC"),
    "kycUploadIdCard": m0,
    "kycVerification": MessageLookupByLibrary.simpleMessage("KYC Verification"),
    "kycVoterId": MessageLookupByLibrary.simpleMessage("Voter ID"),
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
    "logoutDesc": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "monthlyReturnsPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "monthlyReturnsPaidVia": m1,
    "monthlyReturnsTitle": MessageLookupByLibrary.simpleMessage(
      "Monthly Returns",
    ),
    "myInvestmentsActive": MessageLookupByLibrary.simpleMessage("Active"),
    "myInvestmentsMonthlyReturn": m2,
    "myInvestmentsTitle": MessageLookupByLibrary.simpleMessage(
      "My Investments",
    ),
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
    "permissionDeniedDescription": m3,
    "permissionDeniedModalTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Denied",
    ),
    "permissionPermanentlyDeniedDescription": m4,
    "photosPermissionLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "profileBankAccount": MessageLookupByLibrary.simpleMessage("Bank Account"),
    "profileChangePassword": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "profileHelpAndSupport": MessageLookupByLibrary.simpleMessage(
      "Help & Support",
    ),
    "profileKyc": MessageLookupByLibrary.simpleMessage("KYC"),
    "profileKycVerified": MessageLookupByLibrary.simpleMessage("Verified"),
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
    "resendTimer": m5,
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
    "tradingDiaryBuy": m6,
    "tradingDiaryFeature1": MessageLookupByLibrary.simpleMessage(
      "Daily F&O trade details",
    ),
    "tradingDiaryFeature2": MessageLookupByLibrary.simpleMessage(
      "Entry/Exit prices & strikes",
    ),
    "tradingDiaryFeature3": MessageLookupByLibrary.simpleMessage(
      "Reasoning screenshots",
    ),
    "tradingDiaryFeature4": MessageLookupByLibrary.simpleMessage(
      "Live P&L tracking",
    ),
    "tradingDiaryMonthlyPlan": MessageLookupByLibrary.simpleMessage(
      "Monthly Plan",
    ),
    "tradingDiaryMonthlyPrice": m7,
    "tradingDiaryPremium": MessageLookupByLibrary.simpleMessage(
      "Premium Subscription",
    ),
    "tradingDiaryPremiumDesc": MessageLookupByLibrary.simpleMessage(
      "Access detailed daily trading books",
    ),
    "tradingDiarySavePercent": m8,
    "tradingDiarySell": m9,
    "tradingDiarySubscribe": MessageLookupByLibrary.simpleMessage(
      "Subscribe Now",
    ),
    "tradingDiaryTitle": MessageLookupByLibrary.simpleMessage("Trading Diary"),
    "tradingDiaryTotalPnL": MessageLookupByLibrary.simpleMessage("Total P&L"),
    "tradingDiaryYearlyPlan": MessageLookupByLibrary.simpleMessage(
      "Yearly Plan",
    ),
    "tradingDiaryYearlyPrice": m10,
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
    "updateAvailableTitle": m11,
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
