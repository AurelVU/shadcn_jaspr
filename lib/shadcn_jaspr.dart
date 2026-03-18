/// shadcn/ui components for Jaspr.
///
/// A Dart port of shadcn/ui — the most popular UI component library
/// for React/Next.js — built for the Jaspr web framework.
///
/// Components use Tailwind CSS classes (like the original shadcn/ui)
/// and CSS variables for theming with light/dark mode support.
///
/// ## Getting started
///
/// 1. Add `shadcn_jaspr` to your `pubspec.yaml`
/// 2. Copy `web/styles/globals.tw.css` to your project
/// 3. Import and use components
library;

// Utilities
export 'src/utils/cn.dart';
export 'src/utils/cva.dart';

// Theme
export 'src/theme/theme.dart';

// Base components
export 'src/components/button.dart';
export 'src/components/badge.dart';
export 'src/components/card.dart';
export 'src/components/input.dart';
export 'src/components/label.dart';
export 'src/components/separator.dart';

// Form components
export 'src/components/checkbox.dart';
export 'src/components/switch_component.dart';
export 'src/components/textarea.dart';
export 'src/components/select.dart';
export 'src/components/radio_group.dart';

// Navigation components
export 'src/components/tabs.dart';
export 'src/components/breadcrumb.dart';
export 'src/components/pagination.dart';

// Overlay components
export 'src/components/dialog.dart';
export 'src/components/sheet.dart';
export 'src/components/dropdown_menu.dart';
export 'src/components/tooltip.dart';
export 'src/components/popover.dart';
