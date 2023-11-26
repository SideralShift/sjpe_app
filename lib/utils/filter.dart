class Filter<T> {
  final bool Function(T item) testFunction;

  Filter({required this.testFunction});
}

class UIFilter<T> extends Filter<T>{
  String groupName;
  String description;

  UIFilter({required super.testFunction, required this.description, required this.groupName});
}