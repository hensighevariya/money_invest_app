import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:money_invest_app/src/core/base/base_bloc.dart';
import 'package:money_invest_app/src/core/base/loading_handler.dart';
import 'package:money_invest_app/src/core/base/progress_status.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/presentation/ui/profile/logic/profile_event.dart';
import 'package:money_invest_app/src/presentation/ui/profile/logic/profile_state.dart';

base class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this._authRepository,
    required this._loadingHandler,
    required UserRepository userRepository,
    required LocalStorageService localStorageService,
    required SocketClientService socketClientService,
  }) : _userRepository = userRepository,
       userData = userRepository.getCurrentUser(),
       super(
         ProfileState(
           isNotification:
               userRepository.getCurrentUser()?.isNotification ?? false,
         ),
       ) {
    on<UserLogoutRequested>(_onUserLogoutRequested, transformer: droppable());
    on<NotificationStatusChanged>(
      _onNotificationStatusChanged,
      transformer: sequential(),
    );
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final LoadingHandler _loadingHandler;
  final UserData? userData;

  Future<void> _onNotificationStatusChanged(
    NotificationStatusChanged event,
    Emitter<ProfileState> emit,
  ) async {
    final previousStatus = state.isNotification;
    emit(state.copyWith(isNotification: event.isNotification));
    try {
      final success = await _userRepository.updateNotificationStatus(
        isNotification: event.isNotification,
      );
      if (!success) {
        emit(state.copyWith(isNotification: previousStatus));
      }
    } catch (error, stackTrace) {
      emit(state.copyWith(isNotification: previousStatus));
      handleError(error, stackTrace);
    }
  }

  Future<void> _onUserLogoutRequested(
    UserLogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(logoutStatus: const ProgressStatus.processing()));
      await processRequest(
        _authRepository.userLogout,
        loadingHandler: _loadingHandler.handleLoading,
        throwOnError: true,
      );

      emit(state.copyWith(logoutStatus: const ProgressStatus.success(true)));
    } catch (error, stackTrace) {
      emit(state.copyWith(logoutStatus: ProgressStatus.failed(error)));
      handleError(error, stackTrace);
    }
  }
}
