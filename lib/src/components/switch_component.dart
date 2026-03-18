import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

enum SwitchSize { defaultSize, sm }

class ShadSwitch extends StatefulComponent {
  final bool? checked;
  final ValueChanged<bool>? onCheckedChange;
  final bool isDisabled;
  final SwitchSize size;
  final String? className;

  const ShadSwitch({
    this.checked,
    this.onCheckedChange,
    this.isDisabled = false,
    this.size = SwitchSize.defaultSize,
    this.className,
    super.key,
  });

  @override
  State<ShadSwitch> createState() => _ShadSwitchState();
}

class _ShadSwitchState extends State<ShadSwitch> {
  late bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = component.checked ?? false;
  }

  void _toggle() {
    if (component.isDisabled) return;
    setState(() {
      _checked = !_checked;
    });
    component.onCheckedChange?.call(_checked);
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final state = _checked ? 'checked' : 'unchecked';
    final sizeName = component.size == SwitchSize.defaultSize ? 'default' : 'sm';
    yield button(
      [
        span(
          [],
          classes: cn([
            'pointer-events-none block rounded-full bg-background ring-0 transition-transform',
            component.size == SwitchSize.defaultSize ? 'size-4' : 'size-3',
            _checked ? 'translate-x-[calc(100%-2px)]' : 'translate-x-0',
            _checked
                ? 'dark:bg-primary-foreground'
                : 'dark:bg-foreground',
          ]),
          attributes: {'data-slot': 'switch-thumb', 'data-state': state},
        ),
      ],
      disabled: component.isDisabled ? true : null,
      onClick: _toggle,
      classes: cn([
        'peer inline-flex shrink-0 items-center rounded-full border border-transparent shadow-xs transition-all outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50',
        component.size == SwitchSize.defaultSize
            ? 'h-[1.15rem] w-8'
            : 'h-3.5 w-6',
        _checked ? 'bg-primary' : 'bg-input dark:bg-input/80',
        component.className,
      ]),
      attributes: {
        'data-slot': 'switch',
        'role': 'switch',
        'aria-checked': _checked.toString(),
        'data-state': state,
        'data-size': sizeName,
      },
    );
  }
}
