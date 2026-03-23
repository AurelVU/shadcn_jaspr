import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum ItemVariant { defaultVariant, outline, muted }

enum ItemSize { defaultSize, sm }

final _itemVariants = CVA<ItemVariant, ItemSize>(
  base: 'flex items-center gap-3 rounded-lg p-3 text-left transition-colors',
  variants: {
    ItemVariant.defaultVariant: 'bg-card border',
    ItemVariant.outline: 'border',
    ItemVariant.muted: 'bg-muted/50',
  },
  sizes: {
    ItemSize.defaultSize: 'p-3',
    ItemSize.sm: 'p-2 gap-2',
  },
  defaultVariant: ItemVariant.defaultVariant,
  defaultSize: ItemSize.defaultSize,
);

class ShadItem extends StatelessComponent {
  final List<Component> children;
  final ItemVariant? variant;
  final ItemSize? size;
  final String? className;

  const ShadItem(this.children,
      {this.variant, this.size, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: _itemVariants.resolve(
        variant: variant,
        size: size,
        className: className,
      ),
      attributes: {
        'data-slot': 'item',
        'data-variant': (variant ?? ItemVariant.defaultVariant).name,
      },
    );
  }
}

enum ItemMediaVariant { defaultVariant, icon, image }

final _itemMediaVariants = CVASimple<ItemMediaVariant>(
  base: 'flex shrink-0 items-center justify-center',
  variants: {
    ItemMediaVariant.defaultVariant:
        'size-10 rounded-lg bg-muted [&>svg]:size-5 [&>svg]:text-muted-foreground',
    ItemMediaVariant.icon: '[&>svg]:size-5 [&>svg]:text-muted-foreground',
    ItemMediaVariant.image:
        'size-10 overflow-hidden rounded-lg [&>img]:size-full [&>img]:object-cover',
  },
  defaultVariant: ItemMediaVariant.defaultVariant,
);

class ShadItemMedia extends StatelessComponent {
  final List<Component> children;
  final ItemMediaVariant? variant;
  final String? className;

  const ShadItemMedia(this.children, {this.variant, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes:
          _itemMediaVariants.resolve(variant: variant, className: className),
      attributes: {'data-slot': 'item-media'},
    );
  }
}

class ShadItemContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex min-w-0 flex-1 flex-col gap-0.5', className]),
      attributes: {'data-slot': 'item-content'},
    );
  }
}

class ShadItemTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm font-medium leading-none', className]),
      attributes: {'data-slot': 'item-title'},
    );
  }
}

class ShadItemDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'item-description'},
    );
  }
}

class ShadItemActions extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemActions(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex shrink-0 items-center gap-1', className]),
      attributes: {'data-slot': 'item-actions'},
    );
  }
}

class ShadItemHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex items-center justify-between', className]),
      attributes: {'data-slot': 'item-header'},
    );
  }
}

class ShadItemFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemFooter(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex items-center gap-2 pt-1', className]),
      attributes: {'data-slot': 'item-footer'},
    );
  }
}

class ShadItemGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadItemGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-2', className]),
      attributes: {'data-slot': 'item-group'},
    );
  }
}

class ShadItemSeparator extends StatelessComponent {
  final String? className;

  const ShadItemSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['h-px bg-border', className]),
      attributes: {'data-slot': 'item-separator'},
    );
  }
}
