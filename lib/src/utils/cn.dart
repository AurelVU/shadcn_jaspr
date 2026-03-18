/// Merges CSS class names, filtering out null and empty values.
/// Equivalent to `clsx` in JavaScript.
String cn(List<String?> classes) =>
    classes.where((c) => c != null && c.isNotEmpty).join(' ');
