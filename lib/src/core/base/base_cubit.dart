import 'package:flutter_bloc/flutter_bloc.dart';

import 'request_handler.dart';

abstract base class BaseCubit<State> extends Cubit<State> with RequestHandler {
  BaseCubit(super.initialState);

  @override
  void handleError(Object error, [StackTrace? stackTrace]) {
    onError(error, stackTrace ?? StackTrace.current);
  }
}
