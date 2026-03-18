import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

enum SeparatorOrientation { horizontal, vertical }

class ShadSeparator extends StatelessComponent {
  final SeparatorOrientation orientation;
  final bool decorative;
  final String? className;

  const ShadSeparator({
    this.orientation = SeparatorOrientation.horizontal,
    this.decorative = true,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      [],
      classes: cn([
        'shrink-0 bg-border',
        orientation == SeparatorOrientation.horizontal
            ? 'h-px w-full'
            : 'h-full w-px',
        className,
      ]),
      attributes: {
        'data-slot': 'separator',
        'role': decorative ? 'none' : 'separator',
        'data-orientation': orientation.name,
        if (!decorative) 'aria-orientation': orientation.name,
      },
    );
  }
}
