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
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _value = component.value ?? '';
  }

  void _onInput(String raw) {
    final filtered = raw.replaceAll(RegExp(r'[^0-9a-zA-Z]'), '');
    final clamped = filtered.length > component.maxLength
        ? filtered.substring(0, component.maxLength)
        : filtered;
    setState(() {
      _value = clamped;
    });
    component.onValueChange?.call(_value);
  }

  void _onFocus() {
    setState(() {
      _hasFocus = true;
    });
  }

  void _onBlur() {
    setState(() {
      _hasFocus = false;
    });
  }

  @override
  Component build(BuildContext context) {
    return _ShadInputOTPScope(
      value: _value,
      maxLength: component.maxLength,
      hasFocus: _hasFocus,
      child: div(
        [
          // Hidden input that captures keyboard input — overlays the slot area
          Component.element(
            tag: 'input',
            attributes: {
              'type': 'text',
              'data-slot': 'input-otp-input',
              'class':
                  'absolute inset-0 w-full h-full opacity-0 z-10 cursor-pointer',
              'style': 'caret-color: transparent; letter-spacing: -1em; font-size: 1px;',
              'maxlength': '${component.maxLength}',
              'value': _value,
              'autocomplete': 'one-time-code',
              'inputmode': 'numeric',
            },
            events: {
              ...events<String>(onInput: _onInput),
              'focus': (_) => _onFocus(),
              'blur': (_) => _onBlur(),
            },
          ),
          ...component.children,
        ],
        classes: cn([
          'relative flex items-center gap-2 has-[:disabled]:opacity-50',
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
  final bool hasFocus;

  const _ShadInputOTPScope({
    required this.value,
    required this.maxLength,
    required this.hasFocus,
    required super.child,
  });

  static _ShadInputOTPScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadInputOTPScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadInputOTPScope oldComponent) {
    return value != oldComponent.value || hasFocus != oldComponent.hasFocus;
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
    final isActive = scope.hasFocus && index == scope.value.length;

    return div(
      [
        Component.text(char),
        if (isActive)
          div(
            [
              div([], classes: 'h-4 w-px animate-pulse bg-foreground duration-1000'),
            ],
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
