import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadTypographyH1 extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyH1(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return h1(
      children,
      classes: cn([
        'scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl',
        className,
      ]),
      attributes: {'data-slot': 'typography-h1'},
    );
  }
}

class ShadTypographyH2 extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyH2(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return h2(
      children,
      classes: cn([
        'scroll-m-20 border-b pb-2 text-3xl font-semibold tracking-tight first:mt-0',
        className,
      ]),
      attributes: {'data-slot': 'typography-h2'},
    );
  }
}

class ShadTypographyH3 extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyH3(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return h3(
      children,
      classes: cn([
        'scroll-m-20 text-2xl font-semibold tracking-tight',
        className,
      ]),
      attributes: {'data-slot': 'typography-h3'},
    );
  }
}

class ShadTypographyH4 extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyH4(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return h4(
      children,
      classes: cn([
        'scroll-m-20 text-xl font-semibold tracking-tight',
        className,
      ]),
      attributes: {'data-slot': 'typography-h4'},
    );
  }
}

class ShadTypographyP extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyP(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return p(
      children,
      classes: cn(['leading-7 [&:not(:first-child)]:mt-6', className]),
      attributes: {'data-slot': 'typography-p'},
    );
  }
}

class ShadTypographyBlockquote extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyBlockquote(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'blockquote',
      classes: cn(['mt-6 border-l-2 pl-6 italic', className]),
      attributes: {'data-slot': 'typography-blockquote'},
      children: children,
    );
  }
}

class ShadTypographyList extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyList(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return ul(
      children,
      classes: cn(['my-6 ml-6 list-disc [&>li]:mt-2', className]),
      attributes: {'data-slot': 'typography-list'},
    );
  }
}

class ShadTypographyCode extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyCode(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'code',
      classes: cn([
        'relative rounded bg-muted px-[0.3rem] py-[0.2rem] font-mono text-sm font-semibold',
        className,
      ]),
      attributes: {'data-slot': 'typography-code'},
      children: children,
    );
  }
}

class ShadTypographyLead extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyLead(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return p(
      children,
      classes: cn(['text-xl text-muted-foreground', className]),
      attributes: {'data-slot': 'typography-lead'},
    );
  }
}

class ShadTypographyLarge extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyLarge(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-lg font-semibold', className]),
      attributes: {'data-slot': 'typography-large'},
    );
  }
}

class ShadTypographySmall extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographySmall(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'small',
      classes: cn(['text-sm font-medium leading-none', className]),
      attributes: {'data-slot': 'typography-small'},
      children: children,
    );
  }
}

class ShadTypographyMuted extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTypographyMuted(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return p(
      children,
      classes: cn(['text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'typography-muted'},
    );
  }
}
