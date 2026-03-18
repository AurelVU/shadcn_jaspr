import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum ToggleVariant { defaultVariant, outline }

enum ToggleSize { defaultSize, sm, lg }

final _toggleVariants = CVA<ToggleVariant, ToggleSize>(
  base:
      'inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium transition-colors hover:bg-muted hover:text-muted-foreground disabled:pointer-events-none disabled:opacity-50 data-[state=on]:bg-accent data-[state=on]:text-accent-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0 focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 outline-none',
  variants: {
    ToggleVariant.defaultVariant: 'bg-transparent',
    ToggleVariant.outline:
        'border border-input bg-transparent shadow-xs hover:bg-accent hover:text-accent-foreground',
  },
  sizes: {
    ToggleSize.defaultSize: 'h-9 px-2 min-w-9',
    ToggleSize.sm: 'h-8 px-1.5 min-w-8',
    ToggleSize.lg: 'h-10 px-2.5 min-w-10',
  },
  defaultVariant: ToggleVariant.defaultVariant,
  defaultSize: ToggleSize.defaultSize,
);

class ShadToggle extends StatefulComponent {
  final bool? pressed;
  final ValueChanged<bool>? onPressedChange;
  final ToggleVariant? variant;
  final ToggleSize? size;
  final bool isDisabled;
  final List<Component> children;
  final String? className;

  const ShadToggle({
    this.pressed,
    this.onPressedChange,
    this.variant,
    this.size,
    this.isDisabled = false,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadToggle> createState() => _ShadToggleState();
}

class _ShadToggleState extends State<ShadToggle> {
  late bool _pressed;

  @override
  void initState() {
    super.initState();
    _pressed = component.pressed ?? false;
  }

  void _toggle() {
    if (component.isDisabled) return;
    setState(() {
      _pressed = !_pressed;
    });
    component.onPressedChange?.call(_pressed);
  }

  @override
  Component build(BuildContext context) {
    return button(
      component.children,
      disabled: component.isDisabled,
      onClick: _toggle,
      classes: cn([
        _toggleVariants.resolve(
          variant: component.variant,
          size: component.size,
        ),
        component.className,
      ]),
      attributes: {
        'data-slot': 'toggle',
        'data-state': _pressed ? 'on' : 'off',
        'aria-pressed': _pressed.toString(),
      },
    );
  }
}
