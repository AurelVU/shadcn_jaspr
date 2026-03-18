import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadForm extends StatefulComponent {
  final Map<String, String>? errors;
  final void Function(Map<String, String> values)? onSubmit;
  final List<Component> children;
  final String? className;

  const ShadForm({
    this.errors,
    this.onSubmit,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadForm> createState() => _ShadFormState();
}

class _ShadFormState extends State<ShadForm> {
  late Map<String, String> _errors;

  @override
  void initState() {
    super.initState();
    _errors = Map<String, String>.from(component.errors ?? {});
  }

  void _setError(String name, String? error) {
    setState(() {
      if (error == null) {
        _errors.remove(name);
      } else {
        _errors[name] = error;
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadFormScope(
      errors: _errors,
      onSetError: _setError,
      child: Component.element(
        tag: 'form',
        classes: cn([component.className]),
        attributes: {
          'data-slot': 'form',
          'novalidate': '',
        },
        events: {
          'submit': (event) {
            event.preventDefault();
          },
        },
        children: component.children,
      ),
    );
  }
}

class _ShadFormScope extends InheritedComponent {
  final Map<String, String> errors;
  final void Function(String name, String? error) onSetError;

  const _ShadFormScope({
    required this.errors,
    required this.onSetError,
    required super.child,
  });

  static _ShadFormScope of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<_ShadFormScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadFormScope oldComponent) {
    return errors != oldComponent.errors;
  }
}

class ShadFormField extends StatelessComponent {
  final String name;
  final List<Component> children;

  const ShadFormField({
    required this.name,
    required this.children,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final formScope = _ShadFormScope.of(context);
    final error = formScope.errors[name];

    return _ShadFormFieldScope(
      name: name,
      error: error,
      child: div(
        children,
        attributes: {
          'data-slot': 'form-field',
          'data-name': name,
          if (error != null) 'data-invalid': '',
        },
      ),
    );
  }
}

class _ShadFormFieldScope extends InheritedComponent {
  final String name;
  final String? error;

  const _ShadFormFieldScope({
    required this.name,
    required this.error,
    required super.child,
  });

  static _ShadFormFieldScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadFormFieldScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadFormFieldScope oldComponent) {
    return error != oldComponent.error || name != oldComponent.name;
  }
}

class ShadFormItem extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFormItem(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['grid gap-2', className]),
      attributes: {'data-slot': 'form-item'},
    );
  }
}

class ShadFormLabel extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFormLabel(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final fieldScope = _ShadFormFieldScope.of(context);
    final hasError = fieldScope.error != null;

    return Component.element(
      tag: 'label',
      classes: cn([
        'text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70',
        if (hasError) 'text-destructive',
        className,
      ]),
      attributes: {
        'data-slot': 'form-label',
        'for': fieldScope.name,
        if (hasError) 'data-error': '',
      },
      children: children,
    );
  }
}

class ShadFormControl extends StatelessComponent {
  final List<Component> children;

  const ShadFormControl(this.children, {super.key});

  @override
  Component build(BuildContext context) {
    final fieldScope = _ShadFormFieldScope.of(context);
    return div(
      children,
      attributes: {
        'data-slot': 'form-control',
        'aria-describedby': '${fieldScope.name}-description',
        if (fieldScope.error != null) 'aria-invalid': 'true',
      },
    );
  }
}

class ShadFormDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadFormDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    final fieldScope = _ShadFormFieldScope.of(context);
    return div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {
        'data-slot': 'form-description',
        'id': '${fieldScope.name}-description',
      },
    );
  }
}

class ShadFormMessage extends StatelessComponent {
  final String? className;

  const ShadFormMessage({this.className, super.key});

  @override
  Component build(BuildContext context) {
    final fieldScope = _ShadFormFieldScope.of(context);
    if (fieldScope.error == null) return Component.fragment([]);

    return div(
      [Component.text(fieldScope.error!)],
      classes: cn(['text-sm font-medium text-destructive', className]),
      attributes: {
        'data-slot': 'form-message',
        'role': 'alert',
      },
    );
  }
}
