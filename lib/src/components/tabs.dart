import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum TabsListVariant { defaultVariant, line }

final _tabsListVariants = CVASimple<TabsListVariant>(
  base:
      'inline-flex w-fit items-center justify-center rounded-lg p-[3px] text-muted-foreground',
  variants: {
    TabsListVariant.defaultVariant: 'bg-muted',
    TabsListVariant.line: 'gap-1 bg-transparent rounded-none',
  },
  defaultVariant: TabsListVariant.defaultVariant,
);

class ShadTabs extends StatefulComponent {
  final String defaultValue;
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<Component> children;
  final String? className;

  const ShadTabs({
    required this.defaultValue,
    this.value,
    this.onValueChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadTabs> createState() => _ShadTabsState();
}

class _ShadTabsState extends State<ShadTabs> {
  late String _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = component.value ?? component.defaultValue;
  }

  void _selectTab(String value) {
    setState(() {
      _activeTab = value;
    });
    component.onValueChange?.call(value);
  }

  @override
  Component build(BuildContext context) {
    return _ShadTabsScope(
      activeTab: _activeTab,
      onSelect: _selectTab,
      child: div(
        component.children,
        classes: cn([
          'flex gap-2 flex-col',
          component.className,
        ]),
        attributes: {
          'data-slot': 'tabs',
          'data-orientation': 'horizontal',
        },
      ),
    );
  }
}

class _ShadTabsScope extends InheritedComponent {
  final String activeTab;
  final ValueChanged<String> onSelect;

  const _ShadTabsScope({
    required this.activeTab,
    required this.onSelect,
    required super.child,
  });

  static _ShadTabsScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadTabsScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadTabsScope oldComponent) {
    return activeTab != oldComponent.activeTab;
  }
}

class ShadTabsList extends StatelessComponent {
  final List<Component> children;
  final TabsListVariant? variant;
  final String? className;

  const ShadTabsList(
    this.children, {
    this.variant,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        _tabsListVariants.resolve(variant: variant),
        'h-9',
        className,
      ]),
      attributes: {
        'data-slot': 'tabs-list',
        'role': 'tablist',
        'data-variant': (variant ?? TabsListVariant.defaultVariant).name,
      },
    );
  }
}

class ShadTabsTrigger extends StatelessComponent {
  final String value;
  final List<Component> children;
  final bool isDisabled;
  final String? className;

  const ShadTabsTrigger({
    required this.value,
    required this.children,
    this.isDisabled = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadTabsScope.of(context);
    final isActive = scope.activeTab == value;

    return button(
      children,
      disabled: isDisabled,
      onClick: () => scope.onSelect(value),
      classes: cn([
        'relative inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-md border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap text-foreground/60 transition-all hover:text-foreground focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:pointer-events-none disabled:opacity-50 dark:text-muted-foreground dark:hover:text-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0',
        isActive
            ? 'bg-background text-foreground shadow-sm dark:border-input dark:bg-input/30 dark:text-foreground'
            : '',
        className,
      ]),
      attributes: {
        'data-slot': 'tabs-trigger',
        'role': 'tab',
        'data-state': isActive ? 'active' : 'inactive',
        'data-value': value,
        'aria-selected': isActive.toString(),
      },
    );
  }
}

class ShadTabsContent extends StatelessComponent {
  final String value;
  final List<Component> children;
  final String? className;

  const ShadTabsContent({
    required this.value,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadTabsScope.of(context);
    final isActive = scope.activeTab == value;

    if (!isActive) return Component.fragment([]);

    return div(
      children,
      classes: cn(['flex-1 outline-none', className]),
      attributes: {
        'data-slot': 'tabs-content',
        'role': 'tabpanel',
        'data-state': 'active',
        'data-value': value,
      },
    );
  }
}
