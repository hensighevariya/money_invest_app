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

  static String m0(destination) => "Code will be sent to ${destination}";

  static String m1(documentType) => "Upload ${documentType}";

  static String m2(method) => "Paid (${method})";

  static String m3(percent) => "${percent}% Monthly Return";

  static String m4(permissionName) =>
      "You have denied the ${permissionName} permission. Please go to device settings to enable ${permissionName} permissions.";

  static String m5(permissionName) =>
      "It looks like ${permissionName} access has been permanently disabled. Please go to your device settings to manually enable ${permissionName} permissions.";

  static String m6(seconds) => "${seconds} seconds";

  static String m7(qty, price) => "BUY ${qty} @ ${price}";

  static String m8(price) => "₹ ${price} / month";

  static String m9(percent) => "Save ${percent}%";

  static String m10(qty, price) => "SELL ${qty} @ ${price}";

  static String m11(price) => "₹ ${price} / year";

  static String m12(version) => "v${version} Available!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Account created successfully!",
    ),
    "agreeTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "By creating an account, you agree to our ",
    ),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "andLabel": MessageLookupByLibrary.simpleMessage(" and "),
    "appName": MessageLookupByLibrary.simpleMessage("Security Saas"),
    "cameraPermissionLabel": MessageLookupByLibrary.simpleMessage("Camera"),
    "changePasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Enter your current password and choose a new one to keep your account secure.",
    ),
    "changePasswordScreenTitle": MessageLookupByLibrary.simpleMessage(
      "Change Password",
    ),
    "changePasswordSuccessDescription": MessageLookupByLibrary.simpleMessage(
      "Your password has been updated successfully.",
    ),
    "changePasswordSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Password Updated",
    ),
    "codeWillBeSentTo": m0,
    "confirmPasswordFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter your confirm password...",
    ),
    "confirmPasswordFieldLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "confirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "continueButtonLabel": MessageLookupByLibrary.simpleMessage("Continue"),
    "copiedToClipboardHint": MessageLookupByLibrary.simpleMessage(
      "Copied to Clipboard",
    ),
    "currentPasswordFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter your current password...",
    ),
    "currentPasswordFieldLabel": MessageLookupByLibrary.simpleMessage(
      "Current Password",
    ),
    "dataNotFound": MessageLookupByLibrary.simpleMessage("Data Not Found"),
    "didntReceivedCode": MessageLookupByLibrary.simpleMessage(
      "Didn’t receive code?",
    ),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account? ",
    ),
    "emailVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Email verification code",
    ),
    "emailVerified": MessageLookupByLibrary.simpleMessage(
      "Email verified successfully",
    ),
    "enterOtpHint": MessageLookupByLibrary.simpleMessage("Enter OTP"),
    "errorAddressRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter address!",
    ),
    "errorCityRequired": MessageLookupByLibrary.simpleMessage(
      "Please select city!",
    ),
    "errorConfirmPasswordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Password and confirm password must be same!",
    ),
    "errorConfirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter confirm password!",
    ),
    "errorCountryRequired": MessageLookupByLibrary.simpleMessage(
      "Please select country!",
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
    "errorNewPasswordSameAsCurrent": MessageLookupByLibrary.simpleMessage(
      "New password must be different from the current password",
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
    "errorPincodeRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter pincode!",
    ),
    "errorStateRequired": MessageLookupByLibrary.simpleMessage(
      "Please select state!",
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
    "kycUploadIdCard": m1,
    "kycVerification": MessageLookupByLibrary.simpleMessage("KYC Verification"),
    "kycVoterId": MessageLookupByLibrary.simpleMessage("Voter ID"),
    "languageScreenTitle": MessageLookupByLibrary.simpleMessage("Language"),
    "loadingCities": MessageLookupByLibrary.simpleMessage("Loading cities..."),
    "loadingCountries": MessageLookupByLibrary.simpleMessage(
      "Loading countries...",
    ),
    "loadingStates": MessageLookupByLibrary.simpleMessage("Loading states..."),
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
    "mobileVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Mobile verification code",
    ),
    "mobileVerified": MessageLookupByLibrary.simpleMessage(
      "Mobile number verified successfully",
    ),
    "monthlyReturnsPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "monthlyReturnsPaidVia": m2,
    "monthlyReturnsTitle": MessageLookupByLibrary.simpleMessage(
      "Monthly Returns",
    ),
    "myInvestmentsActive": MessageLookupByLibrary.simpleMessage("Active"),
    "myInvestmentsMonthlyReturn": m3,
    "myInvestmentsTitle": MessageLookupByLibrary.simpleMessage(
      "My Investments",
    ),
    "newPasswordFieldHint": MessageLookupByLibrary.simpleMessage(
      "Enter your new password...",
    ),
    "newPasswordFieldLabel": MessageLookupByLibrary.simpleMessage(
      "New Password",
    ),
    "newPasswordHint": MessageLookupByLibrary.simpleMessage("New Password"),
    "noCitiesAvailable": MessageLookupByLibrary.simpleMessage(
      "No cities available",
    ),
    "noResultsFound": MessageLookupByLibrary.simpleMessage("No results found"),
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
    "permissionDeniedDescription": m4,
    "permissionDeniedModalTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Denied",
    ),
    "permissionPermanentlyDeniedDescription": m5,
    "photosPermissionLabel": MessageLookupByLibrary.simpleMessage("Photos"),
    "pleaseEnter6DigitOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter 6-digit verification code",
    ),
    "pleaseEnterEmailOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter 6-digit email verification code",
    ),
    "pleaseEnterMobileOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter 6-digit mobile verification code",
    ),
    "pleaseSelectCountryFirst": MessageLookupByLibrary.simpleMessage(
      "Please select a Country first",
    ),
    "pleaseSelectStateFirst": MessageLookupByLibrary.simpleMessage(
      "Please select a State first",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
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
    "registerAddressHint": MessageLookupByLibrary.simpleMessage("Address"),
    "registerAddressPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Your Address",
    ),
    "registerButtonLabel": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "registerCityHint": MessageLookupByLibrary.simpleMessage("Select City"),
    "registerConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "registerCountryHint": MessageLookupByLibrary.simpleMessage(
      "Select Country",
    ),
    "registerEmailHint": MessageLookupByLibrary.simpleMessage(
      "Your Email Address",
    ),
    "registerMobileHint": MessageLookupByLibrary.simpleMessage(
      "Your mobile number",
    ),
    "registerNameHint": MessageLookupByLibrary.simpleMessage("Your Name"),
    "registerPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter Password",
    ),
    "registerPincodeHint": MessageLookupByLibrary.simpleMessage("Pincode"),
    "registerPincodePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Enter Pincode",
    ),
    "registerStateHint": MessageLookupByLibrary.simpleMessage("Select State"),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Create a new account",
    ),
    "registerSurnameHint": MessageLookupByLibrary.simpleMessage("Your Surname"),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Register"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendCodeLink": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendIn": MessageLookupByLibrary.simpleMessage("Resend in "),
    "resendLabel": MessageLookupByLibrary.simpleMessage("Resend"),
    "resendTimer": m6,
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
    "searchCity": MessageLookupByLibrary.simpleMessage("Search City"),
    "searchCountry": MessageLookupByLibrary.simpleMessage("Search Country"),
    "searchCountryByNameOrCode": MessageLookupByLibrary.simpleMessage(
      "Search country by name or code",
    ),
    "searchState": MessageLookupByLibrary.simpleMessage("Search State"),
    "selectCountryFirst": MessageLookupByLibrary.simpleMessage(
      "Select Country first",
    ),
    "selectStateFirst": MessageLookupByLibrary.simpleMessage(
      "Select State first",
    ),
    "serverErrorDescription": MessageLookupByLibrary.simpleMessage(
      "We are experiencing some server issues, we apologises for inconvenience. Please try again after few minutes.",
    ),
    "serverErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
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
    "termsOfService": MessageLookupByLibrary.simpleMessage("Terms of Service"),
    "timeoutErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Request timeout! Please try again.",
    ),
    "tradingDiaryBuy": m7,
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
    "tradingDiaryMonthlyPrice": m8,
    "tradingDiaryPremium": MessageLookupByLibrary.simpleMessage(
      "Premium Subscription",
    ),
    "tradingDiaryPremiumDesc": MessageLookupByLibrary.simpleMessage(
      "Access detailed daily trading books",
    ),
    "tradingDiarySavePercent": m9,
    "tradingDiarySell": m10,
    "tradingDiarySubscribe": MessageLookupByLibrary.simpleMessage(
      "Subscribe Now",
    ),
    "tradingDiaryTitle": MessageLookupByLibrary.simpleMessage("Trading Diary"),
    "tradingDiaryTotalPnL": MessageLookupByLibrary.simpleMessage("Total P&L"),
    "tradingDiaryYearlyPlan": MessageLookupByLibrary.simpleMessage(
      "Yearly Plan",
    ),
    "tradingDiaryYearlyPrice": m11,
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
    "updateAvailableTitle": m12,
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
