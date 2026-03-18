import 'package:jaspr/jaspr.dart';

import '../utils/cva.dart';

enum BadgeVariant { defaultVariant, secondary, destructive, outline, ghost, link }

final _badgeVariants = CVASimple<BadgeVariant>(
  base:
      'inline-flex w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-full border border-transparent px-2 py-0.5 text-xs font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&>svg]:pointer-events-none [&>svg]:size-3',
  variants: {
    BadgeVariant.defaultVariant:
        'bg-primary text-primary-foreground [a&]:hover:bg-primary/90',
    BadgeVariant.secondary:
        'bg-secondary text-secondary-foreground [a&]:hover:bg-secondary/90',
    BadgeVariant.destructive:
        'bg-destructive text-white focus-visible:ring-destructive/20 dark:bg-destructive/60 dark:focus-visible:ring-destructive/40 [a&]:hover:bg-destructive/90',
    BadgeVariant.outline:
        'border-border text-foreground [a&]:hover:bg-accent [a&]:hover:text-accent-foreground',
    BadgeVariant.ghost:
        '[a&]:hover:bg-accent [a&]:hover:text-accent-foreground',
    BadgeVariant.link:
        'text-primary underline-offset-4 [a&]:hover:underline',
  },
  defaultVariant: BadgeVariant.defaultVariant,
);

class ShadBadge extends StatelessComponent {
  final List<Component> children;
  final BadgeVariant? variant;
  final String? className;

  const ShadBadge(
    this.children, {
    this.variant,
    this.className,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield span(
      children,
      classes: _badgeVariants.resolve(variant: variant, className: className),
      attributes: {
        'data-slot': 'badge',
        'data-variant': (variant ?? BadgeVariant.defaultVariant).name,
      },
    );
  }
}
