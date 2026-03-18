import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum AccordionType { single, multiple }

class ShadAccordion extends StatefulComponent {
  final AccordionType type;
  final List<String>? value;
  final String? defaultValue;
  final ValueChanged<List<String>>? onValueChange;
  final List<Component> children;
  final String? className;

  const ShadAccordion({
    this.type = AccordionType.single,
    this.value,
    this.defaultValue,
    this.onValueChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadAccordion> createState() => _ShadAccordionState();
}

class _ShadAccordionState extends State<ShadAccordion> {
  late List<String> _expandedItems;

  @override
  void initState() {
    super.initState();
    _expandedItems = component.value ??
        (component.defaultValue != null ? [component.defaultValue!] : []);
  }

  void _toggleItem(String value) {
    setState(() {
      if (component.type == AccordionType.single) {
        _expandedItems =
            _expandedItems.contains(value) ? [] : [value];
      } else {
        if (_expandedItems.contains(value)) {
          _expandedItems =
              _expandedItems.where((v) => v != value).toList();
        } else {
          _expandedItems = [..._expandedItems, value];
        }
      }
    });
    component.onValueChange?.call(_expandedItems);
  }

  @override
  Component build(BuildContext context) {
    return _ShadAccordionScope(
      expandedItems: _expandedItems,
      onToggle: _toggleItem,
      child: div(
        component.children,
        classes: cn([component.className]),
        attributes: {
          'data-slot': 'accordion',
          'data-orientation': 'vertical',
        },
      ),
    );
  }
}

class _ShadAccordionScope extends InheritedComponent {
  final List<String> expandedItems;
  final ValueChanged<String> onToggle;

  const _ShadAccordionScope({
    required this.expandedItems,
    required this.onToggle,
    required super.child,
  });

  static _ShadAccordionScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadAccordionScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadAccordionScope oldComponent) {
    return expandedItems != oldComponent.expandedItems;
  }
}

class ShadAccordionItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final String? className;

  const ShadAccordionItem({
    required this.value,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadAccordionScope.of(context);
    final isOpen = scope.expandedItems.contains(value);

    return _ShadAccordionItemScope(
      value: value,
      isOpen: isOpen,
      child: div(
        children,
        classes: cn(['border-b', className]),
        attributes: {
          'data-slot': 'accordion-item',
          'data-state': isOpen ? 'open' : 'closed',
          'data-value': value,
        },
      ),
    );
  }
}

class _ShadAccordionItemScope extends InheritedComponent {
  final String value;
  final bool isOpen;

  const _ShadAccordionItemScope({
    required this.value,
    required this.isOpen,
    required super.child,
  });

  static _ShadAccordionItemScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadAccordionItemScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadAccordionItemScope oldComponent) {
    return isOpen != oldComponent.isOpen || value != oldComponent.value;
  }
}

class ShadAccordionTrigger extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAccordionTrigger(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final accordionScope = _ShadAccordionScope.of(context);
    final itemScope = _ShadAccordionItemScope.of(context);

    return div(
      [
        button(
          [
            ...children,
            // Chevron icon
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
                'class':
                    'size-4 shrink-0 text-muted-foreground transition-transform duration-200 ${itemScope.isOpen ? 'rotate-180' : ''}',
              },
              children: [
                Component.element(
                  tag: 'path',
                  attributes: {'d': 'm6 9 6 6 6-6'},
                ),
              ],
            ),
          ],
          onClick: () => accordionScope.onToggle(itemScope.value),
          classes: cn([
            'flex flex-1 items-center justify-between py-4 text-sm font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180 text-left',
            className,
          ]),
          attributes: {
            'data-slot': 'accordion-trigger',
            'data-state': itemScope.isOpen ? 'open' : 'closed',
            'aria-expanded': itemScope.isOpen.toString(),
          },
        ),
      ],
      classes: 'flex',
      attributes: {'data-orientation': 'vertical'},
    );
  }
}

class ShadAccordionContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAccordionContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final itemScope = _ShadAccordionItemScope.of(context);
    if (!itemScope.isOpen) return Component.fragment([]);

    return div(
      [
        div(
          children,
          classes: cn(['pb-4 pt-0 text-sm', className]),
        ),
      ],
      classes: 'overflow-hidden text-sm data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down',
      attributes: {
        'data-slot': 'accordion-content',
        'data-state': 'open',
        'role': 'region',
      },
    );
  }
}
