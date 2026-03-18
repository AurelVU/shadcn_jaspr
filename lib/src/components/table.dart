import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadTable extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTable(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        Component.element(
          tag: 'table',
          classes: cn([
            'w-full caption-bottom text-sm',
            className,
          ]),
          attributes: {'data-slot': 'table'},
          children: children,
        ),
      ],
      classes: 'relative w-full overflow-x-auto',
    );
  }
}

class ShadTableHeader extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableHeader(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'thead',
      classes: cn(['[&_tr]:border-b', className]),
      attributes: {'data-slot': 'table-header'},
      children: children,
    );
  }
}

class ShadTableBody extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableBody(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'tbody',
      classes: cn(['[&_tr:last-child]:border-0', className]),
      attributes: {'data-slot': 'table-body'},
      children: children,
    );
  }
}

class ShadTableFooter extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableFooter(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'tfoot',
      classes: cn([
        'border-t bg-muted/50 font-medium [&>tr]:last:border-b-0',
        className,
      ]),
      attributes: {'data-slot': 'table-footer'},
      children: children,
    );
  }
}

class ShadTableRow extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableRow(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'tr',
      classes: cn([
        'border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted',
        className,
      ]),
      attributes: {'data-slot': 'table-row'},
      children: children,
    );
  }
}

class ShadTableHead extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableHead(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'th',
      classes: cn([
        'h-10 px-2 text-left align-middle font-medium text-muted-foreground whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]',
        className,
      ]),
      attributes: {'data-slot': 'table-head'},
      children: children,
    );
  }
}

class ShadTableCell extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableCell(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'td',
      classes: cn([
        'p-2 align-middle whitespace-nowrap [&:has([role=checkbox])]:pr-0 [&>[role=checkbox]]:translate-y-[2px]',
        className,
      ]),
      attributes: {'data-slot': 'table-cell'},
      children: children,
    );
  }
}

class ShadTableCaption extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadTableCaption(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'caption',
      classes: cn(['mt-4 text-sm text-muted-foreground', className]),
      attributes: {'data-slot': 'table-caption'},
      children: children,
    );
  }
}
