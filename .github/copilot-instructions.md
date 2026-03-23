# shadcn_jaspr — GitHub Copilot Instructions

## Library Overview

shadcn_jaspr is a Dart port of shadcn/ui for the Jaspr web framework. It provides 60 UI components and 10 authentication page blocks styled with Tailwind CSS v4.

Single import for all components:
```dart
import 'package:jaspr/jaspr.dart';
import 'package:shadcn_jaspr/shadcn_jaspr.dart';
```

## Component Usage Patterns

### Button
```dart
// Default button
ShadButton([Component.text('Click me')], onPressed: () {})

// Variants: defaultVariant, destructive, outline, secondary, ghost, link
ShadButton([Component.text('Delete')], variant: ButtonVariant.destructive)

// Sizes: defaultSize, xs, sm, lg, icon, iconXs, iconSm, iconLg
ShadButton([icon], size: ButtonSize.icon)

// Disabled
ShadButton([Component.text('Disabled')], isDisabled: true)
```

### Card (Composable Family)
```dart
ShadCard([
  ShadCardHeader([
    ShadCardTitle([Component.text('Account')]),
    ShadCardDescription([Component.text('Manage your account settings.')]),
  ]),
  ShadCardContent([
    // form fields here
  ]),
  ShadCardFooter([
    ShadButton([Component.text('Save')]),
  ]),
])
```

### Dialog
```dart
ShadDialog(
  children: [
    ShadDialogTrigger([
      ShadButton([Component.text('Open Dialog')]),
    ]),
    ShadDialogContent([
      ShadDialogHeader([
        ShadDialogTitle([Component.text('Are you sure?')]),
        ShadDialogDescription([Component.text('This action cannot be undone.')]),
      ]),
      ShadDialogFooter([
        ShadDialogClose([ShadButton([Component.text('Cancel')], variant: ButtonVariant.outline)]),
        ShadButton([Component.text('Continue')]),
      ]),
    ]),
  ],
)
```

### Tabs
```dart
ShadTabs(
  defaultValue: 'account',
  children: [
    ShadTabsList([
      ShadTabsTrigger(value: 'account', children: [Component.text('Account')]),
      ShadTabsTrigger(value: 'password', children: [Component.text('Password')]),
    ]),
    ShadTabsContent(value: 'account', children: [Component.text('Account settings...')]),
    ShadTabsContent(value: 'password', children: [Component.text('Password settings...')]),
  ],
)
```

### Select
```dart
ShadSelect(
  value: selectedValue,
  onValueChange: (v) => setState(() => selectedValue = v),
  children: [
    ShadSelectTrigger([ShadSelectValue(placeholder: 'Select a fruit')]),
    ShadSelectContent([
      ShadSelectItem(value: 'apple', children: [Component.text('Apple')]),
      ShadSelectItem(value: 'banana', children: [Component.text('Banana')]),
      ShadSelectSeparator(),
      ShadSelectItem(value: 'cherry', children: [Component.text('Cherry')]),
    ]),
  ],
)
```

### Form
```dart
ShadForm(
  onSubmit: (values) => print(values),
  children: [
    ShadFormField(
      name: 'email',
      children: [
        ShadFormItem([
          ShadFormLabel([Component.text('Email')]),
          ShadFormControl([ShadInput(placeholder: 'Enter email')]),
          ShadFormDescription([Component.text('Your email address.')]),
          ShadFormMessage(),
        ]),
      ],
    ),
    ShadButton([Component.text('Submit')]),
  ],
)
```

### Chart
```dart
ShadChartContainer(
  config: ChartConfig({
    'revenue': ChartConfigEntry(label: 'Revenue', color: 'var(--chart-1)'),
    'expenses': ChartConfigEntry(label: 'Expenses', color: 'var(--chart-2)'),
  }),
  children: [
    ShadBarChart(
      data: [
        {'month': 1, 'revenue': 186, 'expenses': 80},
        {'month': 2, 'revenue': 305, 'expenses': 200},
      ],
      dataKeys: ['revenue', 'expenses'],
    ),
  ],
)
```

### Authentication Blocks
```dart
// Pre-built login/signup pages
ShadLoginBlock01(onSubmit: () => handleLogin())
ShadSignupBlock01(onSubmit: () => handleSignup())
// Available: LoginBlock01-05, SignupBlock01-05
```

## Component API Quick Reference

```
ShadButton(children, {variant?, size?, isDisabled, onPressed?, className?})
ShadBadge(children, {variant?, className?})
ShadCard(children, {className?})  + Header, Title, Description, Content, Footer
ShadInput({type?, placeholder?, value?, isDisabled, onInput?, onChange?, className?})
ShadLabel(children, {htmlFor?, className?})
ShadSeparator({orientation, decorative, className?})
ShadCheckbox({checked?, onCheckedChange?, isDisabled, className?})
ShadSwitch({checked?, onCheckedChange?, isDisabled, size, className?})
ShadTextarea({value?, placeholder?, isDisabled, rows?, onInput?, className?})
ShadSelect({value?, onValueChange?, children})  + Trigger, Value, Content, Item
ShadRadioGroup({value?, onValueChange?, children})  + RadioGroupItem
ShadTabs({defaultValue, value?, onValueChange?, children})  + TabsList, TabsTrigger, TabsContent
ShadDialog({open?, onOpenChange?, children})  + Trigger, Content, Header, Footer, Title, Description, Close
ShadSheet({open?, onOpenChange?, children})  + Trigger, Content(side), Header, Footer, Title, Description
ShadDropdownMenu({open?, onOpenChange?, children})  + Trigger, Content, Item, Separator, Label
ShadTooltip({children, delayMs})  + Trigger, Content(side)
ShadPopover({open?, onOpenChange?, children})  + Trigger, Content(side)
ShadAlert(children, {variant?, className?})  + AlertTitle, AlertDescription
ShadAccordion({type, value?, children})  + AccordionItem, AccordionTrigger, AccordionContent
ShadToggle({pressed?, onPressedChange?, variant?, size?, isDisabled, children})
ShadToggleGroup({type, value?, variant?, size?, children})  + ToggleGroupItem
ShadSlider({value?, min, max, step, onValueChange?, isDisabled, className?})
ShadProgress({value, className?})
ShadCalendar({selected?, onSelect?, initialMonth?, className?})
ShadDatePicker({selected?, onSelect?, placeholder?, className?})
ShadDataTable<T>({data, columns, selectable, onSelectionChange?, pageSize?, className?})
ShadCombobox({value?, onValueChange?, options, placeholder?, className?})
ShadCommand({value?, onValueChange?, children})  + Input, List, Empty, Group, Item, Separator
ShadCarousel({index?, onIndexChange?, orientation, children})  + Content, Item, Previous, Next
ShadSidebarProvider({open?, onOpenChange?, children})  + Sidebar, Header, Content, Group, Menu, ...
ShadForm({errors?, onSubmit?, children})  + FormField, FormItem, FormLabel, FormControl, FormMessage
ShadBarChart({data, dataKeys, width?, height?})
ShadLineChart({data, dataKeys, width?, height?})
ShadAreaChart({data, dataKeys, width?, height?, fillOpacity?})
ShadPieChart({data, dataKeys, width?, height?, innerRadius?})
ShadSpinner({className?})
ShadSkeleton({className?})
ShadKbd(children)  + KbdGroup
```

## Utility Functions

```dart
// cn() — merge CSS classes (like clsx)
cn(['flex items-center', condition ? 'text-red' : null, className])

// CVA — class variance authority (used internally by components)
// CVA<V, S> for variant + size, CVASimple<V> for variant only
```

## Naming Conventions

- All components are prefixed with `Shad` (e.g., `ShadButton`, `ShadCard`)
- Enum default values use `defaultVariant` / `defaultSize` (not `default`)
- Disabled state: `isDisabled` (not `disabled`)
- Callbacks: `onPressed`, `onValueChange`, `onOpenChange`, `onCheckedChange`
- Children: `List<Component>` as first positional parameter
- Text: always wrap with `Component.text('...')`
- CSS override: `String? className` named parameter
