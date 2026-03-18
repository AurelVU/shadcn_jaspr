import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadAspectRatio extends StatelessComponent {
  final double ratio;
  final List<Component> children;
  final String? className;

  const ShadAspectRatio({
    required this.ratio,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          children,
          classes: 'absolute inset-0',
          attributes: {'data-slot': 'aspect-ratio-content'},
        ),
      ],
      classes: cn(['relative w-full', className]),
      attributes: {
        'data-slot': 'aspect-ratio',
        'style': 'aspect-ratio: $ratio',
      },
    );
  }
}
