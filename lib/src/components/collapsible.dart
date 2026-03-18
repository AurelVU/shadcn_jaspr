import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadCollapsible extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;
  final String? className;

  const ShadCollapsible({
    this.open,
    this.onOpenChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadCollapsible> createState() => _ShadCollapsibleState();
}

class _ShadCollapsibleState extends State<ShadCollapsible> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = component.open ?? false;
  }

  void _setOpen(bool value) {
    setState(() {
      _isOpen = value;
    });
    component.onOpenChange?.call(value);
  }

  @override
  Component build(BuildContext context) {
    return _ShadCollapsibleScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(
        component.children,
        classes: cn([component.className]),
        attributes: {
          'data-slot': 'collapsible',
          'data-state': _isOpen ? 'open' : 'closed',
        },
      ),
    );
  }
}

class _ShadCollapsibleScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadCollapsibleScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadCollapsibleScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadCollapsibleScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadCollapsibleScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadCollapsibleTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadCollapsibleTrigger(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCollapsibleScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onOpenChange(!scope.isOpen)},
      attributes: {
        'data-slot': 'collapsible-trigger',
        'data-state': scope.isOpen ? 'open' : 'closed',
      },
    );
  }
}

class ShadCollapsibleContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCollapsibleContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCollapsibleScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return div(
      children,
      classes: cn([className]),
      attributes: {
        'data-slot': 'collapsible-content',
        'data-state': 'open',
      },
    );
  }
}
