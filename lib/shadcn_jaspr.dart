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

// Phase 1: Simple components
export 'src/components/alert.dart';
export 'src/components/avatar.dart';
export 'src/components/skeleton.dart';
export 'src/components/aspect_ratio.dart';

// Phase 2: Stateful primitives
export 'src/components/toggle.dart';
export 'src/components/toggle_group.dart';
export 'src/components/collapsible.dart';
export 'src/components/accordion.dart';
export 'src/components/progress.dart';

// Phase 3: Overlay derivatives + medium
export 'src/components/alert_dialog.dart';
export 'src/components/hover_card.dart';
export 'src/components/drawer.dart';
export 'src/components/scroll_area.dart';
export 'src/components/toast.dart';
export 'src/components/slider.dart';
export 'src/components/table.dart';

// Phase 4: Medium-complex
export 'src/components/context_menu.dart';
export 'src/components/menubar.dart';
export 'src/components/input_otp.dart';
export 'src/components/form.dart';

// Phase 5: Complex composite
export 'src/components/navigation_menu.dart';
export 'src/components/calendar.dart';
export 'src/components/date_picker.dart';
export 'src/components/command.dart';
export 'src/components/combobox.dart';
export 'src/components/data_table.dart';
export 'src/components/carousel.dart';
export 'src/components/resizable.dart';
export 'src/components/sidebar.dart';

// Phase 6: Final components
export 'src/components/spinner.dart';
export 'src/components/kbd.dart';
export 'src/components/typography.dart';
export 'src/components/direction.dart';
export 'src/components/empty.dart';
export 'src/components/native_select.dart';
export 'src/components/item.dart';
export 'src/components/button_group.dart';
export 'src/components/input_group.dart';
export 'src/components/field.dart';
export 'src/components/sonner.dart';
export 'src/components/chart.dart';

// Authentication blocks
export 'src/blocks/login_01.dart';
export 'src/blocks/login_02.dart';
export 'src/blocks/login_03.dart';
export 'src/blocks/login_04.dart';
export 'src/blocks/login_05.dart';
export 'src/blocks/signup_01.dart';
export 'src/blocks/signup_02.dart';
export 'src/blocks/signup_03.dart';
export 'src/blocks/signup_04.dart';
export 'src/blocks/signup_05.dart';
