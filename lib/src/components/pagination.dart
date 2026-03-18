import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';
import 'button.dart';

class ShadPagination extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadPagination(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield nav(
      children,
      classes: cn(['mx-auto flex w-full justify-center', className]),
      attributes: {
        'data-slot': 'pagination',
        'role': 'navigation',
        'aria-label': 'pagination',
      },
    );
  }
}

class ShadPaginationContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadPaginationContent(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ul(
      children,
      classes: cn(['flex flex-row items-center gap-1', className]),
      attributes: {'data-slot': 'pagination-content'},
    );
  }
}

class ShadPaginationItem extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadPaginationItem(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield li(
      children,
      classes: cn([className]),
      attributes: {'data-slot': 'pagination-item'},
    );
  }
}

class ShadPaginationLink extends StatelessComponent {
  final List<Component> children;
  final bool isActive;
  final VoidCallback? onPressed;
  final String? className;

  const ShadPaginationLink(
    this.children, {
    this.isActive = false,
    this.onPressed,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ShadButton(
      children,
      variant: isActive ? ButtonVariant.outline : ButtonVariant.ghost,
      size: ButtonSize.icon,
      onPressed: onPressed,
      className: className,
    );
  }
}

class ShadPaginationPrevious extends StatelessComponent {
  final VoidCallback? onPressed;
  final String? className;

  const ShadPaginationPrevious({this.onPressed, this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ShadButton(
      [
        DomComponent(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '16',
            'height': '16',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
          },
          children: [
            DomComponent(
              tag: 'path',
              attributes: {'d': 'm15 18-6-6 6-6'},
            ),
          ],
        ),
        span([text('Previous')]),
      ],
      variant: ButtonVariant.ghost,
      size: ButtonSize.defaultSize,
      onPressed: onPressed,
      className: cn(['gap-1 pl-2.5', className]),
    );
  }
}

class ShadPaginationNext extends StatelessComponent {
  final VoidCallback? onPressed;
  final String? className;

  const ShadPaginationNext({this.onPressed, this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ShadButton(
      [
        span([text('Next')]),
        DomComponent(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '16',
            'height': '16',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
          },
          children: [
            DomComponent(
              tag: 'path',
              attributes: {'d': 'm9 18 6-6-6-6'},
            ),
          ],
        ),
      ],
      variant: ButtonVariant.ghost,
      size: ButtonSize.defaultSize,
      onPressed: onPressed,
      className: cn(['gap-1 pr-2.5', className]),
    );
  }
}

class ShadPaginationEllipsis extends StatelessComponent {
  final String? className;

  const ShadPaginationEllipsis({this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield span(
      [
        DomComponent(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '16',
            'height': '16',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
          },
          children: [
            DomComponent(
              tag: 'circle',
              attributes: {'cx': '12', 'cy': '12', 'r': '1'},
            ),
            DomComponent(
              tag: 'circle',
              attributes: {'cx': '19', 'cy': '12', 'r': '1'},
            ),
            DomComponent(
              tag: 'circle',
              attributes: {'cx': '5', 'cy': '12', 'r': '1'},
            ),
          ],
        ),
        span([text('More pages')], classes: 'sr-only'),
      ],
      classes: cn([
        'flex size-9 items-center justify-center',
        className,
      ]),
      attributes: {
        'data-slot': 'pagination-ellipsis',
        'aria-hidden': 'true',
      },
    );
  }
}
