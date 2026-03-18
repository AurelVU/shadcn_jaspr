import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadCheckbox extends StatefulComponent {
  final bool? checked;
  final ValueChanged<bool>? onCheckedChange;
  final bool isDisabled;
  final String? className;

  const ShadCheckbox({
    this.checked,
    this.onCheckedChange,
    this.isDisabled = false,
    this.className,
    super.key,
  });

  @override
  State<ShadCheckbox> createState() => _ShadCheckboxState();
}

class _ShadCheckboxState extends State<ShadCheckbox> {
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
    yield button(
      [
        if (_checked)
          div(
            [
              DomComponent(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '14',
                  'height': '14',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '3',
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                children: [
                  DomComponent(
                    tag: 'path',
                    attributes: {'d': 'M20 6 9 17l-5-5'},
                  ),
                ],
              ),
            ],
            classes: 'grid place-content-center text-current transition-none',
            attributes: {'data-slot': 'checkbox-indicator'},
          ),
      ],
      disabled: component.isDisabled ? true : null,
      onClick: _toggle,
      classes: cn([
        'peer size-4 shrink-0 rounded-[4px] border border-input shadow-xs transition-shadow outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 data-[state=checked]:border-primary data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground dark:bg-input/30 dark:aria-invalid:ring-destructive/40 dark:data-[state=checked]:bg-primary',
        component.className,
      ]),
      attributes: {
        'data-slot': 'checkbox',
        'role': 'checkbox',
        'aria-checked': _checked.toString(),
        'data-state': state,
      },
    );
  }
}
