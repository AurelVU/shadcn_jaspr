import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadBreadcrumb extends StatelessComponent {
  final List<Component> children;

  const ShadBreadcrumb(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    return nav(
      children,
      attributes: {
        'aria-label': 'breadcrumb',
        'data-slot': 'breadcrumb',
      },
    );
  }
}

class ShadBreadcrumbList extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadBreadcrumbList(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return ol(
      children,
      classes: cn([
        'flex flex-wrap items-center gap-1.5 text-sm break-words text-muted-foreground sm:gap-2.5',
        className,
      ]),
      attributes: {'data-slot': 'breadcrumb-list'},
    );
  }
}

class ShadBreadcrumbItem extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadBreadcrumbItem(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return li(
      children,
      classes: cn(['inline-flex items-center gap-1.5', className]),
      attributes: {'data-slot': 'breadcrumb-item'},
    );
  }
}

class ShadBreadcrumbLink extends StatelessComponent {
  final List<Component> children;
  final String? href;
  final String? className;

  const ShadBreadcrumbLink(
    this.children, {
    this.href,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return a(
      children,
      href: href ?? '#',
      classes: cn(['transition-colors hover:text-foreground', className]),
      attributes: {'data-slot': 'breadcrumb-link'},
    );
  }
}

class ShadBreadcrumbPage extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadBreadcrumbPage(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn(['font-normal text-foreground', className]),
      attributes: {
        'data-slot': 'breadcrumb-page',
        'role': 'link',
        'aria-disabled': 'true',
        'aria-current': 'page',
      },
    );
  }
}

class ShadBreadcrumbSeparator extends StatelessComponent {
  final List<Component>? children;
  final String? className;

  const ShadBreadcrumbSeparator({this.children, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return li(
      children ??
          [
            Component.element(
              tag: 'svg',
              attributes: {
                'xmlns': 'http://www.w3.org/2000/svg',
                'width': '14',
                'height': '14',
                'viewBox': '0 0 24 24',
                'fill': 'none',
                'stroke': 'currentColor',
                'stroke-width': '2',
                'stroke-linecap': 'round',
                'stroke-linejoin': 'round',
              },
              children: [
                Component.element(
                  tag: 'path',
                  attributes: {'d': 'm9 18 6-6-6-6'},
                ),
              ],
            ),
          ],
      classes: cn(['[&>svg]:size-3.5', className]),
      attributes: {
        'data-slot': 'breadcrumb-separator',
        'role': 'presentation',
        'aria-hidden': 'true',
      },
    );
  }
}

class ShadBreadcrumbEllipsis extends StatelessComponent {
  final String? className;

  const ShadBreadcrumbEllipsis({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      [
        Component.element(
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
            Component.element(
              tag: 'circle',
              attributes: {'cx': '12', 'cy': '12', 'r': '1'},
            ),
            Component.element(
              tag: 'circle',
              attributes: {'cx': '19', 'cy': '12', 'r': '1'},
            ),
            Component.element(
              tag: 'circle',
              attributes: {'cx': '5', 'cy': '12', 'r': '1'},
            ),
          ],
        ),
        span([Component.text('More')], classes: 'sr-only'),
      ],
      classes: cn(['flex size-9 items-center justify-center', className]),
      attributes: {
        'data-slot': 'breadcrumb-ellipsis',
        'role': 'presentation',
        'aria-hidden': 'true',
      },
    );
  }
}
