import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/data/data.dart';
import 'package:money_invest_app/src/utils/subscription_mixin.dart' show StreamSubscriptionMixin;

import 'user_profile_event.dart';
import 'user_profile_state.dart';

final class UserProfileBloc extends BaseBloc<UserProfileEvent, UserProfileState>
    with HydratedMixin, StreamSubscriptionMixin {
  UserProfileBloc({required UserRepository userRepository})
    : _userRepository = userRepository,
      super(
        UserProfileState(
          isUserAuthorized: userRepository.isUserAuthorized(),
          userIdentifier: userRepository.getUserIdentifier(),
          data: userRepository.getCurrentUser(),
        ),
      ) {
    hydrate();

    on<FetchUserProfile>(_onFetchUserProfile, transformer: droppable());
    on<UserProfileUpdated>(_onUserProfileUpdated, transformer: sequential());
    on<UserLoggedIn>(_onUserLoggedIn, transformer: droppable());
    on<UserLoggedOut>(_onUserLoggedOut, transformer: droppable());

    addSubscription(
      _userRepository.userStream.listen((event) {
        add(UserProfileUpdated(event));
      }),
    );
  }

  final UserRepository _userRepository;

  @override
  Future<void> close() async {
    cancelAllSubscriptions();
    return super.close();
  }

  FutureOr<void> _onFetchUserProfile(FetchUserProfile event, Emitter<UserProfileState> emit) async {
    final result = await processRequest(
      _userRepository.getProfile,
      loadingHandler: (value) => emit(state.copyWith(loading: value)),
      errorHandler: (error, [stackTrace]) => emit(state.copyWith(error: error)),
    );
    if (result != null) {
      emit(state.copyWith(data: result));
    }
  }

  FutureOr<void> _onUserProfileUpdated(UserProfileUpdated event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(data: event.userData));
  }

  FutureOr<void> _onUserLoggedIn(UserLoggedIn event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(isUserAuthorized: true, userIdentifier: event.userData.uid, data: event.userData));

    add(const FetchUserProfile());
  }

  FutureOr<void> _onUserLoggedOut(UserLoggedOut event, Emitter<UserProfileState> emit) async {
    HydratedBloc.storage.clear();
    await processRequest<void>(_userRepository.userUnauthorized);

    emit(UserProfileState(isUserAuthorized: false, userIdentifier: _userRepository.getUserIdentifier()));

    add(const FetchUserProfile());
  }

  @override
  UserProfileState? fromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('userIdentifier') && json.containsKey('isUserAuthorized')) {
        UserData? userData;
        if (json case {'user': Map<String, dynamic> userJson}) {
          userData = UserData.fromJson(userJson);
        }

        return UserProfileState(
          isUserAuthorized: json['isUserAuthorized'] == true,
          userIdentifier: json['userIdentifier'].toString(),
          data: userData,
        );
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserProfileState state) {
    return {
      'isUserAuthorized': state.isUserAuthorized,
      'userIdentifier': state.userIdentifier,
      'user': state.data?.toJson(),
    };
  }
}
