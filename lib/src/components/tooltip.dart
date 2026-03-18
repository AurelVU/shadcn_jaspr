import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

enum TooltipSide { top, right, bottom, left }

class ShadTooltip extends StatefulComponent {
  final List<Component> children;
  final int delayMs;

  const ShadTooltip({
    required this.children,
    this.delayMs = 200,
    super.key,
  });

  @override
  State<ShadTooltip> createState() => _ShadTooltipState();
}

class _ShadTooltipState extends State<ShadTooltip> {
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
  Iterable<Component> build(BuildContext context) sync* {
    yield _ShadTooltipScope(
      isVisible: _isVisible,
      onShow: _show,
      onHide: _hide,
      child: div(
        component.children,
        classes: 'relative inline-block',
        attributes: {'data-slot': 'tooltip'},
      ),
    );
  }
}

class _ShadTooltipScope extends InheritedComponent {
  final bool isVisible;
  final VoidCallback onShow;
  final VoidCallback onHide;

  const _ShadTooltipScope({
    required this.isVisible,
    required this.onShow,
    required this.onHide,
    required super.child,
  });

  static _ShadTooltipScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadTooltipScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadTooltipScope oldComponent) {
    return isVisible != oldComponent.isVisible;
  }
}

class ShadTooltipTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadTooltipTrigger(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadTooltipScope.of(context);
    yield div(
      children,
      events: {
        'mouseenter': (_) => scope.onShow(),
        'mouseleave': (_) => scope.onHide(),
        'focus': (_) => scope.onShow(),
        'blur': (_) => scope.onHide(),
      },
      attributes: {'data-slot': 'tooltip-trigger'},
    );
  }
}

class ShadTooltipContent extends StatelessComponent {
  final List<Component> children;
  final TooltipSide side;
  final String? className;

  const ShadTooltipContent(
    this.children, {
    this.side = TooltipSide.top,
    this.className,
    super.key,
  });

  String _positionClasses() {
    switch (side) {
      case TooltipSide.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case TooltipSide.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case TooltipSide.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case TooltipSide.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadTooltipScope.of(context);
    if (!scope.isVisible) return;

    yield div(
      children,
      classes: cn([
        'absolute z-50 w-fit rounded-md bg-primary px-3 py-1.5 text-xs text-primary-foreground animate-in fade-in-0 zoom-in-95',
        _positionClasses(),
        className,
      ]),
      attributes: {
        'data-slot': 'tooltip-content',
        'data-state': 'open',
        'data-side': side.name,
        'role': 'tooltip',
      },
    );
  }
}
