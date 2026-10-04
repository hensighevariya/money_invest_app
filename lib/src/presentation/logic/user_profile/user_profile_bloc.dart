import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:money_invest_app/src/core/base/base_bloc.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/subscription_mixin.dart';

import 'user_profile_event.dart';
import 'user_profile_state.dart';

final class UserProfileBloc extends BaseBloc<UserProfileEvent, UserProfileState>
    with HydratedMixin, StreamSubscriptionMixin {
  UserProfileBloc({required UserRepository userRepository, required this._localStorageService})
    : _userRepository = userRepository,
      super(
        UserProfileState(isUserAuthorized: userRepository.isUserAuthorized(), data: userRepository.getCurrentUser()),
      ) {
    hydrate();
    on<FetchUserProfile>(_onFetchUserProfile, transformer: droppable());
    on<UserProfileUpdated>(_onUserProfileUpdated, transformer: sequential());
    on<UserLoggedIn>(_onUserLoggedIn, transformer: droppable());
    on<UserLoggedOut>(_onUserLoggedOut, transformer: droppable());
    on<GetCurrentUser>(_getCurrentUser, transformer: droppable());

    addAllSubscriptions([
      _userRepository.userStream.listen((event) {
        add(UserProfileUpdated(event));
      }),
    ]);
  }

  final UserRepository _userRepository;
  final LocalStorageService _localStorageService;

  @override
  Future<void> close() async {
    cancelAllSubscriptions();
    return super.close();
  }

  void _getCurrentUser(GetCurrentUser event, Emitter<UserProfileState> emit) {
    emit(state.copyWith(data: _userRepository.getCurrentUser()));
  }

  FutureOr<void> _onFetchUserProfile(FetchUserProfile event, Emitter<UserProfileState> emit) async {
    final result = await processRequest(
      _userRepository.getProfile,
      loadingHandler: (value) => emit(state.copyWith(loading: value)),
      errorHandler: (error, [stackTrace]) => emit(state.copyWith(loading: false, error: error)),
    );
    if (result != null) {
      emit(state.copyWith(data: result, loading: false));
    }
  }

  FutureOr<void> _onUserProfileUpdated(UserProfileUpdated event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(data: event.userData, loading: false));
  }

  FutureOr<void> _onUserLoggedIn(UserLoggedIn event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(isUserAuthorized: true, data: event.userData, loading: false));
  }

  FutureOr<void> _onUserLoggedOut(UserLoggedOut event, Emitter<UserProfileState> emit) async {
    HydratedBloc.storage.clear();
    await processRequest<void>(_userRepository.userUnauthorized);
    emit(const UserProfileState(isUserAuthorized: false));
  }

  @override
  UserProfileState? fromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('userIdentifier') && json.containsKey('isUserAuthorized')) {
        UserData? userData;
        if (json case {'user': Map<String, dynamic> userJson}) {
          userData = UserData.fromJson(userJson);
        }

        return UserProfileState(isUserAuthorized: json['isUserAuthorized'] == true, data: userData);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserProfileState state) {
    return {'isUserAuthorized': state.isUserAuthorized, 'user': state.data?.toJson()};
  }
}
