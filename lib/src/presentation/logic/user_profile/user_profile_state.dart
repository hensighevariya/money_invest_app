import 'package:money_invest_app/src/core/base/base_state.dart';
import 'package:money_invest_app/src/data/data.dart';

final class UserProfileState extends DataState<UserData> {
  const UserProfileState({
    super.data,
    super.error,
    super.loading,
    required this.isUserAuthorized,
  });

  final bool isUserAuthorized;

  @override
  List<Object?> get props => [data, error, loading, isUserAuthorized];

  @override
  UserProfileState copyWith({
    UserData? data,
    Object? error,
    bool? loading,
    bool? isUserAuthorized,
  }) {
    return UserProfileState(
      data: data ?? this.data,
      error: error ?? this.error,
      loading: loading ?? this.loading,
      isUserAuthorized: isUserAuthorized ?? this.isUserAuthorized,
    );
  }
}
