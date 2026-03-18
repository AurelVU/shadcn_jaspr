import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cva.dart';

enum ButtonVariant { defaultVariant, destructive, outline, secondary, ghost, link }

enum ButtonSize { defaultSize, xs, sm, lg, icon, iconXs, iconSm, iconLg }

final _buttonVariants = CVA<ButtonVariant, ButtonSize>(
  base:
      'inline-flex shrink-0 items-center justify-center gap-2 rounded-md text-sm font-medium whitespace-nowrap transition-all outline-none focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:pointer-events-none disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*=\'size-\'])]:size-4',
  variants: {
    ButtonVariant.defaultVariant: 'bg-primary text-primary-foreground hover:bg-primary/90',
    ButtonVariant.destructive:
        'bg-destructive text-white hover:bg-destructive/90 focus-visible:ring-destructive/20 dark:bg-destructive/60 dark:focus-visible:ring-destructive/40',
    ButtonVariant.outline:
        'border bg-background shadow-xs hover:bg-accent hover:text-accent-foreground dark:border-input dark:bg-input/30 dark:hover:bg-input/50',
    ButtonVariant.secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
    ButtonVariant.ghost: 'hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50',
    ButtonVariant.link: 'text-primary underline-offset-4 hover:underline',
  },
  sizes: {
    ButtonSize.defaultSize: 'h-9 px-4 py-2 has-[>svg]:px-3',
    ButtonSize.xs:
        'h-6 gap-1 rounded-md px-2 text-xs has-[>svg]:px-1.5 [&_svg:not([class*=\'size-\'])]:size-3',
    ButtonSize.sm: 'h-8 gap-1.5 rounded-md px-3 has-[>svg]:px-2.5',
    ButtonSize.lg: 'h-10 rounded-md px-6 has-[>svg]:px-4',
    ButtonSize.icon: 'size-9',
    ButtonSize.iconXs: 'size-6 rounded-md [&_svg:not([class*=\'size-\'])]:size-3',
    ButtonSize.iconSm: 'size-8',
    ButtonSize.iconLg: 'size-10',
  },
  defaultVariant: ButtonVariant.defaultVariant,
  defaultSize: ButtonSize.defaultSize,
);

class ShadButton extends StatelessComponent {
  final List<Component> children;
  final ButtonVariant? variant;
  final ButtonSize? size;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final String? className;

  const ShadButton(
    this.children, {
    this.variant,
    this.size,
    this.isDisabled = false,
    this.onPressed,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      children,
      disabled: isDisabled,
      onClick: onPressed,
      classes: _buttonVariants.resolve(variant: variant, size: size, className: className),
      attributes: {
        'data-slot': 'button',
        'data-variant': (variant ?? ButtonVariant.defaultVariant).name,
        'data-size': (size ?? ButtonSize.defaultSize).name,
      },
    );
  }
}
