import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum DrawerDirection { top, right, bottom, left }

class ShadDrawer extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadDrawer({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadDrawer> createState() => _ShadDrawerState();
}

class _ShadDrawerState extends State<ShadDrawer> {
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
    return _ShadDrawerScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(component.children),
    );
  }
}

class _ShadDrawerScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadDrawerScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadDrawerScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadDrawerScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadDrawerScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadDrawerTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadDrawerTrigger(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadDrawerScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onOpenChange(true)},
      attributes: {'data-slot': 'drawer-trigger'},
    );
  }
}

class ShadDrawerContent extends StatelessComponent {
  final List<Component> children;
  final DrawerDirection direction;
  final bool showHandle;
  final String? className;

  const ShadDrawerContent(
    this.children, {
    this.direction = DrawerDirection.bottom,
    this.showHandle = true,
    this.className,
    super.key,
  });

  String _directionClasses() {
    switch (direction) {
      case DrawerDirection.bottom:
        return 'inset-x-0 bottom-0 mt-24 rounded-t-[10px] border-t';
      case DrawerDirection.top:
        return 'inset-x-0 top-0 mb-24 rounded-b-[10px] border-b';
      case DrawerDirection.left:
        return 'inset-y-0 left-0 mr-24 h-full w-3/4 sm:max-w-sm rounded-r-[10px] border-r';
      case DrawerDirection.right:
        return 'inset-y-0 right-0 ml-24 h-full w-3/4 sm:max-w-sm rounded-l-[10px] border-l';
    }
  }

  @override
  Component build(BuildContext context) {
    final scope = _ShadDrawerScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return Component.fragment([
      // Overlay
      div(
        [],
        classes: 'fixed inset-0 z-50 bg-black/50',
        attributes: {'data-slot': 'drawer-overlay', 'data-state': 'open'},
        events: {'click': (_) => scope.onOpenChange(false)},
      ),
      // Content
      div(
        [
          if (showHandle &&
              (direction == DrawerDirection.bottom ||
                  direction == DrawerDirection.top))
            div(
              [],
              classes:
                  'mx-auto mt-4 h-2 w-[100px] shrink-0 rounded-full bg-muted',
              attributes: {'data-slot': 'drawer-handle'},
            ),
          ...children,
        ],
        classes: cn([
          'fixed z-50 flex flex-col bg-background shadow-lg',
          _directionClasses(),
          className,
        ]),
        attributes: {
          'data-slot': 'drawer-content',
          'data-state': 'open',
          'data-direction': direction.name,
          'role': 'dialog',
          'aria-modal': 'true',
        },
      ),
    ]);
  }
}

class ShadDrawerHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDrawerHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['grid gap-1.5 p-4 text-center sm:text-left', className]),
      attributes: {'data-slot': 'drawer-header'},
    );
  }
}

class ShadDrawerFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDrawerFooter(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['mt-auto flex flex-col gap-2 p-4', className]),
      attributes: {'data-slot': 'drawer-footer'},
    );
  }
}

class ShadDrawerTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDrawerTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-lg font-semibold leading-none tracking-tight', className]),
      attributes: {'data-slot': 'drawer-title'},
    );
  }
}

class ShadDrawerDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDrawerDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'drawer-description'},
    );
  }
}

class ShadDrawerClose extends StatelessComponent {
  final List<Component> children;

  const ShadDrawerClose(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadDrawerScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onOpenChange(false)},
      attributes: {'data-slot': 'drawer-close'},
    );
  }
}
