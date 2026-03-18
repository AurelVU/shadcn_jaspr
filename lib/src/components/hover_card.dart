import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadHoverCard extends StatefulComponent {
  final List<Component> children;
  final int openDelay;
  final int closeDelay;

  const ShadHoverCard({
    required this.children,
    this.openDelay = 200,
    this.closeDelay = 200,
    super.key,
  });

  @override
  State<ShadHoverCard> createState() => _ShadHoverCardState();
}

class _ShadHoverCardState extends State<ShadHoverCard> {
  bool _isVisible = false;

  void _show() {
    setState(() {
      _isVisible = true;
    });
  }

  void _hide() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadHoverCardScope(
      isVisible: _isVisible,
      onShow: _show,
      onHide: _hide,
      child: div(
        component.children,
        classes: 'relative inline-block',
        attributes: {'data-slot': 'hover-card'},
      ),
    );
  }
}

class _ShadHoverCardScope extends InheritedComponent {
  final bool isVisible;
  final VoidCallback onShow;
  final VoidCallback onHide;

  const _ShadHoverCardScope({
    required this.isVisible,
    required this.onShow,
    required this.onHide,
    required super.child,
  });

  static _ShadHoverCardScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadHoverCardScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadHoverCardScope oldComponent) {
    return isVisible != oldComponent.isVisible;
  }
}

class ShadHoverCardTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadHoverCardTrigger(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadHoverCardScope.of(context);
    return div(
      children,
      events: {
        'mouseenter': (_) => scope.onShow(),
        'mouseleave': (_) => scope.onHide(),
        'focus': (_) => scope.onShow(),
        'blur': (_) => scope.onHide(),
      },
      attributes: {'data-slot': 'hover-card-trigger'},
    );
  }
}

class ShadHoverCardContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadHoverCardContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadHoverCardScope.of(context);
    if (!scope.isVisible) return Component.fragment([]);

    return div(
      children,
      classes: cn([
        'absolute z-50 mt-2 w-64 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none animate-in fade-in-0 zoom-in-95',
        className,
      ]),
      events: {
        'mouseenter': (_) => scope.onShow(),
        'mouseleave': (_) => scope.onHide(),
      },
      attributes: {
        'data-slot': 'hover-card-content',
        'data-state': 'open',
      },
    );
  }
}
