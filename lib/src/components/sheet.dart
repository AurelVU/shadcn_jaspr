import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

enum SheetSide { top, right, bottom, left }

class ShadSheet extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadSheet({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadSheet> createState() => _ShadSheetState();
}

class _ShadSheetState extends State<ShadSheet> {
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
  Iterable<Component> build(BuildContext context) sync* {
    yield _ShadSheetScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(component.children),
    );
  }
}

class _ShadSheetScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadSheetScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadSheetScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadSheetScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadSheetScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadSheetTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadSheetTrigger(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadSheetScope.of(context);
    yield div(
      children,
      events: {'click': (_) => scope.onOpenChange(true)},
      attributes: {'data-slot': 'sheet-trigger'},
    );
  }
}

class ShadSheetContent extends StatelessComponent {
  final List<Component> children;
  final SheetSide side;
  final bool showCloseButton;
  final String? className;

  const ShadSheetContent(
    this.children, {
    this.side = SheetSide.right,
    this.showCloseButton = true,
    this.className,
    super.key,
  });

  String _sideClasses() {
    switch (side) {
      case SheetSide.right:
        return 'inset-y-0 right-0 h-full w-3/4 border-l data-[state=open]:slide-in-from-right sm:max-w-sm';
      case SheetSide.left:
        return 'inset-y-0 left-0 h-full w-3/4 border-r data-[state=open]:slide-in-from-left sm:max-w-sm';
      case SheetSide.top:
        return 'inset-x-0 top-0 h-auto border-b data-[state=open]:slide-in-from-top';
      case SheetSide.bottom:
        return 'inset-x-0 bottom-0 h-auto border-t data-[state=open]:slide-in-from-bottom';
    }
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadSheetScope.of(context);
    if (!scope.isOpen) return;

    // Overlay
    yield div(
      [],
      classes: 'fixed inset-0 z-50 bg-black/50 animate-in fade-in-0',
      attributes: {'data-slot': 'sheet-overlay', 'data-state': 'open'},
      events: {'click': (_) => scope.onOpenChange(false)},
    );
    // Content
    yield div(
      [
        ...children,
        if (showCloseButton)
          button(
            [
              DomComponent(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '16',
                  'height': '16',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '2',
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                children: [
                  DomComponent(tag: 'path', attributes: {'d': 'M18 6 6 18'}),
                  DomComponent(tag: 'path', attributes: {'d': 'm6 6 12 12'}),
                ],
              ),
              span([text('Close')], classes: 'sr-only'),
            ],
            onClick: () => scope.onOpenChange(false),
            classes:
                'absolute top-4 right-4 rounded-xs opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none',
            attributes: {'data-slot': 'sheet-close'},
          ),
      ],
      classes: cn([
        'fixed z-50 flex flex-col gap-4 bg-background shadow-lg transition ease-in-out animate-in duration-500',
        _sideClasses(),
        className,
      ]),
      attributes: {
        'data-slot': 'sheet-content',
        'data-state': 'open',
        'data-side': side.name,
        'role': 'dialog',
        'aria-modal': 'true',
      },
    );
  }
}

class ShadSheetHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSheetHeader(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['flex flex-col gap-1.5 p-4', className]),
      attributes: {'data-slot': 'sheet-header'},
    );
  }
}

class ShadSheetFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSheetFooter(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['mt-auto flex flex-col gap-2 p-4', className]),
      attributes: {'data-slot': 'sheet-footer'},
    );
  }
}

class ShadSheetTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSheetTitle(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['font-semibold text-foreground', className]),
      attributes: {'data-slot': 'sheet-title'},
    );
  }
}

class ShadSheetDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSheetDescription(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'sheet-description'},
    );
  }
}

class ShadSheetClose extends StatelessComponent {
  final List<Component> children;

  const ShadSheetClose(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadSheetScope.of(context);
    yield div(
      children,
      events: {'click': (_) => scope.onOpenChange(false)},
      attributes: {'data-slot': 'sheet-close'},
    );
  }
}
