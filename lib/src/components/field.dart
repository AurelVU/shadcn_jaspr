import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

class ShadFieldSet extends StatelessComponent {
  final List<Component> children;
  final bool isDisabled;
  final String? className;

  const ShadFieldSet(this.children,
      {this.isDisabled = false, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'fieldset',
      classes: cn(['flex flex-col gap-6', className]),
      attributes: {
        'data-slot': 'field-set',
        if (isDisabled) 'disabled': '',
      },
      children: children,
    );
  }
}

enum FieldLegendVariant { legend, label }

final _fieldLegendVariants = CVASimple<FieldLegendVariant>(
  base: 'font-medium leading-none',
  variants: {
    FieldLegendVariant.legend: 'text-base',
    FieldLegendVariant.label:
        'text-sm peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
  },
  defaultVariant: FieldLegendVariant.legend,
);

class ShadFieldLegend extends StatelessComponent {
  final List<Component> children;
  final FieldLegendVariant? variant;
  final String? className;

  const ShadFieldLegend(this.children,
      {this.variant, this.className, super.key});

  @override
  Component build(BuildContext context) {
    final tag =
        (variant ?? FieldLegendVariant.legend) == FieldLegendVariant.legend
            ? 'legend'
            : 'label';
    return Component.element(
      tag: tag,
      classes:
          _fieldLegendVariants.resolve(variant: variant, className: className),
      attributes: {'data-slot': 'field-legend'},
      children: children,
    );
  }
}

class ShadFieldGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFieldGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-4', className]),
      attributes: {'data-slot': 'field-group'},
    );
  }
}

enum FieldVariant { vertical, horizontal }

final _fieldVariants = CVASimple<FieldVariant>(
  base: 'grid gap-2',
  variants: {
    FieldVariant.vertical: 'grid-cols-1',
    FieldVariant.horizontal: 'grid-cols-[auto_1fr] items-center',
  },
  defaultVariant: FieldVariant.vertical,
);

class ShadField extends StatelessComponent {
  final List<Component> children;
  final FieldVariant? variant;
  final String? className;

  const ShadField(this.children, {this.variant, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: _fieldVariants.resolve(variant: variant, className: className),
      attributes: {'data-slot': 'field'},
    );
  }
}

class ShadFieldLabel extends StatelessComponent {
  final List<Component> children;
  final String? htmlFor;
  final String? className;

  const ShadFieldLabel(this.children,
      {this.htmlFor, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'label',
      classes: cn([
        'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
        className,
      ]),
      attributes: {
        'data-slot': 'field-label',
        if (htmlFor != null) 'for': htmlFor!,
      },
      children: children,
    );
  }
}

class ShadFieldContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFieldContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex flex-col gap-1.5', className]),
      attributes: {'data-slot': 'field-content'},
    );
  }
}

class ShadFieldTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFieldTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm font-medium leading-none', className]),
      attributes: {'data-slot': 'field-title'},
    );
  }
}

class ShadFieldDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFieldDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'field-description'},
    );
  }
}

class ShadFieldError extends StatelessComponent {
  final List<String> errors;
  final String? className;

  const ShadFieldError(this.errors, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    if (errors.isEmpty) return Component.fragment([]);

    return ul(
      errors.map((e) => li([Component.text(e)], classes: '')).toList(),
      classes: cn([
        'list-none text-sm font-medium text-destructive',
        className,
      ]),
      attributes: {
        'data-slot': 'field-error',
        'role': 'alert',
      },
    );
  }
}

class ShadFieldSeparator extends StatelessComponent {
  final String? className;

  const ShadFieldSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['h-px bg-border', className]),
      attributes: {'data-slot': 'field-separator'},
    );
  }
}
