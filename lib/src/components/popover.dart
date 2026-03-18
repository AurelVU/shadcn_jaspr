import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum PopoverSide { top, right, bottom, left }

class ShadPopover extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadPopover({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadPopover> createState() => _ShadPopoverState();
}

class _ShadPopoverState extends State<ShadPopover> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = component.open ?? false;
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
    component.onOpenChange?.call(_isOpen);
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
    component.onOpenChange?.call(false);
  }

  @override
  Component build(BuildContext context) {
    return _ShadPopoverScope(
      isOpen: _isOpen,
      onToggle: _toggle,
      onClose: _close,
      child: div(
        component.children,
        classes: 'relative inline-block',
        attributes: {'data-slot': 'popover'},
      ),
    );
  }
}

class _ShadPopoverScope extends InheritedComponent {
  final bool isOpen;
  final VoidCallback onToggle;
  final VoidCallback onClose;

  const _ShadPopoverScope({
    required this.isOpen,
    required this.onToggle,
    required this.onClose,
    required super.child,
  });

  static _ShadPopoverScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadPopoverScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadPopoverScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadPopoverTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadPopoverTrigger(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadPopoverScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onToggle()},
      attributes: {'data-slot': 'popover-trigger'},
    );
  }
}

class ShadPopoverContent extends StatelessComponent {
  final List<Component> children;
  final PopoverSide side;
  final String? className;

  const ShadPopoverContent(
    this.children, {
    this.side = PopoverSide.bottom,
    this.className,
    super.key,
  });

  String _positionClasses() {
    switch (side) {
      case PopoverSide.top:
        return 'bottom-full left-1/2 -translate-x-1/2 mb-2';
      case PopoverSide.bottom:
        return 'top-full left-1/2 -translate-x-1/2 mt-2';
      case PopoverSide.left:
        return 'right-full top-1/2 -translate-y-1/2 mr-2';
      case PopoverSide.right:
        return 'left-full top-1/2 -translate-y-1/2 ml-2';
    }
  }

  @override
  Component build(BuildContext context) {
    final scope = _ShadPopoverScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return div(
      children,
      classes: cn([
        'absolute z-50 w-72 rounded-md border bg-popover p-4 text-popover-foreground shadow-md outline-none animate-in fade-in-0 zoom-in-95',
        _positionClasses(),
        className,
      ]),
      attributes: {
        'data-slot': 'popover-content',
        'data-state': 'open',
        'data-side': side.name,
      },
    );
  }
}
