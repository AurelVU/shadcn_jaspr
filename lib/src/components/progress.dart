import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadProgress extends StatelessComponent {
  final double value;
  final String? className;

  const ShadProgress({
    required this.value,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final clamped = value.clamp(0.0, 100.0);

    return div(
      [
        div(
          [],
          classes: 'h-full w-full flex-1 bg-primary transition-all',
          attributes: {
            'data-slot': 'progress-indicator',
            'style': 'transform: translateX(-${100 - clamped}%)',
          },
        ),
      ],
      classes: cn([
        'relative h-2 w-full overflow-hidden rounded-full bg-primary/20',
        className,
      ]),
      attributes: {
        'data-slot': 'progress',
        'role': 'progressbar',
        'aria-valuenow': '${clamped.round()}',
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'data-state': clamped >= 100 ? 'complete' : 'loading',
      },
    );
  }
}
