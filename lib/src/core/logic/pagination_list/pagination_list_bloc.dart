import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_invest_app/src/core/core.dart';
import 'package:money_invest_app/src/utils/constants.dart';

abstract base class PaginationListBloc<T extends Object?>
    extends BaseBloc<PaginationListEvent, PaginationListState<T>> {
  PaginationListBloc(super.initialState, {this.pageSize = AppConstants.pageSize}) {
    on<RefreshPaginationList>(onRefreshPaginationList, transformer: droppable());
    on<LoadMorePaginationList>(onLoadMorePaginationList, transformer: droppable());
    on<FetchPaginationList>(onFetchPaginationList, transformer: droppable());

    add(const FetchPaginationList());
  }

  @protected
  final int pageSize;

  @protected
  Future<void> onRefreshPaginationList(RefreshPaginationList event, Emitter<PaginationListState<T>> emit) async {
    emit(const PaginationListState());
    add(const FetchPaginationList());
  }

  @protected
  Future<void> onLoadMorePaginationList(LoadMorePaginationList event, Emitter<PaginationListState<T>> emit) async {
    if (state.reachAtEnd) return;
    add(const FetchPaginationList());
  }

  Future<void> onFetchPaginationList(FetchPaginationList event, Emitter<PaginationListState<T>> emit) async {
    final page = (state.data.length ~/ pageSize) + 1;

    final result = await processRequest(
      () => fetchListData(page),
      loadingHandler:  (value) => emit(state.copyWith(loading: value)),
      errorHandler:  (error, [stackTrace]) => emit(state.copyWith(error: error)),
    );

    if (result != null) {
      emit(PaginationListState(data: List<T>.from(state.data)..addAll(result), reachAtEnd: result.length < pageSize));
    }
  }

  Future<List<T>> fetchListData(int page);
}
