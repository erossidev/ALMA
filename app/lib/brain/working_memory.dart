import 'working_memory_item.dart';

class WorkingMemory {
  final List<WorkingMemoryItem> _items = [];

  List<WorkingMemoryItem> get items =>
      List.unmodifiable(_items);

  void add(WorkingMemoryItem item) {
    _items.add(item);
  }

  void remove(WorkingMemoryItem item) {
    _items.remove(item);
  }

  void clear() {
    _items.clear();
  }

  void sortBy(
    int Function(
      WorkingMemoryItem a,
      WorkingMemoryItem b,
    ) compare,
  ) {
    _items.sort(compare);
  }
}