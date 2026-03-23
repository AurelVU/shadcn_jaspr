import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

class ShadEmpty extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadEmpty(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex flex-col items-center justify-center gap-6 py-16 text-center',
        className,
      ]),
      attributes: {'data-slot': 'empty'},
    );
  }
}

class ShadEmptyHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadEmptyHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex flex-col items-center gap-2',
        className,
      ]),
      attributes: {'data-slot': 'empty-header'},
    );
  }
}

enum EmptyMediaVariant { defaultVariant, icon }

final _emptyMediaVariants = CVASimple<EmptyMediaVariant>(
  base: 'flex items-center justify-center',
  variants: {
    EmptyMediaVariant.defaultVariant:
        'size-12 rounded-full bg-muted [&>svg]:size-6 [&>svg]:text-muted-foreground',
    EmptyMediaVariant.icon: '[&>svg]:size-10 [&>svg]:text-muted-foreground',
  },
  defaultVariant: EmptyMediaVariant.defaultVariant,
);

class ShadEmptyMedia extends StatelessComponent {
  final List<Component> children;
  final EmptyMediaVariant? variant;
  final String? className;

  const ShadEmptyMedia(this.children,
      {this.variant, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes:
          _emptyMediaVariants.resolve(variant: variant, className: className),
      attributes: {'data-slot': 'empty-media'},
    );
  }
}

class ShadEmptyTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadEmptyTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-lg font-semibold', className]),
      attributes: {'data-slot': 'empty-title'},
    );
  }
}

class ShadEmptyDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadEmptyDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground max-w-sm', className]),
      attributes: {'data-slot': 'empty-description'},
    );
  }
}

class ShadEmptyContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadEmptyContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col items-center gap-2', className]),
      attributes: {'data-slot': 'empty-content'},
    );
  }
}
