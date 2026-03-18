import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum CarouselOrientation { horizontal, vertical }

class ShadCarousel extends StatefulComponent {
  final int? index;
  final ValueChanged<int>? onIndexChange;
  final CarouselOrientation orientation;
  final List<Component> children;
  final String? className;

  const ShadCarousel({
    this.index,
    this.onIndexChange,
    this.orientation = CarouselOrientation.horizontal,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadCarousel> createState() => _ShadCarouselState();
}

class _ShadCarouselState extends State<ShadCarousel> {
  late int _currentIndex;
  int _totalItems = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = component.index ?? 0;
  }

  void _setIndex(int index) {
    if (index < 0 || index >= _totalItems) return;
    setState(() {
      _currentIndex = index;
    });
    component.onIndexChange?.call(_currentIndex);
  }

  void _prev() => _setIndex(_currentIndex - 1);
  void _next() => _setIndex(_currentIndex + 1);

  void _setTotalItems(int count) {
    _totalItems = count;
  }

  @override
  Component build(BuildContext context) {
    return _ShadCarouselScope(
      currentIndex: _currentIndex,
      onPrev: _prev,
      onNext: _next,
      orientation: component.orientation,
      setTotalItems: _setTotalItems,
      child: div(
        component.children,
        classes: cn(['relative', component.className]),
        attributes: {
          'data-slot': 'carousel',
          'data-orientation': component.orientation.name,
          'role': 'region',
          'aria-roledescription': 'carousel',
        },
      ),
    );
  }
}

class _ShadCarouselScope extends InheritedComponent {
  final int currentIndex;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final CarouselOrientation orientation;
  final ValueChanged<int> setTotalItems;

  const _ShadCarouselScope({
    required this.currentIndex,
    required this.onPrev,
    required this.onNext,
    required this.orientation,
    required this.setTotalItems,
    required super.child,
  });

  static _ShadCarouselScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadCarouselScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadCarouselScope oldComponent) {
    return currentIndex != oldComponent.currentIndex;
  }
}

class ShadCarouselContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCarouselContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCarouselScope.of(context);
    scope.setTotalItems(children.length);

    final isHorizontal = scope.orientation == CarouselOrientation.horizontal;
    final offset = scope.currentIndex * 100;

    return div(
      [
        div(
          children,
          classes: cn([
            'flex',
            isHorizontal ? '-ml-4' : '-mt-4 flex-col',
            className,
          ]),
          attributes: {
            'data-slot': 'carousel-content-inner',
            'style': isHorizontal
                ? 'transform: translateX(-${offset}%); transition: transform 300ms ease'
                : 'transform: translateY(-${offset}%); transition: transform 300ms ease',
          },
        ),
      ],
      classes: 'overflow-hidden',
      attributes: {'data-slot': 'carousel-content'},
    );
  }
}

class ShadCarouselItem extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCarouselItem(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCarouselScope.of(context);
    final isHorizontal = scope.orientation == CarouselOrientation.horizontal;

    return div(
      children,
      classes: cn([
        'min-w-0 shrink-0 grow-0 basis-full',
        isHorizontal ? 'pl-4' : 'pt-4',
        className,
      ]),
      attributes: {
        'data-slot': 'carousel-item',
        'role': 'group',
        'aria-roledescription': 'slide',
      },
    );
  }
}

class ShadCarouselPrevious extends StatelessComponent {
  final String? className;

  const ShadCarouselPrevious({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCarouselScope.of(context);
    final isHorizontal = scope.orientation == CarouselOrientation.horizontal;

    return button(
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
              tag: 'path',
              attributes: {
                'd': isHorizontal ? 'm15 18-6-6 6-6' : 'm18 15-6-6-6 6',
              },
            ),
          ],
        ),
        span([Component.text('Previous')], classes: 'sr-only'),
      ],
      onClick: scope.onPrev,
      disabled: scope.currentIndex <= 0,
      classes: cn([
        'absolute inline-flex size-8 items-center justify-center rounded-full border bg-background shadow-sm hover:bg-accent hover:text-accent-foreground disabled:opacity-50',
        isHorizontal
            ? '-left-12 top-1/2 -translate-y-1/2'
            : '-top-12 left-1/2 -translate-x-1/2',
        className,
      ]),
      attributes: {'data-slot': 'carousel-previous'},
    );
  }
}

class ShadCarouselNext extends StatelessComponent {
  final String? className;

  const ShadCarouselNext({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadCarouselScope.of(context);
    final isHorizontal = scope.orientation == CarouselOrientation.horizontal;

    return button(
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
              tag: 'path',
              attributes: {
                'd': isHorizontal ? 'm9 18 6-6-6-6' : 'm6 9 6 6 6-6',
              },
            ),
          ],
        ),
        span([Component.text('Next')], classes: 'sr-only'),
      ],
      onClick: scope.onNext,
      classes: cn([
        'absolute inline-flex size-8 items-center justify-center rounded-full border bg-background shadow-sm hover:bg-accent hover:text-accent-foreground disabled:opacity-50',
        isHorizontal
            ? '-right-12 top-1/2 -translate-y-1/2'
            : '-bottom-12 left-1/2 -translate-x-1/2',
        className,
      ]),
      attributes: {'data-slot': 'carousel-next'},
    );
  }
}
