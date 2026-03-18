import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadSkeleton extends StatelessComponent {
  final String? className;

  const ShadSkeleton({this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [],
      classes: cn(['bg-accent animate-pulse rounded-md', className]),
      attributes: {'data-slot': 'skeleton'},
    );
  }
}
