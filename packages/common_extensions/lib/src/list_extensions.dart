extension IterableExtensions<E> on Iterable<E> {
  bool isIn(Iterable<E> other) {
    for (final value in this) {
      if (!other.contains(value)) return false;
    }
    return true;
  }

  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) {
    return fold(
      <K, List<E>>{},
      (previousValue, element) {
        final key = keyFunction(element);
        final list = previousValue[key] ?? [];
        list.add(element);
        previousValue[key] = list;
        return previousValue;
      },
    );
  }

  Iterable<T> mapIndexed<T>(T Function(E element, int index) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E element, int index) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension NullableIterableExtensions<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrNotEmpty => this != null && this!.isNotEmpty;
}
