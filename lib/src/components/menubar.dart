import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadMenubar extends StatefulComponent {
  final List<Component> children;
  final String? className;

  const ShadMenubar({required this.children, this.className, super.key});

  @override
  State<ShadMenubar> createState() => _ShadMenubarState();
}

class _ShadMenubarState extends State<ShadMenubar> {
  String? _openMenu;

  void _setOpenMenu(String? value) {
    setState(() {
      _openMenu = value;
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadMenubarScope(
      openMenu: _openMenu,
      onMenuChange: _setOpenMenu,
      child: div(
        component.children,
        classes: cn([
          'flex h-9 items-center gap-1 rounded-md border bg-background p-1 shadow-xs',
          component.className,
        ]),
        attributes: {
          'data-slot': 'menubar',
          'role': 'menubar',
        },
      ),
    );
  }
}

class _ShadMenubarScope extends InheritedComponent {
  final String? openMenu;
  final ValueChanged<String?> onMenuChange;

  const _ShadMenubarScope({
    required this.openMenu,
    required this.onMenuChange,
    required super.child,
  });

  static _ShadMenubarScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadMenubarScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadMenubarScope oldComponent) {
    return openMenu != oldComponent.openMenu;
  }
}

class ShadMenubarMenu extends StatelessComponent {
  final String value;
  final List<Component> children;

  const ShadMenubarMenu({
    required this.value,
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return _ShadMenubarMenuScope(
      value: value,
      child: div(
        children,
        classes: 'relative',
        attributes: {
          'data-slot': 'menubar-menu',
          'data-value': value,
        },
      ),
    );
  }
}

class _ShadMenubarMenuScope extends InheritedComponent {
  final String value;

  const _ShadMenubarMenuScope({
    required this.value,
    required super.child,
  });

  static _ShadMenubarMenuScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadMenubarMenuScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadMenubarMenuScope oldComponent) {
    return value != oldComponent.value;
  }
}

class ShadMenubarTrigger extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadMenubarTrigger(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadMenubarScope.of(context);
    final menuScope = _ShadMenubarMenuScope.of(context);
    final isOpen = scope.openMenu == menuScope.value;

    return button(
      children,
      onClick: () {
        scope.onMenuChange(isOpen ? null : menuScope.value);
      },
      classes: cn([
        'flex items-center rounded-sm px-2 py-1 text-sm font-medium outline-none cursor-default select-none focus:bg-accent focus:text-accent-foreground data-[state=open]:bg-accent data-[state=open]:text-accent-foreground',
        className,
      ]),
      events: {
        'mouseenter': (_) {
          if (scope.openMenu != null) {
            scope.onMenuChange(menuScope.value);
          }
        },
      },
      attributes: {
        'data-slot': 'menubar-trigger',
        'data-state': isOpen ? 'open' : 'closed',
        'role': 'menuitem',
        'aria-haspopup': 'true',
        'aria-expanded': isOpen.toString(),
      },
    );
  }
}

class ShadMenubarContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadMenubarContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadMenubarScope.of(context);
    final menuScope = _ShadMenubarMenuScope.of(context);
    if (scope.openMenu != menuScope.value) return Component.fragment([]);

    return Component.fragment([
      // Backdrop
      div(
        [],
        classes: 'fixed inset-0 z-40',
        events: {'click': (_) => scope.onMenuChange(null)},
      ),
      div(
        children,
        classes: cn([
          'absolute left-0 top-full z-50 mt-1 min-w-[12rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
          className,
        ]),
        attributes: {
          'data-slot': 'menubar-content',
          'data-state': 'open',
          'role': 'menu',
        },
      ),
    ]);
  }
}

enum MenubarItemVariant { defaultVariant, destructive }

class ShadMenubarItem extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onSelect;
  final bool isDisabled;
  final bool inset;
  final MenubarItemVariant variant;
  final String? className;

  const ShadMenubarItem(
    this.children, {
    this.onSelect,
    this.isDisabled = false,
    this.inset = false,
    this.variant = MenubarItemVariant.defaultVariant,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadMenubarScope.of(context);
    return div(
      children,
      classes: cn([
        'relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 data-[inset]:pl-8 data-[variant=destructive]:text-destructive data-[variant=destructive]:hover:bg-destructive/10 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*=\'size-\'])]:size-4 [&_svg:not([class*=\'text-\'])]:text-muted-foreground',
        className,
      ]),
      events: {
        'click': (_) {
          onSelect?.call();
          scope.onMenuChange(null);
        },
      },
      attributes: {
        'data-slot': 'menubar-item',
        'role': 'menuitem',
        if (isDisabled) 'data-disabled': '',
        if (inset) 'data-inset': 'true',
        'data-variant': variant == MenubarItemVariant.destructive
            ? 'destructive'
            : 'default',
      },
    );
  }
}

class ShadMenubarSeparator extends StatelessComponent {
  final String? className;

  const ShadMenubarSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['pointer-events-none -mx-1 my-1 h-px bg-border', className]),
      attributes: {
        'data-slot': 'menubar-separator',
        'role': 'separator',
      },
    );
  }
}

class ShadMenubarLabel extends StatelessComponent {
  final List<Component> children;
  final bool inset;
  final String? className;

  const ShadMenubarLabel(
    this.children, {
    this.inset = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'px-2 py-1.5 text-sm font-medium',
        if (inset) 'pl-8',
        className,
      ]),
      attributes: {
        'data-slot': 'menubar-label',
        if (inset) 'data-inset': 'true',
      },
    );
  }
}

class ShadMenubarCheckboxItem extends StatelessComponent {
  final List<Component> children;
  final bool checked;
  final VoidCallback? onSelect;
  final String? className;

  const ShadMenubarCheckboxItem(
    this.children, {
    this.checked = false,
    this.onSelect,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadMenubarScope.of(context);
    return div(
      [
        span(
          [
            if (checked)
              Component.element(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '14',
                  'height': '14',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '3',
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                children: [
                  Component.element(
                    tag: 'path',
                    attributes: {'d': 'M20 6 9 17l-5-5'},
                  ),
                ],
              ),
          ],
          classes:
              'absolute left-2 flex size-3.5 items-center justify-center',
        ),
        ...children,
      ],
      classes: cn([
        'relative flex cursor-default select-none items-center rounded-sm py-1.5 pr-2 pl-8 text-sm outline-hidden hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
        className,
      ]),
      events: {
        'click': (_) {
          onSelect?.call();
          scope.onMenuChange(null);
        },
      },
      attributes: {
        'data-slot': 'menubar-checkbox-item',
        'role': 'menuitemcheckbox',
        'aria-checked': checked.toString(),
        'data-state': checked ? 'checked' : 'unchecked',
      },
    );
  }
}

class ShadMenubarShortcut extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadMenubarShortcut(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'ml-auto text-xs tracking-widest text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'menubar-shortcut'},
    );
  }
}
