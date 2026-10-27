import 'package:money_invest_app/bootstrap.dart';
import 'package:money_invest_app/src/app/money_invest_app.dart';
import 'package:money_invest_app/src/core/core.dart';

void main() {
  bootstrap(
    () => const MoneyInvestApp(),
    environment: AppEnvironment.production(),
  );
}
