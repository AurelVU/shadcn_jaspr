## 0.4.3

- Update all screenshots for the redesigned tabbed showcase (9 screenshots covering all 8 tabs + dark mode)
- Add screenshots metadata to pubspec.yaml for pub.dev gallery
- Add GitHub Actions CI/CD for automatic example deployment to GitHub Pages
- Fix README dependency version (^0.1.0 → ^0.4.2)

## 0.4.2

- Add AI / LLM Integration section to README with links to all config files

## 0.4.1

- Add AI-first development configuration: CLAUDE.md, llms-full.txt, llms.txt, .cursorrules, .github/copilot-instructions.md
- Complete LLM reference with all 60 components, props, enums, and usage examples
- Cursor IDE rules with component creation templates
- GitHub Copilot instructions for library consumers

## 0.4.0

- Added 4 new chart types: AreaChart, PieChart, RadarChart, RadialChart (6 total)
- Added 10 authentication blocks: Login 01-05, Signup 01-05 (reusable page templates)
- Redesigned showcase app with tabbed category navigation (8 tabs: Inputs, Display, Navigation, Overlays, Layout, Feedback, Charts, Blocks)
- Each demo section now has description text and bordered card container
- Wider container layout (max-w-5xl) and component count badge in header

## 0.3.0

- Added 12 new components: Spinner, Kbd, Typography, Direction, Empty, NativeSelect, Item, ButtonGroup, InputGroup, Field, Sonner, Chart
- Full shadcn/ui component parity (60 components total)
- Typography system with H1-H4, P, Blockquote, List, Code, Lead, Large, Small, Muted
- SVG-based Chart components with BarChart and LineChart renderers
- Field/FieldSet components for structured form layouts
- InputGroup for composite input elements with addons
- ButtonGroup for grouped button layouts
- NativeSelect for styled `<select>` elements
- Direction provider for RTL/LTR support

## 0.2.2

- Added live demo link: https://aurelvu.github.io/shadcn_jaspr/

## 0.2.1

- Added 29 new components: Alert, Avatar, Skeleton, AspectRatio, Toggle, ToggleGroup, Collapsible, Accordion, Progress, AlertDialog, HoverCard, Drawer, ScrollArea, Toast, Slider, Table, ContextMenu, Menubar, InputOTP, Form, NavigationMenu, Calendar, DatePicker, Command, Combobox, DataTable, Carousel, Resizable, Sidebar
- Fixed 6 component bugs: Toggle disabled state, ContextMenu, InputOTP, NavigationMenu, Resizable
- Added universal_web dependency

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
