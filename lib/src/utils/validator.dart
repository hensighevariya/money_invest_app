import 'package:money_invest_app/src/utils/constants.dart';

bool isOnlyDigit(String input) => AppConstants.isOnlyDigits.hasMatch(input);

bool hasAtleastOneLetter(String input) =>
    AppConstants.containsAtLeastOneLetter.hasMatch(input);
