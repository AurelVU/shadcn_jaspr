import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadCommand extends StatefulComponent {
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<Component> children;
  final String? className;

  const ShadCommand({
    this.value,
    this.onValueChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadCommand> createState() => _ShadCommandState();
}

class _ShadCommandState extends State<ShadCommand> {
  late String _search;

  @override
  void initState() {
    super.initState();
    _search = component.value ?? '';
  }

  void _onSearchChange(String value) {
    setState(() {
      _search = value;
    });
    component.onValueChange?.call(value);
  }

  @override
  Component build(BuildContext context) {
    return _ShadCommandScope(
      search: _search,
      onSearchChange: _onSearchChange,
      child: div(
        component.children,
        classes: cn([
          'flex h-full w-full flex-col overflow-hidden rounded-md bg-popover text-popover-foreground',
          component.className,
        ]),
        attributes: {
          'data-slot': 'command',
          'role': 'combobox',
          'aria-expanded': 'true',
        },
      ),
    );
  }
}

class _ShadCommandScope extends InheritedComponent {
  final String search;
  final ValueChanged<String> onSearchChange;

  const _ShadCommandScope({
    required this.search,
    required this.onSearchChange,
    required super.child,
  });

  static _ShadCommandScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadCommandScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadCommandScope oldComponent) {
    return search != oldComponent.search;
  }
}

class ShadCommandInput extends StatelessComponent {
  final String? placeholder;
  final String? className;

  const ShadCommandInput({this.placeholder, this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCommandScope.of(context);
    return div(
      [
        // Search icon
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
            'class': 'mr-2 size-4 shrink-0 opacity-50',
          },
          children: [
            Component.element(
              tag: 'circle',
              attributes: {'cx': '11', 'cy': '11', 'r': '8'},
            ),
            Component.element(
              tag: 'path',
              attributes: {'d': 'm21 21-4.3-4.3'},
            ),
          ],
        ),
        Component.element(
          tag: 'input',
          attributes: {
            'class': cn([
              'flex h-10 w-full rounded-md bg-transparent py-3 text-sm outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50',
              className,
            ]),
            'placeholder': placeholder ?? 'Type a command or search...',
            'value': scope.search,
            'data-slot': 'command-input',
            'role': 'combobox',
            'aria-autocomplete': 'list',
          },
          events: events<String>(
            onInput: (value) {
              scope.onSearchChange(value);
            },
          ),
        ),
      ],
      classes: 'flex items-center border-b px-3',
      attributes: {'data-slot': 'command-input-wrapper'},
    );
  }
}

class ShadCommandList extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCommandList(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'max-h-[300px] overflow-y-auto overflow-x-hidden',
        className,
      ]),
      attributes: {
        'data-slot': 'command-list',
        'role': 'listbox',
      },
    );
  }
}

class ShadCommandEmpty extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCommandEmpty(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCommandScope.of(context);
    // Only show empty state when there is a search query
    if (scope.search.isEmpty) return Component.fragment([]);

    return div(
      children,
      classes: cn(['py-6 text-center text-sm', className]),
      attributes: {'data-slot': 'command-empty'},
    );
  }
}

class ShadCommandGroup extends StatelessComponent {
  final String? heading;
  final List<Component> children;
  final String? className;

  const ShadCommandGroup(
    this.children, {
    this.heading,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        if (heading != null)
          div(
            [Component.text(heading!)],
            classes:
                'px-2 py-1.5 text-xs font-medium text-muted-foreground',
            attributes: {'data-slot': 'command-group-heading'},
          ),
        div(
          children,
          attributes: {'data-slot': 'command-group-items'},
        ),
      ],
      classes: cn([
        'overflow-hidden p-1 text-foreground [&_[data-slot=command-group-heading]]:px-2 [&_[data-slot=command-group-heading]]:py-1.5 [&_[data-slot=command-group-heading]]:text-xs [&_[data-slot=command-group-heading]]:font-medium [&_[data-slot=command-group-heading]]:text-muted-foreground',
        className,
      ]),
      attributes: {
        'data-slot': 'command-group',
        'role': 'group',
      },
    );
  }
}

class ShadCommandItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final VoidCallback? onSelect;
  final bool isDisabled;
  final String? className;
  final List<String>? keywords;

  const ShadCommandItem({
    required this.value,
    required this.children,
    this.onSelect,
    this.isDisabled = false,
    this.className,
    this.keywords,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadCommandScope.of(context);
    final search = scope.search.toLowerCase();

    // Filter: check if value or keywords match the search
    if (search.isNotEmpty) {
      final matchesValue = value.toLowerCase().contains(search);
      final matchesKeywords =
          keywords?.any((k) => k.toLowerCase().contains(search)) ?? false;
      if (!matchesValue && !matchesKeywords) {
        return Component.fragment([]);
      }
    }

    return div(
      children,
      classes: cn([
        'relative flex cursor-default gap-2 select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*=\'size-\'])]:size-4',
        className,
      ]),
      events: {
        'click': (_) => onSelect?.call(),
      },
      attributes: {
        'data-slot': 'command-item',
        'data-value': value,
        'role': 'option',
        if (isDisabled) 'data-disabled': '',
      },
    );
  }
}

class ShadCommandSeparator extends StatelessComponent {
  final String? className;

  const ShadCommandSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['-mx-1 h-px bg-border', className]),
      attributes: {
        'data-slot': 'command-separator',
        'role': 'separator',
      },
    );
  }
}

class ShadCommandShortcut extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCommandShortcut(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'ml-auto text-xs tracking-widest text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'command-shortcut'},
    );
  }
}
