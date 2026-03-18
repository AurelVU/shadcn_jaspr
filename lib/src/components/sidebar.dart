import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum SidebarSide { left, right }

enum SidebarVariant { sidebar, floating, inset }

enum SidebarCollapsible { offcanvas, icon, none }

class ShadSidebarProvider extends StatefulComponent {
  final bool? open;
  final ValueChanged<bool>? onOpenChange;
  final List<Component> children;

  const ShadSidebarProvider({
    this.open,
    this.onOpenChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadSidebarProvider> createState() => _ShadSidebarProviderState();
}

class _ShadSidebarProviderState extends State<ShadSidebarProvider> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = component.open ?? true;
  }

  void _setOpen(bool value) {
    setState(() {
      _isOpen = value;
    });
    component.onOpenChange?.call(value);
  }

  void _toggle() => _setOpen(!_isOpen);

  @override
  Component build(BuildContext context) {
    return _ShadSidebarScope(
      isOpen: _isOpen,
      onOpenChange: _setOpen,
      onToggle: _toggle,
      child: div(
        component.children,
        classes: cn([
          'group/sidebar-wrapper flex min-h-svh w-full',
          if (_isOpen) 'has-[[data-variant=inset]]:bg-sidebar',
        ]),
        attributes: {
          'data-slot': 'sidebar-wrapper',
          'data-state': _isOpen ? 'expanded' : 'collapsed',
        },
      ),
    );
  }
}

class _ShadSidebarScope extends InheritedComponent {
  final bool isOpen;
  final ValueChanged<bool> onOpenChange;
  final VoidCallback onToggle;

  const _ShadSidebarScope({
    required this.isOpen,
    required this.onOpenChange,
    required this.onToggle,
    required super.child,
  });

  static _ShadSidebarScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadSidebarScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadSidebarScope oldComponent) {
    return isOpen != oldComponent.isOpen;
  }
}

class ShadSidebar extends StatelessComponent {
  final SidebarSide side;
  final SidebarVariant variant;
  final SidebarCollapsible collapsible;
  final List<Component> children;
  final String? className;

  const ShadSidebar({
    this.side = SidebarSide.left,
    this.variant = SidebarVariant.sidebar,
    this.collapsible = SidebarCollapsible.offcanvas,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadSidebarScope.of(context);

    if (collapsible == SidebarCollapsible.none) {
      return div(
        [
          div(
            children,
            classes: cn([
              'flex h-full w-[--sidebar-width] flex-col bg-sidebar text-sidebar-foreground',
              className,
            ]),
          ),
        ],
        classes: 'flex h-svh w-[--sidebar-width] flex-col',
        attributes: {'data-slot': 'sidebar'},
      );
    }

    return Component.fragment([
      div(
        [
          div(
            [
              div(
                children,
                classes: cn([
                  'flex h-full w-full flex-col bg-sidebar text-sidebar-foreground group-data-[variant=floating]:rounded-lg group-data-[variant=floating]:border group-data-[variant=floating]:shadow-sm',
                  className,
                ]),
                attributes: {'data-slot': 'sidebar-inner'},
              ),
            ],
            classes: cn([
              'relative h-svh w-[--sidebar-width] bg-transparent transition-[width] duration-200 ease-linear',
              if (!scope.isOpen &&
                  collapsible == SidebarCollapsible.icon)
                'w-[--sidebar-width-icon]',
              if (!scope.isOpen &&
                  collapsible == SidebarCollapsible.offcanvas)
                'w-0',
              'group-data-[side=right]:rotate-180',
            ]),
          ),
        ],
        classes: cn([
          'group peer',
          if (!scope.isOpen) 'text-sidebar-foreground',
        ]),
        attributes: {
          'data-slot': 'sidebar',
          'data-state': scope.isOpen ? 'expanded' : 'collapsed',
          'data-collapsible': scope.isOpen ? '' : collapsible.name,
          'data-variant': variant.name,
          'data-side': side.name,
        },
      ),
    ]);
  }
}

class ShadSidebarHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-2 p-2', className]),
      attributes: {'data-slot': 'sidebar-header'},
    );
  }
}

class ShadSidebarFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarFooter(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-2 p-2', className]),
      attributes: {'data-slot': 'sidebar-footer'},
    );
  }
}

class ShadSidebarContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex min-h-0 flex-1 flex-col gap-2 overflow-auto group-data-[collapsible=icon]:overflow-hidden',
        className,
      ]),
      attributes: {'data-slot': 'sidebar-content'},
    );
  }
}

class ShadSidebarGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['relative flex w-full min-w-0 flex-col p-2', className]),
      attributes: {'data-slot': 'sidebar-group'},
    );
  }
}

class ShadSidebarGroupLabel extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarGroupLabel(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex h-8 shrink-0 items-center rounded-md px-2 text-xs font-medium text-sidebar-foreground/70 outline-none ring-sidebar-ring transition-[margin,opa] duration-200 ease-linear focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0 group-data-[collapsible=icon]:-mt-8 group-data-[collapsible=icon]:opacity-0',
        className,
      ]),
      attributes: {'data-slot': 'sidebar-group-label'},
    );
  }
}

class ShadSidebarGroupContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarGroupContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['w-full text-sm', className]),
      attributes: {'data-slot': 'sidebar-group-content'},
    );
  }
}

class ShadSidebarMenu extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarMenu(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'ul',
      classes: cn(['flex w-full min-w-0 flex-col gap-1', className]),
      attributes: {'data-slot': 'sidebar-menu'},
      children: children,
    );
  }
}

class ShadSidebarMenuItem extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarMenuItem(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'li',
      classes: cn(['group/menu-item relative', className]),
      attributes: {'data-slot': 'sidebar-menu-item'},
      children: children,
    );
  }
}

class ShadSidebarMenuButton extends StatelessComponent {
  final List<Component> children;
  final bool isActive;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? className;

  const ShadSidebarMenuButton(
    this.children, {
    this.isActive = false,
    this.onPressed,
    this.tooltip,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      children,
      onClick: onPressed,
      classes: cn([
        'peer/menu-button flex w-full items-center gap-2 overflow-hidden rounded-md p-2 text-left text-sm outline-none ring-sidebar-ring transition-[width,height,padding] hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 group-has-[[data-slot=sidebar-menu-action]]/menu-item:pr-8 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-[active=true]:bg-sidebar-accent data-[active=true]:font-medium data-[active=true]:text-sidebar-accent-foreground data-[state=open]:hover:bg-sidebar-accent data-[state=open]:hover:text-sidebar-accent-foreground group-data-[collapsible=icon]:size-8 group-data-[collapsible=icon]:!p-2 [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0',
        className,
      ]),
      attributes: {
        'data-slot': 'sidebar-menu-button',
        'data-active': isActive.toString(),
        if (tooltip != null) 'title': tooltip!,
      },
    );
  }
}

class ShadSidebarMenuAction extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onPressed;
  final String? className;

  const ShadSidebarMenuAction(
    this.children, {
    this.onPressed,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      children,
      onClick: onPressed,
      classes: cn([
        'absolute right-1 top-1.5 flex aspect-square w-5 items-center justify-center rounded-md p-0 text-sidebar-foreground outline-none ring-sidebar-ring transition-transform hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 peer-hover/menu-button:text-sidebar-accent-foreground [&>svg]:size-4 [&>svg]:shrink-0 after:absolute after:-inset-2 after:md:hidden',
        className,
      ]),
      attributes: {'data-slot': 'sidebar-menu-action'},
    );
  }
}

class ShadSidebarMenuSub extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarMenuSub(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'ul',
      classes: cn([
        'mx-3.5 flex min-w-0 translate-x-px flex-col gap-1 border-l border-sidebar-border px-2.5 py-0.5 group-data-[collapsible=icon]:hidden',
        className,
      ]),
      attributes: {'data-slot': 'sidebar-menu-sub'},
      children: children,
    );
  }
}

class ShadSidebarMenuSubItem extends StatelessComponent {
  final List<Component> children;

  const ShadSidebarMenuSubItem(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'li',
      attributes: {'data-slot': 'sidebar-menu-sub-item'},
      children: children,
    );
  }
}

class ShadSidebarMenuSubButton extends StatelessComponent {
  final String? href;
  final bool isActive;
  final List<Component> children;
  final String? className;

  const ShadSidebarMenuSubButton(
    this.children, {
    this.href,
    this.isActive = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: href != null ? 'a' : 'button',
      classes: cn([
        'flex h-7 min-w-0 -translate-x-px items-center gap-2 overflow-hidden rounded-md px-2 text-sidebar-foreground outline-none ring-sidebar-ring hover:bg-sidebar-accent hover:text-sidebar-accent-foreground focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0 [&>svg]:text-sidebar-accent-foreground text-xs',
        if (isActive) 'bg-sidebar-accent text-sidebar-accent-foreground',
        className,
      ]),
      attributes: {
        'data-slot': 'sidebar-menu-sub-button',
        'data-active': isActive.toString(),
        if (href != null) 'href': href!,
      },
      children: children,
    );
  }
}

class ShadSidebarSeparator extends StatelessComponent {
  final String? className;

  const ShadSidebarSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['mx-2 w-auto bg-sidebar-border h-px', className]),
      attributes: {
        'data-slot': 'sidebar-separator',
        'role': 'separator',
      },
    );
  }
}

class ShadSidebarTrigger extends StatelessComponent {
  final String? className;

  const ShadSidebarTrigger({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadSidebarScope.of(context);
    return button(
      [
        Component.element(
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
            Component.element(
              tag: 'rect',
              attributes: {
                'width': '18',
                'height': '18',
                'x': '3',
                'y': '3',
                'rx': '2',
              },
            ),
            Component.element(
              tag: 'path',
              attributes: {'d': 'M9 3v18'},
            ),
          ],
        ),
        span([Component.text('Toggle Sidebar')], classes: 'sr-only'),
      ],
      onClick: scope.onToggle,
      classes: cn([
        'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground h-7 w-7',
        className,
      ]),
      attributes: {
        'data-slot': 'sidebar-trigger',
      },
    );
  }
}

class ShadSidebarInset extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSidebarInset(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'main',
      classes: cn([
        'relative flex min-h-svh flex-1 flex-col bg-background peer-data-[variant=inset]:min-h-[calc(100svh-theme(spacing.4))] md:peer-data-[variant=inset]:m-2 md:peer-data-[state=collapsed]:peer-data-[variant=inset]:ml-2 md:peer-data-[variant=inset]:ml-0 md:peer-data-[variant=inset]:rounded-xl md:peer-data-[variant=inset]:shadow-sm',
        className,
      ]),
      attributes: {'data-slot': 'sidebar-inset'},
      children: children,
    );
  }
}

class ShadSidebarRail extends StatelessComponent {
  final String? className;

  const ShadSidebarRail({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadSidebarScope.of(context);
    return button(
      [],
      onClick: scope.onToggle,
      classes: cn([
        'absolute inset-y-0 z-20 hidden w-4 -translate-x-1/2 transition-all ease-linear after:absolute after:inset-y-0 after:left-1/2 after:w-[2px] hover:after:bg-sidebar-border group-data-[side=left]:-right-4 group-data-[side=right]:left-0 sm:flex [[data-side=left]_&]:cursor-w-resize [[data-side=right]_&]:cursor-e-resize [[data-side=left][data-state=collapsed]_&]:cursor-e-resize [[data-side=right][data-state=collapsed]_&]:cursor-w-resize group-data-[collapsible=offcanvas]:translate-x-0 group-data-[collapsible=offcanvas]:after:left-full group-data-[collapsible=offcanvas]:hover:bg-sidebar [[data-side=left][data-collapsible=offcanvas]_&]:-right-2 [[data-side=right][data-collapsible=offcanvas]_&]:-left-2',
        className,
      ]),
      attributes: {
        'data-slot': 'sidebar-rail',
        'aria-label': 'Toggle Sidebar',
        'tabindex': '-1',
      },
    );
  }
}
