import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadSonner extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadSonner({required this.children, this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'fixed bottom-0 right-0 z-[100] flex max-h-screen w-full flex-col gap-2 p-4 sm:max-w-[420px]',
        className,
      ]),
      attributes: {
        'data-slot': 'sonner',
        'style':
            '--toast-bg: var(--background); --toast-border: var(--border); --toast-text: var(--foreground); --toast-description-text: var(--muted-foreground)',
      },
    );
  }
}

class ShadSonnerToast extends StatelessComponent {
  final List<Component> children;
  final VoidCallback? onClose;
  final String? className;

  const ShadSonnerToast(
    this.children, {
    this.onClose,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'group pointer-events-auto relative flex w-full items-center justify-between gap-2 overflow-hidden rounded-lg border p-4 shadow-lg transition-all animate-in slide-in-from-bottom-full',
        'bg-[var(--toast-bg)] text-[var(--toast-text)] border-[var(--toast-border)]',
        className,
      ]),
      attributes: {
        'data-slot': 'sonner-toast',
        'data-state': 'open',
        'role': 'status',
        'aria-live': 'polite',
      },
    );
  }
}
