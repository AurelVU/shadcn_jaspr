# CLAUDE.md — shadcn_jaspr

## Project Overview

**shadcn_jaspr** is a Dart port of [shadcn/ui](https://ui.shadcn.com/) for the [Jaspr](https://jasprpad.schultek.de/) web framework.

- **Version:** 0.4.0
- **Dart SDK:** ^3.6.0
- **Jaspr:** ^0.22.0
- **Styling:** Tailwind CSS v4 with CSS variables
- **Components:** 60 components + 10 authentication blocks
- **Repo:** https://github.com/AurelVU/shadcn_jaspr
- **Live demo:** https://aurelvu.github.io/shadcn_jaspr/
- **pub.dev:** https://pub.dev/packages/shadcn_jaspr

## File Structure

```
lib/
├── shadcn_jaspr.dart              # Barrel export (single import for consumers)
├── src/
│   ├── components/                # 60 component files (one file per component family)
│   │   ├── button.dart            # CVA pattern reference
│   │   ├── card.dart              # Composable family reference
│   │   ├── dialog.dart            # InheritedComponent scope reference
│   │   └── ...
│   ├── blocks/                    # 10 authentication page blocks
│   │   ├── login_01.dart … login_05.dart
│   │   └── signup_01.dart … signup_05.dart
│   ├── utils/
│   │   ├── cn.dart                # Class merging utility (like clsx)
│   │   └── cva.dart               # Class Variance Authority (CVA + CVASimple)
│   └── theme/
│       └── theme.dart             # Theme documentation (CSS vars live in styles.tw.css)
example/
├── lib/
│   ├── main.dart                  # Entry point
│   ├── app.dart                   # App shell
│   └── pages/showcase.dart        # Component showcase
├── web/
│   ├── styles.tw.css              # Tailwind source (theme + @source directives)
│   └── styles.css                 # Compiled Tailwind output (DO NOT edit)
```

## Build Commands

```bash
# Install Tailwind CLI (first time only)
cd example && npm install

# Rebuild Tailwind CSS (required after changing classes or adding components)
cd example && npx @tailwindcss/cli -i web/styles.tw.css -o web/styles.css

# Run dev server
cd example && jaspr serve

# Analyze Dart code
dart analyze

# Format code
dart format .
```

**Important:** `jaspr serve` does NOT rebuild Tailwind CSS. You must rebuild manually after changing any Tailwind classes.

## Component Architecture

Components fall into three categories:

### Category A — Stateless Simple
Extend `StatelessComponent`. No internal state. Accept `children`, `className`, and component-specific props.

**Examples:** Badge, Separator, Card, Label, Input, Skeleton, Typography, all Card/Dialog/Sheet sub-components

```dart
class ShadBadge extends StatelessComponent {
  final List<Component> children;
  final BadgeVariant? variant;
  final String? className;
  const ShadBadge(this.children, {this.variant, this.className, super.key});
}
```

### Category B — Stateful Self-Managed
Extend `StatefulComponent` with internal state. Support controlled (external value) and uncontrolled (internal default) modes.

**Examples:** Checkbox, Toggle, Switch, Calendar, Slider, DatePicker, Combobox, DataTable

```dart
class ShadCheckbox extends StatefulComponent {
  final bool? checked;                    // null = uncontrolled
  final ValueChanged<bool>? onCheckedChange;
  final bool isDisabled;
  final String? className;
}
```

### Category C — Stateful with InheritedComponent Scope
Root component manages state and broadcasts it via a private `InheritedComponent` (`_Shad*Scope`). Child components access scope via `_Shad*Scope.of(context)`.

**Examples:** Dialog, Sheet, Tabs, Select, Accordion, Form, Sidebar, DropdownMenu, Popover, Tooltip, Carousel, Command, ContextMenu, HoverCard, InputOTP, Menubar, NavigationMenu, RadioGroup, ResizablePanelGroup, ToggleGroup, Collapsible, AlertDialog, Drawer

```dart
// Root component creates the scope
class ShadDialog extends StatefulComponent { ... }
class _ShadDialogState extends State<ShadDialog> {
  @override
  Component build(BuildContext context) {
    return _ShadDialogScope(isOpen: _isOpen, onOpenChange: _setOpen, child: ...);
  }
}

// Private InheritedComponent
class _ShadDialogScope extends InheritedComponent {
  static _ShadDialogScope of(BuildContext context) { ... }
}

// Child components read from scope
class ShadDialogTrigger extends StatelessComponent {
  Component build(BuildContext context) {
    final scope = _ShadDialogScope.of(context);
    // use scope.isOpen, scope.onOpenChange, etc.
  }
}
```

## CVA Usage

### CVA<V, S> — Two-axis variants (variant + size)
Used when a component has both a variant enum and a size enum.

```dart
final _buttonVariants = CVA<ButtonVariant, ButtonSize>(
  base: 'inline-flex items-center ...',
  variants: { ButtonVariant.defaultVariant: '...', ... },
  sizes: { ButtonSize.defaultSize: '...', ... },
  defaultVariant: ButtonVariant.defaultVariant,
  defaultSize: ButtonSize.defaultSize,
);

// Usage in build():
classes: _buttonVariants.resolve(variant: variant, size: size, className: className),
```

**Components using CVA:** Button, Toggle, ToggleGroup, Item

### CVASimple<V> — Single-axis variants
Used when a component has only a variant enum (no size axis).

```dart
final _badgeVariants = CVASimple<BadgeVariant>(
  base: 'inline-flex items-center ...',
  variants: { BadgeVariant.defaultVariant: '...', ... },
  defaultVariant: BadgeVariant.defaultVariant,
);

// Usage in build():
classes: _badgeVariants.resolve(variant: variant, className: className),
```

**Components using CVASimple:** Alert, Badge, Toast, Tabs (list), Empty (media), InputGroup (addon), Field (legend, variant), ButtonGroup

### cn() — Class merging (no variants)
Most components use `cn()` directly for simple class merging:

```dart
classes: cn(['base-classes here', className]),
```

### Conventions
- CVA instances are **private file-level** variables: `final _fooVariants = CVA<...>(...);`
- Enum values use `defaultVariant` / `defaultSize` (not `default`, which is a Dart keyword)
- CVA `.resolve()` always passes `className` for consumer overrides

## Composable Family Pattern

Multi-part components follow the Container + Sub-component pattern:

```
ShadCard          — Container (provides the wrapper)
├── ShadCardHeader
│   ├── ShadCardTitle
│   └── ShadCardDescription
├── ShadCardContent
└── ShadCardFooter
```

Each sub-component:
- Is a separate class in the same file
- Accepts `List<Component> children` and `String? className`
- Uses `cn()` for class merging
- Sets `data-slot` attribute for CSS targeting

**Components following this pattern:** Card, Dialog, Sheet, Drawer, Alert, AlertDialog, Empty, Item, Field

## Critical Pitfalls

### 1. Tailwind v4 Scanner Limitation
Tailwind v4's JIT scanner does NOT extract arbitrary variant child selectors (e.g., `[&>*]:rounded-none`, `[&>svg]:size-5`) from `.dart` files.

**Workaround:** Add them to `@source inline("...")` in `example/web/styles.tw.css`.

**CRITICAL:** `@source inline()` must be a **single line**. Multi-line strings cause `CssSyntaxError: Unterminated string`.

For complex child styling (ButtonGroup, InputGroup), use raw CSS in `@layer components` with `[data-slot="..."]` selectors instead.

### 2. Text Content
Always use `Component.text('...')` for text nodes:
```dart
span([Component.text('Hello')], classes: 'text-sm')
```

### 3. Non-Standard HTML Elements
Use `Component.element()` for SVG and other non-standard tags:
```dart
Component.element(
  tag: 'svg',
  attributes: {'xmlns': '...', 'viewBox': '...'},
  children: [
    Component.element(tag: 'path', attributes: {'d': '...'}),
  ],
)
```

### 4. Switch Component File Name
The switch component is in `switch_component.dart` (not `switch.dart`) because `switch` is a Dart keyword.

### 5. Fragment for Conditional Rendering
Use `Component.fragment([])` to render nothing:
```dart
if (!scope.isOpen) return Component.fragment([]);
```

### 6. DOM Helpers
Import `package:jaspr/dom.dart` for HTML element helpers (`div`, `span`, `button`, `a`, `input`, etc.):
```dart
import 'package:jaspr/dom.dart';
// Then use: div(children, classes: '...', attributes: {...})
```

## Code Style

### Imports Order
```dart
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';    // or cva.dart
```

### Constructor Conventions
- Use `const` constructors
- `super.key` (not `Key? key`)
- Positional `List<Component> children` as first parameter (when the component has children)
- Named parameters for everything else
- `String? className` for consumer CSS overrides
- `bool isDisabled = false` (not `disabled`)
- `VoidCallback? onPressed` for button-like actions
- `ValueChanged<T>? onSomethingChange` for value callbacks

### Data Attributes
Every component sets `data-slot` for CSS targeting:
```dart
attributes: {'data-slot': 'button'},
```

Components with variants also set `data-variant` and `data-size`:
```dart
attributes: {
  'data-slot': 'button',
  'data-variant': (variant ?? ButtonVariant.defaultVariant).name,
  'data-size': (size ?? ButtonSize.defaultSize).name,
},
```

### ARIA
Use semantic HTML and ARIA attributes where appropriate:
```dart
attributes: {'role': 'dialog', 'aria-modal': 'true'},
```

## Adding a New Component — 10-Step Checklist

1. **Create file** in `lib/src/components/` — one file per component family
2. **Add imports:** `package:jaspr/jaspr.dart`, `package:jaspr/dom.dart`, and `../utils/cn.dart` or `../utils/cva.dart`
3. **Define enums** (if needed) for variants/sizes — use `defaultVariant`/`defaultSize` naming
4. **Define CVA/CVASimple** (if needed) as a private file-level `final` variable
5. **Create classes** — choose Category A/B/C based on statefulness needs
6. **Use `const` constructors** with `super.key`, positional `children`, named props
7. **Set `data-slot`** attribute on every rendered element
8. **Export** from `lib/shadcn_jaspr.dart` barrel file
9. **Add showcase demo** in `example/lib/pages/showcase.dart`
10. **Rebuild Tailwind CSS** — if you used any new arbitrary selectors, add them to `@source inline()` (single line!) or `@layer components` in `example/web/styles.tw.css`
