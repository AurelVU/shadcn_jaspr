import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';
import '../utils/cva.dart';

enum ToastVariant { defaultVariant, destructive }

final _toastVariants = CVASimple<ToastVariant>(
  base:
      'group pointer-events-auto relative flex w-full items-center justify-between space-x-2 overflow-hidden rounded-md border p-4 pr-6 shadow-lg transition-all animate-in slide-in-from-top-full',
  variants: {
    ToastVariant.defaultVariant:
        'border bg-background text-foreground',
    ToastVariant.destructive:
        'destructive group border-destructive bg-destructive text-white',
  },
  defaultVariant: ToastVariant.defaultVariant,
);

class ShadToaster extends StatefulComponent {
  final List<Component> children;
  final String? className;

  const ShadToaster({required this.children, this.className, super.key});

  @override
  State<ShadToaster> createState() => _ShadToasterState();
}

class _ShadToasterState extends State<ShadToaster> {
  @override
  Component build(BuildContext context) {
    return div(
      component.children,
      classes: cn([
        'fixed top-0 z-[100] flex max-h-screen w-full flex-col-reverse gap-2 p-4 sm:right-0 sm:top-auto sm:bottom-0 sm:flex-col sm:max-w-[420px]',
        component.className,
      ]),
      attributes: {
        'data-slot': 'toaster',
      },
    );
  }
}

class ShadToast extends StatelessComponent {
  final List<Component> children;
  final ToastVariant? variant;
  final VoidCallback? onClose;
  final String? className;

  const ShadToast(
    this.children, {
    this.variant,
    this.onClose,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        _toastVariants.resolve(variant: variant),
        className,
      ]),
      attributes: {
        'data-slot': 'toast',
        'data-state': 'open',
        'data-variant': variant == ToastVariant.destructive ? 'destructive' : 'default',
        'role': 'status',
        'aria-live': 'polite',
      },
    );
  }
}

class ShadToastTitle extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadToastTitle(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm font-semibold [&+div]:text-xs', className]),
      attributes: {'data-slot': 'toast-title'},
    );
  }
}

class ShadToastDescription extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadToastDescription(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn(['text-sm opacity-90', className]),
      attributes: {'data-slot': 'toast-description'},
    );
  }
}

class ShadToastAction extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onAction;
  final String? className;

  const ShadToastAction(this.children, {this.onAction, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'inline-flex h-8 shrink-0 items-center justify-center rounded-md border bg-transparent px-3 text-sm font-medium transition-colors hover:bg-secondary focus:ring-1 focus:ring-ring disabled:pointer-events-none disabled:opacity-50 group-[.destructive]:border-muted/40 group-[.destructive]:hover:border-destructive/30 group-[.destructive]:hover:bg-destructive group-[.destructive]:hover:text-destructive-foreground group-[.destructive]:focus:ring-destructive',
        className,
      ]),
      events: {'click': (_) => onAction?.call()},
      attributes: {'data-slot': 'toast-action'},
    );
  }
}

class ShadToastClose extends StatelessComponent {
  final VoidCallback? onClose;
  final String? className;

  const ShadToastClose({this.onClose, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return button(
      [
        Component.element(
          tag: 'svg',
          attributes: {
            'xmlns': 'http://www.w3.org/2000/svg',
            'width': '14',
            'height': '14',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
          },
          children: [
            Component.element(tag: 'path', attributes: {'d': 'M18 6 6 18'}),
            Component.element(tag: 'path', attributes: {'d': 'm6 6 12 12'}),
          ],
        ),
      ],
      onClick: onClose,
      classes: cn([
        'absolute top-1 right-1 rounded-md p-1 text-foreground/50 opacity-0 transition-opacity hover:text-foreground focus:opacity-100 focus:ring-1 group-hover:opacity-100 group-[.destructive]:text-red-300 group-[.destructive]:hover:text-red-50',
        className,
      ]),
      attributes: {'data-slot': 'toast-close'},
    );
  }
}
