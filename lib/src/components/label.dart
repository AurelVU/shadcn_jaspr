import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadLabel extends StatelessComponent {
  final List<Component> children;
  final String? htmlFor;
  final String? className;

  const ShadLabel(
    this.children, {
    this.htmlFor,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return label(
      children,
      htmlFor: htmlFor,
      classes: cn([
        'flex items-center gap-2 text-sm leading-none font-medium select-none group-data-[disabled=true]:pointer-events-none group-data-[disabled=true]:opacity-50 peer-disabled:cursor-not-allowed peer-disabled:opacity-50',
        className,
      ]),
      attributes: {'data-slot': 'label'},
    );
  }
}
