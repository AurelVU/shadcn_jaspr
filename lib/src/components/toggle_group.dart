import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum ToggleGroupType { single, multiple }

enum ToggleGroupVariant { defaultVariant, outline }

enum ToggleGroupSize { defaultSize, sm, lg }

final _toggleGroupItemVariants = CVA<ToggleGroupVariant, ToggleGroupSize>(
  base:
      'inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-colors hover:bg-muted hover:text-muted-foreground disabled:pointer-events-none disabled:opacity-50 data-[state=on]:bg-accent data-[state=on]:text-accent-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0 focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 outline-none',
  variants: {
    ToggleGroupVariant.defaultVariant: 'bg-transparent',
    ToggleGroupVariant.outline:
        'border border-input bg-transparent shadow-xs hover:bg-accent hover:text-accent-foreground',
  },
  sizes: {
    ToggleGroupSize.defaultSize: 'h-9 px-2 min-w-9',
    ToggleGroupSize.sm: 'h-8 px-1.5 min-w-8',
    ToggleGroupSize.lg: 'h-10 px-2.5 min-w-10',
  },
  defaultVariant: ToggleGroupVariant.defaultVariant,
  defaultSize: ToggleGroupSize.defaultSize,
);

class ShadToggleGroup extends StatefulComponent {
  final ToggleGroupType type;
  final List<String>? value;
  final ValueChanged<List<String>>? onValueChange;
  final ToggleGroupVariant? variant;
  final ToggleGroupSize? size;
  final List<Component> children;
  final String? className;

  const ShadToggleGroup({
    this.type = ToggleGroupType.single,
    this.value,
    this.onValueChange,
    this.variant,
    this.size,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadToggleGroup> createState() => _ShadToggleGroupState();
}

class _ShadToggleGroupState extends State<ShadToggleGroup> {
  late List<String> _values;

  @override
  void initState() {
    super.initState();
    _values = List<String>.from(component.value ?? []);
  }

  void _toggleValue(String value) {
    setState(() {
      if (component.type == ToggleGroupType.single) {
        _values = _values.contains(value) ? [] : [value];
      } else {
        if (_values.contains(value)) {
          _values = _values.where((v) => v != value).toList();
        } else {
          _values = [..._values, value];
        }
      }
    });
    component.onValueChange?.call(_values);
  }

  @override
  Component build(BuildContext context) {
    return _ShadToggleGroupScope(
      values: _values,
      onToggle: _toggleValue,
      variant: component.variant,
      size: component.size,
      child: div(
        component.children,
        classes: cn([
          'flex items-center gap-1',
          component.className,
        ]),
        attributes: {
          'data-slot': 'toggle-group',
          'role': 'group',
        },
      ),
    );
  }
}

class _ShadToggleGroupScope extends InheritedComponent {
  final List<String> values;
  final ValueChanged<String> onToggle;
  final ToggleGroupVariant? variant;
  final ToggleGroupSize? size;

  const _ShadToggleGroupScope({
    required this.values,
    required this.onToggle,
    this.variant,
    this.size,
    required super.child,
  });

  static _ShadToggleGroupScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadToggleGroupScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadToggleGroupScope oldComponent) {
    return values != oldComponent.values;
  }
}

class ShadToggleGroupItem extends StatelessComponent {
  final String value;
  final List<Component> children;
  final bool isDisabled;
  final String? className;

  const ShadToggleGroupItem({
    required this.value,
    required this.children,
    this.isDisabled = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadToggleGroupScope.of(context);
    final isPressed = scope.values.contains(value);

    return button(
      children,
      disabled: isDisabled,
      onClick: () => scope.onToggle(value),
      classes: cn([
        _toggleGroupItemVariants.resolve(
          variant: scope.variant,
          size: scope.size,
        ),
        className,
      ]),
      attributes: {
        'data-slot': 'toggle-group-item',
        'data-state': isPressed ? 'on' : 'off',
        'aria-pressed': isPressed.toString(),
        'data-value': value,
      },
    );
  }
}
