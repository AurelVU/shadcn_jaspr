import 'package:jaspr/jaspr.dart';

import '../utils/cn.dart';

class ShadCard extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCard(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn([
        'flex flex-col gap-6 rounded-xl border bg-card py-6 text-card-foreground shadow-sm',
        className,
      ]),
      attributes: {'data-slot': 'card'},
    );
  }
}

class ShadCardHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCardHeader(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn([
        '@container/card-header grid auto-rows-min grid-rows-[auto_auto] items-start gap-2 px-6 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6',
        className,
      ]),
      attributes: {'data-slot': 'card-header'},
    );
  }
}

class ShadCardTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCardTitle(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['leading-none font-semibold', className]),
      attributes: {'data-slot': 'card-title'},
    );
  }
}

class ShadCardDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCardDescription(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'card-description'},
    );
  }
}

class ShadCardContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCardContent(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['px-6', className]),
      attributes: {'data-slot': 'card-content'},
    );
  }
}

class ShadCardFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadCardFooter(this.children, {this.className, super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      children,
      classes: cn(['flex items-center px-6 [.border-t]:pt-6', className]),
      attributes: {'data-slot': 'card-footer'},
    );
  }
}
