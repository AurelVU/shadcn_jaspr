import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadAlertDialog extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadAlertDialog({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadAlertDialog> createState() => _ShadAlertDialogState();
}

class _ShadAlertDialogState extends State<ShadAlertDialog> {
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
    return _ShadAlertDialogScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(component.children),
    );
  }
}

class _ShadAlertDialogScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadAlertDialogScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadAlertDialogScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadAlertDialogScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadAlertDialogScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadAlertDialogTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadAlertDialogTrigger(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadAlertDialogScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onOpenChange(true)},
      attributes: {'data-slot': 'alert-dialog-trigger'},
    );
  }
}

class ShadAlertDialogContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDialogContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadAlertDialogScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return Component.fragment([
      // Overlay — clicking does NOT close (unlike Dialog)
      div(
        [],
        classes: 'fixed inset-0 z-50 bg-black/50 animate-in fade-in-0',
        attributes: {
          'data-slot': 'alert-dialog-overlay',
          'data-state': 'open',
        },
      ),
      // Content
      div(
        children,
        classes: cn([
          'fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-lg border bg-background p-6 shadow-lg duration-200 animate-in fade-in-0 zoom-in-95 sm:max-w-lg',
          className,
        ]),
        attributes: {
          'data-slot': 'alert-dialog-content',
          'data-state': 'open',
          'role': 'alertdialog',
          'aria-modal': 'true',
        },
      ),
    ]);
  }
}

class ShadAlertDialogHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDialogHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-2 text-center sm:text-left', className]),
      attributes: {'data-slot': 'alert-dialog-header'},
    );
  }
}

class ShadAlertDialogFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDialogFooter(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex flex-col-reverse gap-2 sm:flex-row sm:justify-end',
        className,
      ]),
      attributes: {'data-slot': 'alert-dialog-footer'},
    );
  }
}

class ShadAlertDialogTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDialogTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-lg font-semibold', className]),
      attributes: {'data-slot': 'alert-dialog-title'},
    );
  }
}

class ShadAlertDialogDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDialogDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'alert-dialog-description'},
    );
  }
}

class ShadAlertDialogAction extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onAction;

  const ShadAlertDialogAction(this.children, {this.onAction, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadAlertDialogScope.of(context);
    return div(
      children,
      events: {
        'click': (_) {
          onAction?.call();
          scope.onOpenChange(false);
        },
      },
      attributes: {'data-slot': 'alert-dialog-action'},
    );
  }
}

class ShadAlertDialogCancel extends StatelessComponent {
  final List<Component> children;

  const ShadAlertDialogCancel(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadAlertDialogScope.of(context);
    return div(
      children,
      events: {'click': (_) => scope.onOpenChange(false)},
      attributes: {'data-slot': 'alert-dialog-cancel'},
    );
  }
}
