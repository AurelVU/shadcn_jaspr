import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadNativeSelect extends StatelessComponent {
  final List<Component> children;
  final String? value;
  final bool isDisabled;
  final ValueChanged<dynamic>? onChange;
  final String? className;
  final String? id;
  final String? name;

  const ShadNativeSelect({
    required this.children,
    this.value,
    this.isDisabled = false,
    this.onChange,
    this.className,
    this.id,
    this.name,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        select(
          children,
          id: id,
          disabled: isDisabled,
          onChange: onChange,
          classes: cn([
            'h-9 w-full appearance-none rounded-md border border-input bg-transparent px-3 py-1 pr-8 text-base transition-[color,box-shadow] outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 md:text-sm dark:bg-input/30',
            className,
          ]),
          attributes: {
            'data-slot': 'native-select',
            if (value != null) 'value': value!,
            if (name != null) 'name': name!,
          },
        ),
        // Chevron down icon overlay
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
          classes:
              'pointer-events-none absolute right-2 top-1/2 -translate-y-1/2 text-muted-foreground',
        ),
      ],
      classes: 'relative',
    );
  }
}

class ShadNativeSelectOption extends StatelessComponent {
  final String value;
  final List<Component> children;
  final bool isDisabled;

  const ShadNativeSelectOption({
    required this.value,
    required this.children,
    this.isDisabled = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return option(
      children,
      value: value,
      disabled: isDisabled,
      attributes: {'data-slot': 'native-select-option'},
    );
  }
}

class ShadNativeSelectOptGroup extends StatelessComponent {
  final String label;
  final List<Component> children;
  final bool isDisabled;

  const ShadNativeSelectOptGroup({
    required this.label,
    required this.children,
    this.isDisabled = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return optgroup(
      children,
      label: label,
      disabled: isDisabled,
      attributes: {'data-slot': 'native-select-optgroup'},
    );
  }
}
