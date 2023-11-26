class GeneralUtils {
  static String? capitalizeFirstLetter(String? input) {
    if (input == null || input.isEmpty) {
      return input;
    }

    return input.substring(0, 1).toUpperCase() +
        input.substring(1).toLowerCase();
  }

  static bool fuzzySearch(String target, String query) {
    int queryIndex = 0;
    int targetIndex = 0;

    while (queryIndex < query.length && targetIndex < target.length) {
      if (query[queryIndex].toLowerCase() ==
          target[targetIndex].toLowerCase()) {
        queryIndex++;
      }
      targetIndex++;
    }

    return queryIndex == query.length;
  }
}
