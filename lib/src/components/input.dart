import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadInput extends StatelessComponent {
  final InputType? type;
  final String? placeholder;
  final String? value;
  final bool isDisabled;
  final ValueChanged<dynamic>? onInput;
  final ValueChanged<dynamic>? onChange;
  final String? className;
  final String? id;
  final String? name;

  const ShadInput({
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
  Iterable<Component> build(BuildContext context) sync* {
    yield input(
      [],
      type: type,
      value: value,
      disabled: isDisabled ? true : null,
      id: id,
      onInput: onInput,
      onChange: onChange,
      classes: cn([
        'h-9 w-full min-w-0 rounded-md border border-input bg-transparent px-3 py-1 text-base shadow-xs transition-[color,box-shadow] outline-none selection:bg-primary selection:text-primary-foreground file:inline-flex file:h-7 file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground placeholder:text-muted-foreground disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm dark:bg-input/30',
        'focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50',
        'aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40',
        className,
      ]),
      attributes: {
        'data-slot': 'input',
        if (placeholder != null) 'placeholder': placeholder!,
        if (name != null) 'name': name!,
      },
    );
  }
}
