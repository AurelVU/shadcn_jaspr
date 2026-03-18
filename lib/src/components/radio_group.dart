import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadRadioGroup extends StatefulComponent {
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<Component> children;
  final String? className;

  const ShadRadioGroup({
    this.value,
    this.onValueChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadRadioGroup> createState() => _ShadRadioGroupState();
}

class _ShadRadioGroupState extends State<ShadRadioGroup> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = component.value;
  }

  void _selectValue(String value) {
    setState(() {
      _selectedValue = value;
    });
    component.onValueChange?.call(value);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield _ShadRadioGroupScope(
      selectedValue: _selectedValue,
      onSelect: _selectValue,
      child: div(
        component.children,
        classes: cn(['grid gap-3', component.className]),
        attributes: {
          'data-slot': 'radio-group',
          'role': 'radiogroup',
        },
      ),
    );
  }
}

class _ShadRadioGroupScope extends InheritedComponent {
  final String? selectedValue;
  final ValueChanged<String> onSelect;

  const _ShadRadioGroupScope({
    required this.selectedValue,
    required this.onSelect,
    required super.child,
  });

  static _ShadRadioGroupScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadRadioGroupScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadRadioGroupScope oldComponent) {
    return selectedValue != oldComponent.selectedValue;
  }
}

class ShadRadioGroupItem extends StatelessComponent {
  final String value;
  final bool isDisabled;
  final String? className;

  const ShadRadioGroupItem({
    required this.value,
    this.isDisabled = false,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final scope = _ShadRadioGroupScope.of(context);
    final isSelected = scope.selectedValue == value;

    yield button(
      [
        if (isSelected)
          div(
            [
              DomComponent(
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
                  DomComponent(
                    tag: 'circle',
                    attributes: {'cx': '12', 'cy': '12', 'r': '12'},
                  ),
                ],
              ),
            ],
            classes: 'relative flex items-center justify-center',
            attributes: {'data-slot': 'radio-group-indicator'},
          ),
      ],
      disabled: isDisabled ? true : null,
      onClick: () => scope.onSelect(value),
      classes: cn([
        'aspect-square size-4 shrink-0 rounded-full border border-input text-primary shadow-xs transition-[color,box-shadow] outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:bg-input/30 dark:aria-invalid:ring-destructive/40',
        className,
      ]),
      attributes: {
        'data-slot': 'radio-group-item',
        'role': 'radio',
        'aria-checked': isSelected.toString(),
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-value': value,
      },
    );
  }
}
