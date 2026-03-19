import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:universal_web/web.dart' as web;

import '../utils/cn.dart';

class ShadContextMenu extends StatefulComponent {
  final List<Component> children;

  const ShadContextMenu({required this.children, super.key});

  @override
  State<ShadContextMenu> createState() => _ShadContextMenuState();
}

class _ShadContextMenuState extends State<ShadContextMenu> {
  bool _isOpen = false;
  double _x = 0;
  double _y = 0;

  void _onContextMenu(dynamic event) {
    final e = event as web.MouseEvent;
    e.preventDefault();
    setState(() {
      _isOpen = true;
      _x = e.clientX.toDouble();
      _y = e.clientY.toDouble();
    });
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadContextMenuScope(
      isOpen: _isOpen,
      x: _x,
      y: _y,
      onContextMenu: _onContextMenu,
      onClose: _close,
      child: div(
        component.children,
        attributes: {'data-slot': 'context-menu'},
      ),
    );
  }
}

class _ShadContextMenuScope extends InheritedComponent {
  final bool isOpen;
  final double x;
  final double y;
  final void Function(dynamic) onContextMenu;
  final VoidCallback onClose;

  const _ShadContextMenuScope({
    required this.isOpen,
    required this.x,
    required this.y,
    required this.onContextMenu,
    required this.onClose,
    required super.child,
  });

  static _ShadContextMenuScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadContextMenuScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadContextMenuScope oldComponent) {
    return isOpen != oldComponent.isOpen ||
        x != oldComponent.x ||
        y != oldComponent.y;
  }
}

class ShadContextMenuTrigger extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadContextMenuTrigger(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadContextMenuScope.of(context);
    return div(
      children,
      classes: cn([className]),
      events: {'contextmenu': scope.onContextMenu},
      attributes: {'data-slot': 'context-menu-trigger'},
    );
  }
}

class ShadContextMenuContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadContextMenuContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadContextMenuScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return Component.fragment([
      // Invisible backdrop to catch clicks and close the menu
      div(
        [],
        classes: 'fixed inset-0 z-40',
        events: {
          'click': (_) => scope.onClose(),
          'contextmenu': (dynamic event) {
            (event as web.Event).preventDefault();
            scope.onClose();
          },
        },
      ),
      div(
        children,
        classes: cn([
          'fixed z-50 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
          className,
        ]),
        attributes: {
          'data-slot': 'context-menu-content',
          'data-state': 'open',
          'role': 'menu',
          'style': 'left: ${scope.x}px; top: ${scope.y}px',
        },
      ),
    ]);
  }
}

enum ContextMenuItemVariant { defaultVariant, destructive }

class ShadContextMenuItem extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onSelect;
  final bool isDisabled;
  final bool inset;
  final ContextMenuItemVariant variant;
  final String? className;

  const ShadContextMenuItem(
    this.children, {
    this.onSelect,
    this.isDisabled = false,
    this.inset = false,
    this.variant = ContextMenuItemVariant.defaultVariant,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadContextMenuScope.of(context);
    return div(
      children,
      classes: cn([
        'relative flex cursor-default items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-hidden select-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 data-[inset]:pl-8 data-[variant=destructive]:text-destructive data-[variant=destructive]:hover:bg-destructive/10 [&_svg]:pointer-events-none [&_svg]:shrink-0',
        className,
      ]),
      events: {
        'click': (_) {
          onSelect?.call();
          scope.onClose();
        },
      },
      attributes: {
        'data-slot': 'context-menu-item',
        'role': 'menuitem',
        if (isDisabled) 'data-disabled': '',
        if (inset) 'data-inset': 'true',
        'data-variant': variant == ContextMenuItemVariant.destructive
            ? 'destructive'
            : 'default',
      },
    );
  }
}

class ShadContextMenuSeparator extends StatelessComponent {
  final String? className;

  const ShadContextMenuSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(
          ['pointer-events-none -mx-1 my-1 h-px bg-border', className]),
      attributes: {
        'data-slot': 'context-menu-separator',
        'role': 'separator',
      },
    );
  }
}

class ShadContextMenuLabel extends StatelessComponent {
  final List<Component> children;
  final bool inset;
  final String? className;

  const ShadContextMenuLabel(
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
        'data-slot': 'context-menu-label',
        if (inset) 'data-inset': 'true',
      },
    );
  }
}

class ShadContextMenuCheckboxItem extends StatelessComponent {
  final List<Component> children;
  final bool checked;
  final VoidCallback? onSelect;
  final String? className;

  const ShadContextMenuCheckboxItem(
    this.children, {
    this.checked = false,
    this.onSelect,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadContextMenuScope.of(context);
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
          scope.onClose();
        },
      },
      attributes: {
        'data-slot': 'context-menu-checkbox-item',
        'role': 'menuitemcheckbox',
        'aria-checked': checked.toString(),
        'data-state': checked ? 'checked' : 'unchecked',
      },
    );
  }
}

class ShadContextMenuRadioGroup extends StatelessComponent {
  final String? value;
  final List<Component> children;

  const ShadContextMenuRadioGroup({
    this.value,
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return _ShadContextMenuRadioScope(
      value: value,
      child: div(
        children,
        attributes: {
          'data-slot': 'context-menu-radio-group',
          'role': 'group',
        },
      ),
    );
  }
}

class _ShadContextMenuRadioScope extends InheritedComponent {
  final String? value;

  const _ShadContextMenuRadioScope({
    required this.value,
    required super.child,
  });

  static _ShadContextMenuRadioScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadContextMenuRadioScope>()!;
  }

  @override
  bool updateShouldNotify(
      covariant _ShadContextMenuRadioScope oldComponent) {
    return value != oldComponent.value;
  }
}

class ShadContextMenuRadioItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final VoidCallback? onSelect;
  final String? className;

  const ShadContextMenuRadioItem({
    required this.value,
    required this.children,
    this.onSelect,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadContextMenuScope.of(context);
    final radioScope = _ShadContextMenuRadioScope.of(context);
    final isSelected = radioScope.value == value;

    return div(
      [
        span(
          [
            if (isSelected)
              Component.element(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '8',
                  'height': '8',
                  'viewBox': '0 0 24 24',
                  'fill': 'currentColor',
                  'stroke': 'none',
                },
                children: [
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '12', 'cy': '12', 'r': '12'},
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
          scope.onClose();
        },
      },
      attributes: {
        'data-slot': 'context-menu-radio-item',
        'role': 'menuitemradio',
        'aria-checked': isSelected.toString(),
        'data-state': isSelected ? 'checked' : 'unchecked',
      },
    );
  }
}

class ShadContextMenuShortcut extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadContextMenuShortcut(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'ml-auto text-xs tracking-widest text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'context-menu-shortcut'},
    );
  }
}
