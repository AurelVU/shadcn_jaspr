import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

enum DirectionValue { ltr, rtl }

class ShadDirectionProvider extends StatelessComponent {
  final DirectionValue direction;
  final List<Component> children;

  const ShadDirectionProvider({
    required this.direction,
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return _ShadDirectionScope(
      direction: direction,
      child: div(
        children,
        attributes: {
          'data-slot': 'direction-provider',
          'dir': direction.name,
        },
      ),
    );
  }

  static DirectionValue of(BuildContext context) {
    return _ShadDirectionScope.of(context).direction;
  }
}

class _ShadDirectionScope extends InheritedComponent {
  final DirectionValue direction;

  const _ShadDirectionScope({
    required this.direction,
    required super.child,
  });

  static _ShadDirectionScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadDirectionScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadDirectionScope oldComponent) {
    return direction != oldComponent.direction;
  }
}
