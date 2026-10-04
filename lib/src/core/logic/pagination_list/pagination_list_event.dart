import 'package:flutter/foundation.dart';

@immutable
sealed class PaginationListEvent {
  const PaginationListEvent();
}

class FetchPaginationList extends PaginationListEvent {
  const FetchPaginationList();
}

class RefreshPaginationList extends PaginationListEvent {
  const RefreshPaginationList();
}

class LoadMorePaginationList extends PaginationListEvent {
  const LoadMorePaginationList();
}
