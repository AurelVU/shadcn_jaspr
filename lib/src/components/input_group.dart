import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

class ShadInputGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadInputGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex items-stretch rounded-md border border-input shadow-xs focus-within:border-ring focus-within:ring-[3px] focus-within:ring-ring/50',
        className,
      ]),
      attributes: {'data-slot': 'input-group'},
    );
  }
}

enum InputGroupAddonAlign { left, right, top, bottom }

final _inputGroupAddonVariants = CVASimple<InputGroupAddonAlign>(
  base:
      'flex items-center justify-center bg-muted px-3 text-sm text-muted-foreground',
  variants: {
    InputGroupAddonAlign.left: 'rounded-l-md border-r border-input',
    InputGroupAddonAlign.right: 'rounded-r-md border-l border-input',
    InputGroupAddonAlign.top: 'rounded-t-md border-b border-input',
    InputGroupAddonAlign.bottom: 'rounded-b-md border-t border-input',
  },
  defaultVariant: InputGroupAddonAlign.left,
);

class ShadInputGroupAddon extends StatelessComponent {
  final List<Component> children;
  final InputGroupAddonAlign? align;
  final String? className;

  const ShadInputGroupAddon(this.children,
      {this.align, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: _inputGroupAddonVariants.resolve(
          variant: align, className: className),
      attributes: {'data-slot': 'input-group-addon'},
    );
  }
}

class ShadInputGroupButton extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadInputGroupButton(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex items-center [&>button]:rounded-none [&>button]:border-0 [&>button]:shadow-none first:[&>button]:rounded-l-md last:[&>button]:rounded-r-md',
        className,
      ]),
      attributes: {'data-slot': 'input-group-button'},
    );
  }
}

class ShadInputGroupInput extends StatelessComponent {
  final InputType? type;
  final String? placeholder;
  final String? value;
  final bool isDisabled;
  final ValueChanged<dynamic>? onInput;
  final ValueChanged<dynamic>? onChange;
  final String? className;
  final String? id;
  final String? name;

  const ShadInputGroupInput({
    this.type,
    this.placeholder,
    this.value,
    this.isDisabled = false,
    this.onInput,
    this.onChange,
    this.className,
    this.id,
    this.name,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return input(
      type: type,
      value: value,
      disabled: isDisabled,
      id: id,
      onInput: onInput,
      onChange: onChange,
      classes: cn([
        'flex-1 min-w-0 bg-transparent px-3 py-1 text-base outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50 md:text-sm',
        className,
      ]),
      attributes: {
        'data-slot': 'input-group-input',
        if (placeholder != null) 'placeholder': placeholder!,
        if (name != null) 'name': name!,
      },
    );
  }
}

class ShadInputGroupTextarea extends StatelessComponent {
  final String? value;
  final String? placeholder;
  final bool isDisabled;
  final int? rows;
  final ValueChanged<String>? onInput;
  final ValueChanged<String>? onChange;
  final String? className;
  final String? id;
  final String? name;

  const ShadInputGroupTextarea({
    this.value,
    this.placeholder,
    this.isDisabled = false,
    this.rows,
    this.onInput,
    this.onChange,
    this.className,
    this.id,
    this.name,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return textarea(
      [],
      id: id,
      disabled: isDisabled,
      placeholder: placeholder,
      rows: rows,
      onInput: onInput,
      onChange: onChange,
      classes: cn([
        'flex-1 min-w-0 field-sizing-content min-h-16 bg-transparent px-3 py-2 text-base outline-none placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50 md:text-sm',
        className,
      ]),
      attributes: {
        'data-slot': 'input-group-textarea',
        if (value != null) 'value': value!,
        if (name != null) 'name': name!,
      },
    );
  }
}

class ShadInputGroupText extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadInputGroupText(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      children,
      classes: cn([
        'flex items-center px-3 text-sm text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'input-group-text'},
    );
  }
}
