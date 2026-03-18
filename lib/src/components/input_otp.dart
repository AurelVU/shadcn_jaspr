import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadInputOTP extends StatefulComponent {
  final int maxLength;
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<Component> children;
  final String? className;

  const ShadInputOTP({
    required this.maxLength,
    this.value,
    this.onValueChange,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadInputOTP> createState() => _ShadInputOTPState();
}

class _ShadInputOTPState extends State<ShadInputOTP> {
  late String _value;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  void _onInput(String raw) {
    // Only keep digits/alphanumeric up to maxLength
    final filtered = raw.replaceAll(RegExp(r'[^0-9a-zA-Z]'), '');
    final clamped = filtered.length > component.maxLength
        ? filtered.substring(0, component.maxLength)
        : filtered;
    setState(() {
      _value = clamped;
    });
    component.onValueChange?.call(_value);
  }

  @override
  Component build(BuildContext context) {
    return _ShadInputOTPScope(
      value: _value,
      maxLength: component.maxLength,
      child: div(
        [
          // Hidden input
          Component.element(
            tag: 'input',
            attributes: {
              'type': 'text',
              'class': 'absolute inset-0 opacity-0 pointer-events-none',
              'maxlength': '${component.maxLength}',
              'value': _value,
              'autocomplete': 'one-time-code',
              'inputmode': 'numeric',
              'data-slot': 'input-otp-input',
            },
            events: events<String>(onInput: _onInput),
          ),
          ...component.children,
        ],
        classes: cn([
          'flex items-center gap-2 has-[:disabled]:opacity-50',
          component.className,
        ]),
        attributes: {
          'data-slot': 'input-otp',
          'data-input-otp-container': '',
        },
      ),
    );
  }
}

class _ShadInputOTPScope extends InheritedComponent {
  final String value;
  final int maxLength;

  const _ShadInputOTPScope({
    required this.value,
    required this.maxLength,
    required super.child,
  });

  static _ShadInputOTPScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadInputOTPScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadInputOTPScope oldComponent) {
    return value != oldComponent.value;
  }
}

class ShadInputOTPGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadInputOTPGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['flex items-center', className]),
      attributes: {'data-slot': 'input-otp-group'},
    );
  }
}

class ShadInputOTPSlot extends StatelessComponent {
  final int index;
  final String? className;

  const ShadInputOTPSlot({required this.index, this.className, super.key});

  @override
  Component build(BuildContext context) {
    final scope = _ShadInputOTPScope.of(context);
    final char = index < scope.value.length ? scope.value[index] : '';
    final isActive = index == scope.value.length;
    final hasFakeCaret = isActive;

    return div(
      [
        Component.text(char),
        if (hasFakeCaret)
          div(
            [],
            classes:
                'pointer-events-none absolute inset-0 flex items-center justify-center',
            attributes: {'data-slot': 'input-otp-caret'},
          ),
      ],
      classes: cn([
        'relative flex size-9 items-center justify-center border-y border-r border-input text-sm shadow-xs transition-all first:rounded-l-md first:border-l last:rounded-r-md',
        if (isActive) 'z-10 ring-1 ring-ring',
        className,
      ]),
      attributes: {
        'data-slot': 'input-otp-slot',
        'data-active': isActive.toString(),
        'data-value': char,
      },
    );
  }
}

class ShadInputOTPSeparator extends StatelessComponent {
  final String? className;

  const ShadInputOTPSeparator({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        Component.element(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '16',
            'height': '16',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
          },
          children: [
            Component.element(
              tag: 'circle',
              attributes: {'cx': '12', 'cy': '12', 'r': '1'},
            ),
          ],
        ),
      ],
      classes: cn([className]),
      attributes: {
        'data-slot': 'input-otp-separator',
        'role': 'separator',
      },
    );
  }
}
