import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadSlider extends StatefulComponent {
  final double? value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<double>? onValueChange;
  final bool isDisabled;
  final String? className;

  const ShadSlider({
    this.value,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.onValueChange,
    this.isDisabled = false,
    this.className,
    super.key,
  });

  @override
  State<ShadSlider> createState() => _ShadSliderState();
}

class _ShadSliderState extends State<ShadSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? component.min;
  }

  void _onInput(String value) {
    if (component.isDisabled) return;
    final newValue = double.tryParse(value);
    if (newValue != null) {
      setState(() {
        _value = newValue;
      });
      component.onValueChange?.call(_value);
    }
  }

  @override
  Component build(BuildContext context) {
    final percentage =
        (((_value - component.min) / (component.max - component.min)) * 100)
            .clamp(0.0, 100.0);

    return div(
      [
        // Track
        div(
          [
            // Range (filled part)
            div(
              [],
              classes: 'absolute h-full bg-primary rounded-full',
              attributes: {
                'data-slot': 'slider-range',
                'style': 'width: ${percentage}%',
              },
            ),
          ],
          classes: 'relative h-1.5 w-full grow overflow-hidden rounded-full bg-primary/20',
          attributes: {'data-slot': 'slider-track'},
        ),
        // Thumb
        div(
          [],
          classes:
              'absolute block size-4 rounded-full border border-primary/50 bg-background shadow-sm transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50',
          attributes: {
            'data-slot': 'slider-thumb',
            'style': 'left: calc(${percentage}% - 8px); top: 50%; transform: translateY(-50%)',
          },
        ),
        // Hidden range input for accessibility
        Component.element(
          tag: 'input',
          attributes: {
            'type': 'range',
            'class': 'absolute inset-0 opacity-0 cursor-pointer',
            'min': '${component.min}',
            'max': '${component.max}',
            'step': '${component.step}',
            'value': '$_value',
            if (component.isDisabled) 'disabled': '',
            'data-slot': 'slider-input',
            'aria-valuenow': '$_value',
            'aria-valuemin': '${component.min}',
            'aria-valuemax': '${component.max}',
          },
          events: events<String>(onInput: _onInput),
        ),
      ],
      classes: cn([
        'relative flex w-full touch-none select-none items-center',
        if (component.isDisabled) 'opacity-50 cursor-not-allowed',
        component.className,
      ]),
      attributes: {
        'data-slot': 'slider',
        if (component.isDisabled) 'data-disabled': '',
        'role': 'slider',
      },
    );
  }
}
