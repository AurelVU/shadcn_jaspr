import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadDropdownMenu extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadDropdownMenu({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadDropdownMenu> createState() => _ShadDropdownMenuState();
}

class _ShadDropdownMenuState extends State<ShadDropdownMenu> {
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
    yield _ShadDropdownMenuScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      child: div(
        component.children,
        classes: 'relative inline-block',
        attributes: {'data-slot': 'dropdown-menu'},
      ),
    );
  }
}

class _ShadDropdownMenuScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;

  const _ShadDropdownMenuScope({
    required this.isOpen,
    required this.onOpenChange,
    required super.child,
  });

  static _ShadDropdownMenuScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadDropdownMenuScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadDropdownMenuScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadDropdownMenuTrigger extends StatelessComponent {
  final List<Component> children;

  const ShadDropdownMenuTrigger(this.children, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDropdownMenuScope.of(context);
    yield div(
      children,
      events: {'click': (_) => scope.onOpenChange(!scope.isOpen)},
      attributes: {'data-slot': 'dropdown-menu-trigger'},
    );
  }
}

class ShadDropdownMenuContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadDropdownMenuContent(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDropdownMenuScope.of(context);
    if (!scope.isOpen) return;

    yield div(
      children,
      classes: cn([
        'absolute z-50 mt-1 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
        className,
      ]),
      attributes: {
        'data-slot': 'dropdown-menu-content',
        'data-state': 'open',
        'role': 'menu',
      },
    );
  }
}

enum DropdownMenuItemVariant { defaultVariant, destructive }

class ShadDropdownMenuItem extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onSelect;
  final bool isDisabled;
  final bool inset;
  final DropdownMenuItemVariant variant;
  final String? className;

  const ShadDropdownMenuItem(
    this.children, {
    this.onSelect,
    this.isDisabled = false,
    this.inset = false,
    this.variant = DropdownMenuItemVariant.defaultVariant,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadDropdownMenuScope.of(context);
    yield div(
      children,
      classes: cn([
        'relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 data-[inset]:pl-8 data-[variant=destructive]:text-destructive data-[variant=destructive]:hover:bg-destructive/10 data-[variant=destructive]:hover:text-destructive [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*=\'size-\'])]:size-4 [&_svg:not([class*=\'text-\'])]:text-muted-foreground',
        className,
      ]),
      events: {
        'click': (_) {
          onSelect?.call();
          scope.onOpenChange(false);
        },
      },
      attributes: {
        'data-slot': 'dropdown-menu-item',
        'role': 'menuitem',
        if (isDisabled) 'data-disabled': '',
        if (inset) 'data-inset': 'true',
        'data-variant': variant == DropdownMenuItemVariant.destructive
            ? 'destructive'
            : 'default',
      },
    );
  }
}

class ShadDropdownMenuSeparator extends StatelessComponent {
  final String? className;

  const ShadDropdownMenuSeparator({this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      [],
      classes: cn(['pointer-events-none -mx-1 my-1 h-px bg-border', className]),
      attributes: {
        'data-slot': 'dropdown-menu-separator',
        'role': 'separator',
      },
    );
  }
}

class ShadDropdownMenuLabel extends StatelessComponent {
  final List<Component> children;
  final bool inset;
  final String? className;

  const ShadDropdownMenuLabel(
    this.children, {
    this.inset = false,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn([
        'px-2 py-1.5 text-sm font-medium',
        if (inset) 'pl-8',
        className,
      ]),
      attributes: {
        'data-slot': 'dropdown-menu-label',
        if (inset) 'data-inset': 'true',
      },
    );
  }
}
