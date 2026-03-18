import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum AlertVariant { defaultVariant, destructive }

final _alertVariants = CVASimple<AlertVariant>(
  base:
      'relative w-full rounded-lg border px-4 py-3 text-sm grid has-[>svg]:grid-cols-[calc(var(--spacing)*4)_1fr] grid-cols-[0_1fr] has-[>svg]:gap-x-3 gap-y-0.5 items-start [&>svg]:size-4 [&>svg]:translate-y-0.5 [&>svg]:text-current',
  variants: {
    AlertVariant.defaultVariant:
        'bg-card text-foreground [&>svg]:text-foreground',
    AlertVariant.destructive:
        'text-destructive border-destructive/50 dark:border-destructive [&>svg]:text-current *:data-[slot=alert-description]:text-destructive/90',
  },
  defaultVariant: AlertVariant.defaultVariant,
);

class ShadAlert extends StatelessComponent {
  final List<Component> children;
  final AlertVariant? variant;
  final String? className;

  const ShadAlert(
    this.children, {
    this.variant,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: _alertVariants.resolve(variant: variant, className: className),
      attributes: {
        'data-slot': 'alert',
        'role': 'alert',
        'data-variant': (variant ?? AlertVariant.defaultVariant).name,
      },
    );
  }
}

class ShadAlertTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'col-start-2 line-clamp-1 min-h-4 font-medium tracking-tight',
        className,
      ]),
      attributes: {'data-slot': 'alert-title'},
    );
  }
}

class ShadAlertDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadAlertDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'col-start-2 text-sm text-muted-foreground [&_p]:leading-relaxed',
        className,
      ]),
      attributes: {'data-slot': 'alert-description'},
    );
  }
}
