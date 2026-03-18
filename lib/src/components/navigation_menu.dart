import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadNavigationMenu extends StatefulComponent {
  final List<Component> children;
  final String? className;

  const ShadNavigationMenu({required this.children, this.className, super.key});

  @override
  State<ShadNavigationMenu> createState() => _ShadNavigationMenuState();
}

class _ShadNavigationMenuState extends State<ShadNavigationMenu> {
  String? _activeItem;

  void _setActiveItem(String? value) {
    setState(() {
      _activeItem = value;
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadNavigationMenuScope(
      activeItem: _activeItem,
      onActiveItemChange: _setActiveItem,
      child: Component.element(
        tag: 'nav',
        classes: cn([
          'relative z-10 flex max-w-max flex-1 items-center justify-center',
          component.className,
        ]),
        attributes: {
          'data-slot': 'navigation-menu',
          'data-orientation': 'horizontal',
        },
        children: component.children,
      ),
    );
  }
}

class _ShadNavigationMenuScope extends InheritedComponent {
  final String? activeItem;
  final ValueChanged<String?> onActiveItemChange;

  const _ShadNavigationMenuScope({
    required this.activeItem,
    required this.onActiveItemChange,
    required super.child,
  });

  static _ShadNavigationMenuScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadNavigationMenuScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadNavigationMenuScope oldComponent) {
    return activeItem != oldComponent.activeItem;
  }
}

class ShadNavigationMenuList extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadNavigationMenuList(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'group flex flex-1 list-none items-center justify-center gap-1',
        className,
      ]),
      attributes: {
        'data-slot': 'navigation-menu-list',
        'role': 'menubar',
      },
    );
  }
}

class ShadNavigationMenuItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final String? className;

  const ShadNavigationMenuItem({
    required this.value,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return _ShadNavigationMenuItemScope(
      value: value,
      child: div(
        children,
        classes: cn(['relative', className]),
        attributes: {
          'data-slot': 'navigation-menu-item',
          'data-value': value,
        },
      ),
    );
  }
}

class _ShadNavigationMenuItemScope extends InheritedComponent {
  final String value;

  const _ShadNavigationMenuItemScope({
    required this.value,
    required super.child,
  });

  static _ShadNavigationMenuItemScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadNavigationMenuItemScope>()!;
  }

  @override
  bool updateShouldNotify(
      covariant _ShadNavigationMenuItemScope oldComponent) {
    return value != oldComponent.value;
  }
}

class ShadNavigationMenuTrigger extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadNavigationMenuTrigger(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadNavigationMenuScope.of(context);
    final itemScope = _ShadNavigationMenuItemScope.of(context);
    final isActive = scope.activeItem == itemScope.value;

    return button(
      [
        ...children,
        // Chevron
        Component.element(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '12',
            'height': '12',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
            'class':
                'relative top-px ml-1 size-3 transition duration-300 ${isActive ? 'rotate-180' : ''}',
          },
          children: [
            Component.element(
              tag: 'path',
              attributes: {'d': 'm6 9 6 6 6-6'},
            ),
          ],
        ),
      ],
      onClick: () {
        scope.onActiveItemChange(isActive ? null : itemScope.value);
      },
      classes: cn([
        'group inline-flex h-9 w-max items-center justify-center rounded-md bg-background px-4 py-2 text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground focus:outline-none disabled:pointer-events-none disabled:opacity-50 data-[state=open]:bg-accent/50',
        className,
      ]),
      events: {
        'mouseenter': (_) {
          scope.onActiveItemChange(itemScope.value);
        },
      },
      attributes: {
        'data-slot': 'navigation-menu-trigger',
        'data-state': isActive ? 'open' : 'closed',
        'aria-expanded': isActive.toString(),
      },
    );
  }
}

class ShadNavigationMenuContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadNavigationMenuContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadNavigationMenuScope.of(context);
    final itemScope = _ShadNavigationMenuItemScope.of(context);
    if (scope.activeItem != itemScope.value) return Component.fragment([]);

    return div(
      children,
      classes: cn([
        'absolute left-0 top-full mt-1.5 w-full animate-in fade-in-0 zoom-in-90 md:absolute md:w-auto',
        className,
      ]),
      events: {
        'mouseleave': (_) => scope.onActiveItemChange(null),
      },
      attributes: {
        'data-slot': 'navigation-menu-content',
        'data-state': 'open',
      },
    );
  }
}

class ShadNavigationMenuLink extends StatelessComponent {
  final String href;
  final List<Component> children;
  final bool isActive;
  final String? className;

  const ShadNavigationMenuLink({
    required this.href,
    required this.children,
    this.isActive = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'a',
      classes: cn([
        'block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none transition-colors hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground',
        if (isActive) 'bg-accent/50',
        className,
      ]),
      attributes: {
        'data-slot': 'navigation-menu-link',
        'href': href,
        if (isActive) 'data-active': '',
      },
      children: children,
    );
  }
}

class ShadNavigationMenuIndicator extends StatelessComponent {
  final String? className;

  const ShadNavigationMenuIndicator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadNavigationMenuScope.of(context);
    if (scope.activeItem == null) return Component.fragment([]);

    return div(
      [
        div(
          [],
          classes:
              'relative top-[60%] size-2 rotate-45 rounded-tl-sm bg-border shadow-md',
        ),
      ],
      classes: cn([
        'top-full z-[1] flex h-1.5 items-end justify-center overflow-hidden data-[state=visible]:animate-in data-[state=hidden]:animate-out data-[state=hidden]:fade-out data-[state=visible]:fade-in',
        className,
      ]),
      attributes: {
        'data-slot': 'navigation-menu-indicator',
        'data-state': 'visible',
      },
    );
  }
}
