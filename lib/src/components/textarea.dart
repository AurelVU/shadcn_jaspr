import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadTextarea extends StatelessComponent {
  final String? value;
  final String? placeholder;
  final bool isDisabled;
  final int? rows;
  final ValueChanged<String>? onInput;
  final ValueChanged<String>? onChange;
  final String? className;
  final String? id;
  final String? name;

  const ShadTextarea({
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
        'flex field-sizing-content min-h-16 w-full rounded-md border border-input bg-transparent px-3 py-2 text-base shadow-xs transition-[color,box-shadow] outline-none placeholder:text-muted-foreground focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-destructive/20 md:text-sm dark:bg-input/30 dark:aria-invalid:ring-destructive/40',
        className,
      ]),
      attributes: {
        'data-slot': 'textarea',
        if (value != null) 'value': value!,
        if (name != null) 'name': name!,
      },
    );
  }
}
