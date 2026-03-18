import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum ScrollAreaOrientation { vertical, horizontal }

class ShadScrollArea extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadScrollArea(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            div(
              children,
              attributes: {'data-slot': 'scroll-area-content'},
            ),
          ],
          classes: 'h-full w-full overflow-auto rounded-[inherit] [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]',
          attributes: {'data-slot': 'scroll-area-viewport'},
        ),
      ],
      classes: cn(['relative overflow-hidden', className]),
      attributes: {'data-slot': 'scroll-area'},
    );
  }
}

class ShadScrollBar extends StatelessComponent {
  final ScrollAreaOrientation orientation;
  final String? className;

  const ShadScrollBar({
    this.orientation = ScrollAreaOrientation.vertical,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [],
          classes: 'relative flex-1 rounded-full bg-border',
          attributes: {'data-slot': 'scroll-bar-thumb'},
        ),
      ],
      classes: cn([
        'flex touch-none select-none transition-colors',
        orientation == ScrollAreaOrientation.vertical
            ? 'h-full w-2.5 border-l border-l-transparent p-px'
            : 'h-2.5 flex-col border-t border-t-transparent p-px',
        className,
      ]),
      attributes: {
        'data-slot': 'scroll-bar',
        'data-orientation': orientation.name,
      },
    );
  }
}
