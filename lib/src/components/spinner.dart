import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadSpinner extends StatelessComponent {
  final String? className;

  const ShadSpinner({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'svg',
      classes: cn(['size-4 animate-spin', className]),
      attributes: {
        'data-slot': 'spinner',
        'xmlns': 'http://www.w3.org/2000/svg',
        'width': '24',
        'height': '24',
        'viewBox': '0 0 24 24',
        'fill': 'none',
        'stroke': 'currentColor',
        'stroke-width': '2',
        'stroke-linecap': 'round',
        'stroke-linejoin': 'round',
        'role': 'status',
        'aria-label': 'Loading',
      },
      children: [
        // Loader2 icon paths
        Component.element(
          tag: 'path',
          attributes: {'d': 'M21 12a9 9 0 1 1-6.219-8.56'},
        ),
      ],
    );
  }
}
