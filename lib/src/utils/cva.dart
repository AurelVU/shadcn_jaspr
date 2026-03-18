import 'cn.dart';

/// Class Variance Authority — manages component variant classes.
/// Dart equivalent of the `cva` npm package.
///
/// [V] is the variant enum type, [S] is the size enum type.
class CVA<V extends Enum, S extends Enum> {
  final String base;
  final Map<V, String> variants;
  final Map<S, String> sizes;
  final V defaultVariant;
  final S defaultSize;

  const CVA({
    required this.base,
    required this.variants,
    required this.sizes,
    required this.defaultVariant,
    required this.defaultSize,
  });

  /// Resolves the final class string for the given [variant], [size],
  /// and optional [extra] classes.
  String resolve({V? variant, S? size, String? className}) {
    final v = variant ?? defaultVariant;
    final s = size ?? defaultSize;
    return cn([base, variants[v], sizes[s], className]);
  }
}

/// Simplified CVA with only variants (no size axis).
class CVASimple<V extends Enum> {
  final String base;
  final Map<V, String> variants;
  final V defaultVariant;

  const CVASimple({
    required this.base,
    required this.variants,
    required this.defaultVariant,
  });

  String resolve({V? variant, String? className}) {
    final v = variant ?? defaultVariant;
    return cn([base, variants[v], className]);
  }
}
