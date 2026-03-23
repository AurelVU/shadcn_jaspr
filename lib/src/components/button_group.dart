import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum ButtonGroupVariant { horizontal, vertical }

final _buttonGroupVariants = CVASimple<ButtonGroupVariant>(
  base:
      'inline-flex [&>*]:rounded-none [&>*]:border-collapse [&>*:focus-visible]:z-10',
  variants: {
    ButtonGroupVariant.horizontal:
        'flex-row [&>*:first-child]:rounded-l-md [&>*:last-child]:rounded-r-md [&>*:not(:first-child)]:-ml-px',
    ButtonGroupVariant.vertical:
        'flex-col [&>*:first-child]:rounded-t-md [&>*:last-child]:rounded-b-md [&>*:not(:first-child)]:-mt-px',
  },
  defaultVariant: ButtonGroupVariant.horizontal,
);

class ShadButtonGroup extends StatelessComponent {
  final List<Component> children;
  final ButtonGroupVariant? variant;
  final String? className;

  const ShadButtonGroup(this.children,
      {this.variant, this.className, super.key});

  @override
  Component build(BuildContext context) {
    final v = variant ?? ButtonGroupVariant.horizontal;
    return div(
      children,
      classes: _buttonGroupVariants.resolve(variant: variant, className: className),
      attributes: {
        'data-slot': 'button-group',
        'data-orientation': v.name,
        'role': 'group',
      },
    );
  }
}

class ShadButtonGroupText extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadButtonGroupText(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'inline-flex items-center border border-input bg-background px-3 text-sm text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'button-group-text'},
    );
  }
}

class ShadButtonGroupSeparator extends StatelessComponent {
  final String? className;

  const ShadButtonGroupSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['w-px self-stretch bg-border', className]),
      attributes: {'data-slot': 'button-group-separator'},
    );
  }
}
