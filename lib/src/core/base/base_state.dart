import 'package:equatable/equatable.dart';

abstract base class BaseState extends Equatable {
  const BaseState({
    this.loading = false,
    this.error,
  });

  final bool loading;
  final Object? error;

  @override
  List<Object?> get props => [loading, error];

  bool get hasData;

  bool get hasError => error != null;
}

base class DataState<T extends Object?> extends BaseState {
  const DataState({
    super.loading,
    super.error,
    this.data,
  });

  const DataState.loading({
    required super.loading,
    T? initialData,
  }) : data = initialData;

  const DataState.value(T this.data);

  const DataState.error({
    required super.error,
    T? initialData,
  }) : data = initialData;

  final T? data;

  @override
  List<Object?> get props => super.props..add(data);

  @override
  bool get hasData => data != null;

  DataState<T> copyWith({
    bool? loading,
    T? data,
    Object? error,
  }) {
    return DataState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

base class ListState<T extends Object?> extends BaseState {
  const ListState({
    super.loading,
    super.error,
    this.data = const [],
  });

  const ListState.loading({
    required super.loading,
    List<T>? initialData,
  }) : data = initialData ?? const [];

  const ListState.value({
    required this.data,
  });

  const ListState.error({
    required super.error,
    List<T>? initialData,
  }) : data = initialData ?? const [];

  final List<T> data;

  @override
  List<Object?> get props => super.props..add(data);

  @override
  bool get hasData => data.isNotEmpty;

  ListState<T> copyWith({
    bool? loading,
    List<T>? data,
    Object? error,
  }) {
    return ListState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

base class SelectionListState<T extends Object?, S extends Object?> extends ListState<T> {
  const SelectionListState({
    super.loading,
    super.error,
    super.data = const [],
    this.selected,
  });

  const SelectionListState.loading({
    required super.loading,
    List<T>? initialData,
    this.selected,
  }) : super(data: initialData ?? const []);

  const SelectionListState.value({
    required super.data,
    this.selected,
  });

  const SelectionListState.error({
    required super.error,
    List<T>? initialData,
    this.selected,
  }) : super(data: initialData ?? const []);

  final S? selected;

  @override
  List<Object?> get props => super.props..add(selected);

  @override
  SelectionListState<T, S> copyWith({
    bool? loading,
    List<T>? data,
    S? selected,
    Object? error,
  }) {
    return SelectionListState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      selected: selected ?? this.selected,
      error: error ?? this.error,
    );
  }
}

base class PaginationListState<T extends Object?> extends ListState<T> {
  const PaginationListState({
    super.loading,
    super.error,
    super.data = const [],
    this.reachAtEnd = false,
  });

  const PaginationListState.loading({
    required super.loading,
    List<T>? initialData,
    bool? reachAtEnd,
  })  : reachAtEnd = reachAtEnd ?? false,
        super(data: initialData ?? const []);

  const PaginationListState.value({
    required super.data,
    this.reachAtEnd = false,
  });

  const PaginationListState.error({
    required super.error,
    List<T>? initialData,
    bool? reachAtEnd,
  })  : reachAtEnd = reachAtEnd ?? false,
        super(data: initialData ?? const []);

  final bool reachAtEnd;

  @override
  List<Object?> get props => super.props..add(reachAtEnd);

  @override
  PaginationListState<T> copyWith({
    bool? loading,
    List<T>? data,
    bool? reachAtEnd,
    Object? error,
  }) {
    return PaginationListState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      reachAtEnd: reachAtEnd ?? this.reachAtEnd,
      error: error ?? this.error,
    );
  }
}
