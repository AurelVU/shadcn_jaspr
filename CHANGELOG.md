## 0.2.0

- **BREAKING**: Migrate to Jaspr 0.22.x (from 0.19.x)
- Updated all components to use new Jaspr API (`Component.text()`, `Component.element()`, single `Component build()`)
- Added `import 'package:jaspr/dom.dart'` for HTML element classes

## 0.1.1

- Fix screenshot URLs in README for pub.dev rendering

## 0.1.0

- Initial release
- **19 components** ported from shadcn/ui:
  - Base: Button, Badge, Card, Input, Label, Separator
  - Form: Checkbox, Switch, Textarea, Select, RadioGroup
  - Navigation: Tabs, Breadcrumb, Pagination
  - Overlay: Dialog, Sheet, DropdownMenu, Tooltip, Popover
- Utility functions: `cn()` for class merging, `CVA` for variant management
- Tailwind CSS theming with CSS variables (light/dark mode)
- Full example showcase app
