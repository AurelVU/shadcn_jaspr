import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadSelect extends StatefulComponent {
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<Component> children;

  const ShadSelect({
    this.value,
    this.onValueChange,
    required this.children,
    super.key,
  });

  @override
  State<ShadSelect> createState() => _ShadSelectState();
}

class _ShadSelectState extends State<ShadSelect> {
  bool _isOpen = false;
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = component.value;
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  void _selectValue(String value) {
    setState(() {
      _selectedValue = value;
      _isOpen = false;
    });
    component.onValueChange?.call(value);
  }

  @override
  Component build(BuildContext context) {
    return _ShadSelectScope(
      isOpen: _isOpen,
      selectedValue: _selectedValue,
      onToggle: _toggle,
      onClose: _close,
      onSelect: _selectValue,
      child: div(
        component.children,
        classes: 'relative inline-block',
        attributes: {'data-slot': 'select'},
      ),
    );
  }
}

class _ShadSelectScope extends InheritedComponent {
  final bool isOpen;
  final String? selectedValue;
  final VoidCallback onToggle;
  final VoidCallback onClose;
  final ValueChanged<String> onSelect;

  const _ShadSelectScope({
    required this.isOpen,
    required this.selectedValue,
    required this.onToggle,
    required this.onClose,
    required this.onSelect,
    required super.child,
  });

  static _ShadSelectScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadSelectScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadSelectScope oldComponent) {
    return isOpen != oldComponent.isOpen ||
        selectedValue != oldComponent.selectedValue;
  }
}

class ShadSelectTrigger extends StatelessComponent {
  final List<Component> children;
  final String? className;
  final String? placeholder;

  const ShadSelectTrigger(
    this.children, {
    this.className,
    this.placeholder,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadSelectScope.of(context);
    return button(
      [
        ...children,
        // Chevron down icon
        span(
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
                  tag: 'path',
                  attributes: {'d': 'm6 9 6 6 6-6'},
                ),
              ],
            ),
          ],
          classes: 'opacity-50',
        ),
      ],
      onClick: scope.onToggle,
      classes: cn([
        'flex w-fit items-center justify-between gap-2 rounded-md border border-input bg-transparent px-3 py-2 text-sm whitespace-nowrap shadow-xs transition-[color,box-shadow] outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 data-[placeholder]:text-muted-foreground h-9 dark:bg-input/30 dark:hover:bg-input/50 [&_svg]:pointer-events-none [&_svg]:shrink-0',
        className,
      ]),
      attributes: {
        'data-slot': 'select-trigger',
        if (scope.selectedValue == null) 'data-placeholder': '',
      },
    );
  }
}

class ShadSelectValue extends StatelessComponent {
  final String? placeholder;

  const ShadSelectValue({this.placeholder, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadSelectScope.of(context);
    return span(
      [Component.text(scope.selectedValue ?? placeholder ?? '')],
      classes: 'line-clamp-1 flex items-center gap-2',
      attributes: {'data-slot': 'select-value'},
    );
  }
}

class ShadSelectContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSelectContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadSelectScope.of(context);
    if (!scope.isOpen) return Component.fragment([]);

    return div(
      [
        div(children, classes: 'p-1'),
      ],
      classes: cn([
        'absolute z-50 mt-1 min-w-[8rem] overflow-hidden rounded-md border bg-popover p-1 text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
        className,
      ]),
      attributes: {
        'data-slot': 'select-content',
        'data-state': 'open',
      },
    );
  }
}

class ShadSelectItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final String? className;

  const ShadSelectItem({
    required this.value,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadSelectScope.of(context);
    final isSelected = scope.selectedValue == value;

    return div(
      [
        ...children,
        if (isSelected)
          span(
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
                    tag: 'path',
                    attributes: {'d': 'M20 6 9 17l-5-5'},
                  ),
                ],
              ),
            ],
            classes: 'absolute right-2 flex size-3.5 items-center justify-center',
            attributes: {'data-slot': 'select-item-indicator'},
          ),
      ],
      classes: cn([
        'relative flex w-full cursor-default items-center gap-2 rounded-sm py-1.5 pr-8 pl-2 text-sm outline-hidden select-none hover:bg-accent hover:text-accent-foreground data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
        className,
      ]),
      events: {
        'click': (_) => scope.onSelect(value),
      },
      attributes: {
        'data-slot': 'select-item',
        'data-value': value,
        if (isSelected) 'data-selected': '',
      },
    );
  }
}

class ShadSelectSeparator extends StatelessComponent {
  final String? className;

  const ShadSelectSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['pointer-events-none -mx-1 my-1 h-px bg-border', className]),
      attributes: {'data-slot': 'select-separator'},
    );
  }
}
