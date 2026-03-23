import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadKbd extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadKbd(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'kbd',
      classes: cn([
        'inline-flex h-5 items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium text-muted-foreground select-none',
        className,
      ]),
      attributes: {'data-slot': 'kbd'},
      children: children,
    );
  }
}

class ShadKbdGroup extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadKbdGroup(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'span',
      classes: cn([
        'inline-flex items-center gap-0.5',
        className,
      ]),
      attributes: {'data-slot': 'kbd-group'},
      children: children,
    );
  }
}
