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
  }) : userData = userRepository.getCurrentUser(),
       super(const ProfileState()) {
    on<UserLogoutRequested>(_onUserLogoutRequested, transformer: droppable());
  }

  final AuthRepository _authRepository;
  final LoadingHandler _loadingHandler;
  final UserData? userData;

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
