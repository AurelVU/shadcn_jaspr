import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadDialog extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadDialog({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadDialog> createState() => _ShadDialogState();
}

class _ShadDialogState extends State<ShadDialog> {
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
    yield _ShadDialogScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(component.children),
    );
  }
}

class _ShadDialogScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadDialogScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadDialogScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadDialogScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadDialogScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadDialogTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadDialogTrigger(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDialogScope.of(context);
    yield div(
      children,
      events: {'click': (_) => scope.onOpenChange(true)},
      attributes: {'data-slot': 'dialog-trigger'},
    );
  }
}

class ShadDialogContent extends StatelessComponent {
  final List<Component> children;
  final bool showCloseButton;
  final String? className;

  const ShadDialogContent(
    this.children, {
    this.showCloseButton = true,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDialogScope.of(context);
    if (!scope.isOpen) return;

    // Overlay
    yield div(
      [],
      classes: 'fixed inset-0 z-50 bg-black/50 animate-in fade-in-0',
      attributes: {'data-slot': 'dialog-overlay', 'data-state': 'open'},
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
                'absolute top-4 right-4 rounded-xs opacity-70 ring-offset-background transition-opacity hover:opacity-100 focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:outline-hidden disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0',
            attributes: {'data-slot': 'dialog-close'},
          ),
      ],
      classes: cn([
        'fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border bg-background p-6 shadow-lg duration-200 outline-none animate-in fade-in-0 zoom-in-95 sm:max-w-lg',
        className,
      ]),
      attributes: {
        'data-slot': 'dialog-content',
        'data-state': 'open',
        'role': 'dialog',
        'aria-modal': 'true',
      },
    );
  }
}

class ShadDialogHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDialogHeader(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['flex flex-col gap-2 text-center sm:text-left', className]),
      attributes: {'data-slot': 'dialog-header'},
    );
  }
}

class ShadDialogFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDialogFooter(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn([
        'flex flex-col-reverse gap-2 sm:flex-row sm:justify-end',
        className,
      ]),
      attributes: {'data-slot': 'dialog-footer'},
    );
  }
}

class ShadDialogTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDialogTitle(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['text-lg leading-none font-semibold', className]),
      attributes: {'data-slot': 'dialog-title'},
    );
  }
}

class ShadDialogDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDialogDescription(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'dialog-description'},
    );
  }
}

class ShadDialogClose extends StatelessComponent {
  final List<Component> children;

  const ShadDialogClose(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDialogScope.of(context);
    yield div(
      children,
      events: {'click': (_) => scope.onOpenChange(false)},
      attributes: {'data-slot': 'dialog-close'},
    );
  }
}
