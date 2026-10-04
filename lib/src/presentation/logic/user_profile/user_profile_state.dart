

import 'package:money_invest_app/src/core/base/base_state.dart';
import 'package:money_invest_app/src/data/data.dart';

final class UserProfileState extends DataState<UserData> {
  const UserProfileState({
    super.data,
    super.error,
    super.loading,
    required this.isUserAuthorized,
    required this.userIdentifier,
  });

  final bool isUserAuthorized;
  final String userIdentifier;

  @override
  List<Object?> get props => [data, error, loading, isUserAuthorized, userIdentifier];

  @override
  UserProfileState copyWith({
    UserData? data,
    Object? error,
    bool? loading,
    bool? isUserAuthorized,
    String? userIdentifier,
  }) {
    return UserProfileState(
      data: data ?? this.data,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      isUserAuthorized: isUserAuthorized ?? this.isUserAuthorized,
      userIdentifier: userIdentifier ?? this.userIdentifier,
    );
  }
}
