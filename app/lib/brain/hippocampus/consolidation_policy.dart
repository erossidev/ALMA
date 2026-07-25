import '../working_memory.dart';

class ConsolidationPolicy {

  bool shouldConsolidate(WorkingMemory memory) {

    return memory.items.isNotEmpty;

  }

}