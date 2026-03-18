import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadAvatar extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAvatar(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'relative flex size-8 shrink-0 overflow-hidden rounded-full',
        className,
      ]),
      attributes: {'data-slot': 'avatar'},
    );
  }
}

class ShadAvatarImage extends StatelessComponent {
  final String src;
  final String? alt;
  final String? className;

  const ShadAvatarImage({
    required this.src,
    this.alt,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'img',
      attributes: {
        'data-slot': 'avatar-image',
        'class': cn(['aspect-square size-full', className]),
        'src': src,
        if (alt != null) 'alt': alt!,
      },
    );
  }
}

class ShadAvatarFallback extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAvatarFallback(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'flex size-full items-center justify-center rounded-full bg-muted text-xs',
        className,
      ]),
      attributes: {'data-slot': 'avatar-fallback'},
    );
  }
}
