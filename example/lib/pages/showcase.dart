import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:shadcn_jaspr/shadcn_jaspr.dart';

class ShowcasePage extends StatelessComponent {
  const ShowcasePage({super.key});

  @override
  Component build(BuildContext context) {
    return div(
      [
        // Header
        div(
          [
            h1([Component.text('shadcn_jaspr')], classes: 'text-4xl font-bold tracking-tight'),
            p([Component.text('A Dart port of shadcn/ui for Jaspr — 48 components')],
                classes: 'text-lg text-muted-foreground mt-2'),
          ],
          classes: 'mb-12',
        ),

        // ══════════════════════════════════════
        // EXISTING COMPONENTS
        // ══════════════════════════════════════

        // Buttons
        _section('Button', [
          div(
            [
              ShadButton([Component.text('Default')]),
              ShadButton([Component.text('Destructive')], variant: ButtonVariant.destructive),
              ShadButton([Component.text('Outline')], variant: ButtonVariant.outline),
              ShadButton([Component.text('Secondary')], variant: ButtonVariant.secondary),
              ShadButton([Component.text('Ghost')], variant: ButtonVariant.ghost),
              ShadButton([Component.text('Link')], variant: ButtonVariant.link),
            ],
            classes: 'flex flex-wrap gap-3',
          ),
          div(
            [
              ShadButton([Component.text('Small')], size: ButtonSize.sm),
              ShadButton([Component.text('Default')]),
              ShadButton([Component.text('Large')], size: ButtonSize.lg),
              ShadButton([Component.text('Disabled')], isDisabled: true),
            ],
            classes: 'flex flex-wrap items-center gap-3 mt-4',
          ),
        ]),

        // Badge
        _section('Badge', [
          div(
            [
              ShadBadge([Component.text('Default')]),
              ShadBadge([Component.text('Secondary')], variant: BadgeVariant.secondary),
              ShadBadge([Component.text('Destructive')], variant: BadgeVariant.destructive),
              ShadBadge([Component.text('Outline')], variant: BadgeVariant.outline),
            ],
            classes: 'flex flex-wrap gap-3',
          ),
        ]),

        // Card
        _section('Card', [
          ShadCard([
            ShadCardHeader([
              ShadCardTitle([Component.text('Card Title')]),
              ShadCardDescription([Component.text('Card description goes here.')]),
            ]),
            ShadCardContent([
              p([Component.text('Card content area. Put any components here.')]),
            ]),
            ShadCardFooter([
              ShadButton([Component.text('Cancel')], variant: ButtonVariant.outline),
              ShadButton([Component.text('Save')]),
            ]),
          ]),
        ]),

        // Input & Label
        _section('Input & Label', [
          div(
            [
              div(
                [
                  ShadLabel([Component.text('Email')], htmlFor: 'email'),
                  ShadInput(id: 'email', type: InputType.email, placeholder: 'Enter your email'),
                ],
                classes: 'grid gap-2 max-w-sm',
              ),
              div(
                [
                  ShadLabel([Component.text('Disabled')]),
                  ShadInput(placeholder: 'Disabled input', isDisabled: true),
                ],
                classes: 'grid gap-2 max-w-sm',
              ),
            ],
            classes: 'flex flex-wrap gap-8',
          ),
        ]),

        // Textarea
        _section('Textarea', [
          div(
            [
              ShadLabel([Component.text('Message')]),
              ShadTextarea(placeholder: 'Type your message here...'),
            ],
            classes: 'grid gap-2 max-w-lg',
          ),
        ]),

        // Separator
        _section('Separator', [
          div(
            [
              p([Component.text('Content above')]),
              ShadSeparator(),
              p([Component.text('Content below')]),
            ],
            classes: 'space-y-4 max-w-sm',
          ),
        ]),

        // Checkbox
        _section('Checkbox', [
          div(
            [
              div(
                [ShadCheckbox(checked: true), ShadLabel([Component.text('Accept terms and conditions')])],
                classes: 'flex items-center gap-2',
              ),
              div(
                [ShadCheckbox(isDisabled: true), ShadLabel([Component.text('Disabled checkbox')])],
                classes: 'flex items-center gap-2',
              ),
            ],
            classes: 'space-y-4',
          ),
        ]),

        // Switch
        _section('Switch', [
          div(
            [
              div(
                [ShadSwitch(), ShadLabel([Component.text('Airplane Mode')])],
                classes: 'flex items-center gap-2',
              ),
              div(
                [ShadSwitch(size: SwitchSize.sm), ShadLabel([Component.text('Small switch')])],
                classes: 'flex items-center gap-2',
              ),
            ],
            classes: 'space-y-4',
          ),
        ]),

        // Select
        _section('Select', [
          ShadSelect(
            children: [
              ShadSelectTrigger(
                [ShadSelectValue(placeholder: 'Select a fruit')],
                className: 'w-[180px]',
              ),
              ShadSelectContent([
                ShadSelectItem(value: 'apple', children: [Component.text('Apple')]),
                ShadSelectItem(value: 'banana', children: [Component.text('Banana')]),
                ShadSelectItem(value: 'orange', children: [Component.text('Orange')]),
                ShadSelectSeparator(),
                ShadSelectItem(value: 'grape', children: [Component.text('Grape')]),
              ]),
            ],
          ),
        ]),

        // Radio Group
        _section('Radio Group', [
          ShadRadioGroup(
            value: 'comfortable',
            children: [
              div([ShadRadioGroupItem(value: 'default'), ShadLabel([Component.text('Default')])],
                  classes: 'flex items-center gap-2'),
              div([ShadRadioGroupItem(value: 'comfortable'), ShadLabel([Component.text('Comfortable')])],
                  classes: 'flex items-center gap-2'),
              div([ShadRadioGroupItem(value: 'compact'), ShadLabel([Component.text('Compact')])],
                  classes: 'flex items-center gap-2'),
            ],
          ),
        ]),

        // Tabs
        _section('Tabs', [
          ShadTabs(
            defaultValue: 'account',
            children: [
              ShadTabsList([
                ShadTabsTrigger(value: 'account', children: [Component.text('Account')]),
                ShadTabsTrigger(value: 'password', children: [Component.text('Password')]),
              ]),
              ShadTabsContent(
                value: 'account',
                children: [
                  ShadCard([
                    ShadCardHeader([
                      ShadCardTitle([Component.text('Account')]),
                      ShadCardDescription([Component.text('Make changes to your account here.')]),
                    ]),
                    ShadCardContent([
                      div([ShadLabel([Component.text('Name')]), ShadInput(placeholder: 'Your name')],
                          classes: 'grid gap-2'),
                    ]),
                    ShadCardFooter([ShadButton([Component.text('Save changes')])]),
                  ]),
                ],
              ),
              ShadTabsContent(
                value: 'password',
                children: [
                  ShadCard([
                    ShadCardHeader([
                      ShadCardTitle([Component.text('Password')]),
                      ShadCardDescription([Component.text('Change your password here.')]),
                    ]),
                    ShadCardContent([
                      div(
                        [
                          ShadLabel([Component.text('Current password')]),
                          ShadInput(type: InputType.password),
                          ShadLabel([Component.text('New password')]),
                          ShadInput(type: InputType.password),
                        ],
                        classes: 'grid gap-2',
                      ),
                    ]),
                    ShadCardFooter([ShadButton([Component.text('Save password')])]),
                  ]),
                ],
              ),
            ],
          ),
        ]),

        // Breadcrumb
        _section('Breadcrumb', [
          ShadBreadcrumb([
            ShadBreadcrumbList([
              ShadBreadcrumbItem([ShadBreadcrumbLink([Component.text('Home')], href: '/')]),
              ShadBreadcrumbSeparator(),
              ShadBreadcrumbItem([ShadBreadcrumbLink([Component.text('Components')], href: '/components')]),
              ShadBreadcrumbSeparator(),
              ShadBreadcrumbItem([ShadBreadcrumbPage([Component.text('Breadcrumb')])]),
            ]),
          ]),
        ]),

        // Pagination
        _section('Pagination', [
          ShadPagination([
            ShadPaginationContent([
              ShadPaginationItem([ShadPaginationPrevious()]),
              ShadPaginationItem([ShadPaginationLink([Component.text('1')], isActive: true)]),
              ShadPaginationItem([ShadPaginationLink([Component.text('2')])]),
              ShadPaginationItem([ShadPaginationLink([Component.text('3')])]),
              ShadPaginationItem([ShadPaginationEllipsis()]),
              ShadPaginationItem([ShadPaginationNext()]),
            ]),
          ]),
        ]),

        // Dialog
        _section('Dialog', [
          ShadDialog(
            children: [
              ShadDialogTrigger([
                ShadButton([Component.text('Open Dialog')], variant: ButtonVariant.outline),
              ]),
              ShadDialogContent([
                ShadDialogHeader([
                  ShadDialogTitle([Component.text('Are you sure?')]),
                  ShadDialogDescription([
                    Component.text('This action cannot be undone. This will permanently delete your account.'),
                  ]),
                ]),
                ShadDialogFooter([
                  ShadButton([Component.text('Cancel')], variant: ButtonVariant.outline),
                  ShadButton([Component.text('Continue')]),
                ]),
              ]),
            ],
          ),
        ]),

        // Sheet
        _section('Sheet', [
          ShadSheet(
            children: [
              ShadSheetTrigger([
                ShadButton([Component.text('Open Sheet')], variant: ButtonVariant.outline),
              ]),
              ShadSheetContent(
                [
                  ShadSheetHeader([
                    ShadSheetTitle([Component.text('Edit profile')]),
                    ShadSheetDescription([Component.text('Make changes to your profile here.')]),
                  ]),
                  div(
                    [
                      ShadLabel([Component.text('Name')]),
                      ShadInput(placeholder: 'Your name'),
                      ShadLabel([Component.text('Username')]),
                      ShadInput(placeholder: '@username'),
                    ],
                    classes: 'grid gap-4 p-4',
                  ),
                  ShadSheetFooter([ShadButton([Component.text('Save changes')])]),
                ],
                side: SheetSide.right,
              ),
            ],
          ),
        ]),

        // Dropdown Menu
        _section('Dropdown Menu', [
          ShadDropdownMenu(
            children: [
              ShadDropdownMenuTrigger([
                ShadButton([Component.text('Open Menu')], variant: ButtonVariant.outline),
              ]),
              ShadDropdownMenuContent([
                ShadDropdownMenuLabel([Component.text('My Account')]),
                ShadDropdownMenuSeparator(),
                ShadDropdownMenuItem([Component.text('Profile')]),
                ShadDropdownMenuItem([Component.text('Billing')]),
                ShadDropdownMenuItem([Component.text('Settings')]),
                ShadDropdownMenuSeparator(),
                ShadDropdownMenuItem([Component.text('Log out')],
                    variant: DropdownMenuItemVariant.destructive),
              ]),
            ],
          ),
        ]),

        // Tooltip
        _section('Tooltip', [
          ShadTooltip(
            children: [
              ShadTooltipTrigger([
                ShadButton([Component.text('Hover me')], variant: ButtonVariant.outline),
              ]),
              ShadTooltipContent([Component.text('This is a tooltip')], side: TooltipSide.top),
            ],
          ),
        ]),

        // Popover
        _section('Popover', [
          ShadPopover(
            children: [
              ShadPopoverTrigger([
                ShadButton([Component.text('Open Popover')], variant: ButtonVariant.outline),
              ]),
              ShadPopoverContent([
                div(
                  [
                    h4([Component.text('Dimensions')], classes: 'font-medium leading-none'),
                    p([Component.text('Set the dimensions for the layer.')],
                        classes: 'text-sm text-muted-foreground'),
                  ],
                  classes: 'grid gap-2',
                ),
              ]),
            ],
          ),
        ]),

        // ══════════════════════════════════════
        // PHASE 1: Simple
        // ══════════════════════════════════════

        // Alert
        _section('Alert', [
          div(
            [
              ShadAlert([
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '16', 'height': '16',
                    'viewBox': '0 0 24 24', 'fill': 'none',
                    'stroke': 'currentColor', 'stroke-width': '2',
                    'stroke-linecap': 'round', 'stroke-linejoin': 'round',
                  },
                  children: [
                    Component.element(tag: 'circle', attributes: {'cx': '12', 'cy': '12', 'r': '10'}),
                    Component.element(tag: 'path', attributes: {'d': 'M12 16v-4'}),
                    Component.element(tag: 'path', attributes: {'d': 'M12 8h.01'}),
                  ],
                ),
                ShadAlertTitle([Component.text('Heads up!')]),
                ShadAlertDescription([Component.text('You can add components to your app using the CLI.')]),
              ]),
              div([], classes: 'h-4'),
              ShadAlert([
                ShadAlertTitle([Component.text('Error')]),
                ShadAlertDescription([Component.text('Your session has expired. Please log in again.')]),
              ], variant: AlertVariant.destructive),
            ],
            classes: 'max-w-lg space-y-4',
          ),
        ]),

        // Avatar
        _section('Avatar', [
          div(
            [
              ShadAvatar([
                ShadAvatarImage(src: 'https://github.com/shadcn.png', alt: 'shadcn'),
                ShadAvatarFallback([Component.text('CN')]),
              ]),
              ShadAvatar([
                ShadAvatarFallback([Component.text('JD')]),
              ]),
              ShadAvatar([
                ShadAvatarFallback([Component.text('AB')]),
              ], className: 'size-12'),
            ],
            classes: 'flex items-center gap-4',
          ),
        ]),

        // Skeleton
        _section('Skeleton', [
          div(
            [
              div(
                [
                  ShadSkeleton(className: 'size-12 rounded-full'),
                  div(
                    [
                      ShadSkeleton(className: 'h-4 w-[250px]'),
                      ShadSkeleton(className: 'h-4 w-[200px]'),
                    ],
                    classes: 'space-y-2',
                  ),
                ],
                classes: 'flex items-center gap-4',
              ),
            ],
          ),
        ]),

        // Aspect Ratio
        _section('Aspect Ratio', [
          div(
            [
              ShadAspectRatio(
                ratio: 16 / 9,
                children: [
                  div(
                    [Component.text('16:9')],
                    classes: 'flex items-center justify-center bg-muted rounded-md text-muted-foreground text-sm h-full',
                  ),
                ],
              ),
            ],
            classes: 'max-w-[400px]',
          ),
        ]),

        // ══════════════════════════════════════
        // PHASE 2: Stateful primitives
        // ══════════════════════════════════════

        // Toggle
        _section('Toggle', [
          div(
            [
              ShadToggle(
                children: [
                  Component.element(
                    tag: 'svg',
                    attributes: {
                      'xmlns': 'http://www.w3.org/2000/svg',
                      'width': '16', 'height': '16',
                      'viewBox': '0 0 24 24', 'fill': 'none',
                      'stroke': 'currentColor', 'stroke-width': '2',
                    },
                    children: [
                      Component.element(tag: 'path', attributes: {'d': 'M6 4h8a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z'}),
                      Component.element(tag: 'path', attributes: {'d': 'M6 12h9a4 4 0 0 1 4 4 4 4 0 0 1-4 4H6z'}),
                    ],
                  ),
                ],
              ),
              ShadToggle(
                variant: ToggleVariant.outline,
                children: [
                  Component.element(
                    tag: 'svg',
                    attributes: {
                      'xmlns': 'http://www.w3.org/2000/svg',
                      'width': '16', 'height': '16',
                      'viewBox': '0 0 24 24', 'fill': 'none',
                      'stroke': 'currentColor', 'stroke-width': '2',
                    },
                    children: [
                      Component.element(tag: 'path', attributes: {'d': 'M4 12h16'}),
                      Component.element(tag: 'path', attributes: {'d': 'M4 18h16'}),
                      Component.element(tag: 'path', attributes: {'d': 'M4 6h16'}),
                    ],
                  ),
                ],
              ),
              ShadToggle(
                isDisabled: true,
                children: [Component.text('Disabled')],
              ),
            ],
            classes: 'flex items-center gap-3',
          ),
        ]),

        // Toggle Group
        _section('Toggle Group', [
          ShadToggleGroup(
            type: ToggleGroupType.single,
            variant: ToggleGroupVariant.outline,
            children: [
              ShadToggleGroupItem(value: 'left', children: [Component.text('L')]),
              ShadToggleGroupItem(value: 'center', children: [Component.text('C')]),
              ShadToggleGroupItem(value: 'right', children: [Component.text('R')]),
            ],
          ),
        ]),

        // Collapsible
        _section('Collapsible', [
          ShadCollapsible(
            className: 'max-w-sm',
            children: [
              div(
                [
                  span([Component.text('@peduarte starred 3 repositories')], classes: 'text-sm font-semibold'),
                  ShadCollapsibleTrigger([
                    ShadButton([Component.text('Toggle')], variant: ButtonVariant.ghost, size: ButtonSize.sm),
                  ]),
                ],
                classes: 'flex items-center justify-between',
              ),
              div(
                [Component.text('@radix-ui/primitives')],
                classes: 'rounded-md border px-4 py-2 text-sm mt-2',
              ),
              ShadCollapsibleContent([
                div(
                  [Component.text('@radix-ui/colors')],
                  classes: 'rounded-md border px-4 py-2 text-sm mt-2',
                ),
                div(
                  [Component.text('@stitches/react')],
                  classes: 'rounded-md border px-4 py-2 text-sm mt-2',
                ),
              ]),
            ],
          ),
        ]),

        // Accordion
        _section('Accordion', [
          ShadAccordion(
            type: AccordionType.single,
            defaultValue: 'item-1',
            className: 'max-w-lg',
            children: [
              ShadAccordionItem(
                value: 'item-1',
                children: [
                  ShadAccordionTrigger([Component.text('Is it accessible?')]),
                  ShadAccordionContent([
                    Component.text('Yes. It adheres to the WAI-ARIA design pattern.'),
                  ]),
                ],
              ),
              ShadAccordionItem(
                value: 'item-2',
                children: [
                  ShadAccordionTrigger([Component.text('Is it styled?')]),
                  ShadAccordionContent([
                    Component.text('Yes. It comes with default styles that match the other components\' aesthetic.'),
                  ]),
                ],
              ),
              ShadAccordionItem(
                value: 'item-3',
                children: [
                  ShadAccordionTrigger([Component.text('Is it animated?')]),
                  ShadAccordionContent([
                    Component.text('Yes. It\'s animated by default, but you can disable it if you prefer.'),
                  ]),
                ],
              ),
            ],
          ),
        ]),

        // Progress
        _section('Progress', [
          div(
            [
              ShadProgress(value: 33),
              div([], classes: 'h-4'),
              ShadProgress(value: 66),
              div([], classes: 'h-4'),
              ShadProgress(value: 100),
            ],
            classes: 'max-w-lg',
          ),
        ]),

        // ══════════════════════════════════════
        // PHASE 3: Overlay derivatives + Medium
        // ══════════════════════════════════════

        // Alert Dialog
        _section('Alert Dialog', [
          ShadAlertDialog(
            children: [
              ShadAlertDialogTrigger([
                ShadButton([Component.text('Delete Account')], variant: ButtonVariant.destructive),
              ]),
              ShadAlertDialogContent([
                ShadAlertDialogHeader([
                  ShadAlertDialogTitle([Component.text('Are you absolutely sure?')]),
                  ShadAlertDialogDescription([
                    Component.text(
                        'This action cannot be undone. This will permanently delete your account and remove your data from our servers.'),
                  ]),
                ]),
                ShadAlertDialogFooter([
                  ShadAlertDialogCancel([
                    ShadButton([Component.text('Cancel')], variant: ButtonVariant.outline),
                  ]),
                  ShadAlertDialogAction([
                    ShadButton([Component.text('Continue')], variant: ButtonVariant.destructive),
                  ]),
                ]),
              ]),
            ],
          ),
        ]),

        // Hover Card
        _section('Hover Card', [
          ShadHoverCard(
            children: [
              ShadHoverCardTrigger([
                Component.element(
                  tag: 'a',
                  attributes: {
                    'href': '#',
                    'class': 'text-sm font-medium underline underline-offset-4',
                  },
                  children: [Component.text('@nextjs')],
                ),
              ]),
              ShadHoverCardContent([
                div(
                  [
                    ShadAvatar([ShadAvatarFallback([Component.text('NJ')])]),
                    div(
                      [
                        h4([Component.text('Next.js')], classes: 'text-sm font-semibold'),
                        p([Component.text('The React Framework – created and maintained by @vercel.')],
                            classes: 'text-sm'),
                      ],
                      classes: 'space-y-1',
                    ),
                  ],
                  classes: 'flex gap-4',
                ),
              ]),
            ],
          ),
        ]),

        // Drawer
        _section('Drawer', [
          ShadDrawer(
            children: [
              ShadDrawerTrigger([
                ShadButton([Component.text('Open Drawer')], variant: ButtonVariant.outline),
              ]),
              ShadDrawerContent([
                ShadDrawerHeader([
                  ShadDrawerTitle([Component.text('Move Goal')]),
                  ShadDrawerDescription([Component.text('Set your daily activity goal.')]),
                ]),
                div(
                  [
                    p([Component.text('Drag to adjust or use buttons.')],
                        classes: 'text-center text-muted-foreground text-sm'),
                  ],
                  classes: 'p-4',
                ),
                ShadDrawerFooter([
                  ShadButton([Component.text('Submit')]),
                  ShadDrawerClose([
                    ShadButton([Component.text('Cancel')], variant: ButtonVariant.outline),
                  ]),
                ]),
              ]),
            ],
          ),
        ]),

        // Scroll Area
        _section('Scroll Area', [
          div(
            [
              ShadScrollArea(
                [
                  div(
                    [
                      for (var i = 1; i <= 20; i++)
                        div(
                          [Component.text('Item $i')],
                          classes: 'py-2 border-b text-sm',
                        ),
                    ],
                    classes: 'p-4',
                  ),
                ],
                className: 'h-48 w-48 rounded-md border',
              ),
            ],
          ),
        ]),

        // Toast
        _section('Toast', [
          div(
            [
              ShadToast([
                div(
                  [
                    ShadToastTitle([Component.text('Scheduled: Catch up')]),
                    ShadToastDescription([Component.text('Friday, February 10, 2024 at 5:57 PM')]),
                  ],
                  classes: 'grid gap-1',
                ),
              ]),
              div([], classes: 'h-3'),
              ShadToast(
                [
                  div(
                    [
                      ShadToastTitle([Component.text('Uh oh! Something went wrong.')]),
                      ShadToastDescription([Component.text('There was a problem with your request.')]),
                    ],
                    classes: 'grid gap-1',
                  ),
                ],
                variant: ToastVariant.destructive,
              ),
            ],
            classes: 'max-w-sm space-y-3',
          ),
        ]),

        // Slider
        _section('Slider', [
          div(
            [
              ShadSlider(value: 33),
              div([], classes: 'h-6'),
              ShadSlider(value: 66, max: 100),
            ],
            classes: 'max-w-sm',
          ),
        ]),

        // Table
        _section('Table', [
          ShadTable([
            ShadTableHeader([
              ShadTableRow([
                ShadTableHead([Component.text('Invoice')]),
                ShadTableHead([Component.text('Status')]),
                ShadTableHead([Component.text('Method')]),
                ShadTableHead([Component.text('Amount')], className: 'text-right'),
              ]),
            ]),
            ShadTableBody([
              ShadTableRow([
                ShadTableCell([Component.text('INV001')], className: 'font-medium'),
                ShadTableCell([Component.text('Paid')]),
                ShadTableCell([Component.text('Credit Card')]),
                ShadTableCell([Component.text('\$250.00')], className: 'text-right'),
              ]),
              ShadTableRow([
                ShadTableCell([Component.text('INV002')], className: 'font-medium'),
                ShadTableCell([Component.text('Pending')]),
                ShadTableCell([Component.text('PayPal')]),
                ShadTableCell([Component.text('\$150.00')], className: 'text-right'),
              ]),
              ShadTableRow([
                ShadTableCell([Component.text('INV003')], className: 'font-medium'),
                ShadTableCell([Component.text('Unpaid')]),
                ShadTableCell([Component.text('Bank Transfer')]),
                ShadTableCell([Component.text('\$350.00')], className: 'text-right'),
              ]),
            ]),
            ShadTableFooter([
              ShadTableRow([
                ShadTableCell([Component.text('Total')], className: 'font-bold'),
                ShadTableCell([]),
                ShadTableCell([]),
                ShadTableCell([Component.text('\$750.00')], className: 'text-right font-bold'),
              ]),
            ]),
          ]),
        ]),

        // ══════════════════════════════════════
        // PHASE 4: Medium-Complex
        // ══════════════════════════════════════

        // Context Menu
        _section('Context Menu', [
          ShadContextMenu(
            children: [
              ShadContextMenuTrigger(
                [
                  div(
                    [Component.text('Right click here')],
                    classes: 'flex h-[150px] w-[300px] items-center justify-center rounded-md border border-dashed text-sm',
                  ),
                ],
              ),
              ShadContextMenuContent([
                ShadContextMenuItem([Component.text('Back')]),
                ShadContextMenuItem([Component.text('Forward')], isDisabled: true),
                ShadContextMenuItem([Component.text('Reload')]),
                ShadContextMenuSeparator(),
                ShadContextMenuLabel([Component.text('More Tools')]),
                ShadContextMenuItem([Component.text('Save Page As...')]),
                ShadContextMenuItem([Component.text('View Page Source')]),
                ShadContextMenuItem([Component.text('Inspect')]),
              ]),
            ],
          ),
        ]),

        // Menubar
        _section('Menubar', [
          ShadMenubar(
            children: [
              ShadMenubarMenu(
                value: 'file',
                children: [
                  ShadMenubarTrigger([Component.text('File')]),
                  ShadMenubarContent([
                    ShadMenubarItem([
                      Component.text('New Tab'),
                      ShadMenubarShortcut([Component.text('⌘T')]),
                    ]),
                    ShadMenubarItem([
                      Component.text('New Window'),
                      ShadMenubarShortcut([Component.text('⌘N')]),
                    ]),
                    ShadMenubarSeparator(),
                    ShadMenubarItem([Component.text('Share')]),
                    ShadMenubarSeparator(),
                    ShadMenubarItem([Component.text('Print')]),
                  ]),
                ],
              ),
              ShadMenubarMenu(
                value: 'edit',
                children: [
                  ShadMenubarTrigger([Component.text('Edit')]),
                  ShadMenubarContent([
                    ShadMenubarItem([
                      Component.text('Undo'),
                      ShadMenubarShortcut([Component.text('⌘Z')]),
                    ]),
                    ShadMenubarItem([
                      Component.text('Redo'),
                      ShadMenubarShortcut([Component.text('⌘Y')]),
                    ]),
                    ShadMenubarSeparator(),
                    ShadMenubarItem([Component.text('Cut')]),
                    ShadMenubarItem([Component.text('Copy')]),
                    ShadMenubarItem([Component.text('Paste')]),
                  ]),
                ],
              ),
              ShadMenubarMenu(
                value: 'view',
                children: [
                  ShadMenubarTrigger([Component.text('View')]),
                  ShadMenubarContent([
                    ShadMenubarCheckboxItem([Component.text('Always Show Bookmarks Bar')], checked: true),
                    ShadMenubarCheckboxItem([Component.text('Always Show Full URLs')]),
                    ShadMenubarSeparator(),
                    ShadMenubarItem([Component.text('Reload')]),
                    ShadMenubarItem([Component.text('Toggle Fullscreen')]),
                  ]),
                ],
              ),
            ],
          ),
        ]),

        // Input OTP
        _section('Input OTP', [
          ShadInputOTP(
            maxLength: 6,
            children: [
              ShadInputOTPGroup([
                ShadInputOTPSlot(index: 0),
                ShadInputOTPSlot(index: 1),
                ShadInputOTPSlot(index: 2),
              ]),
              ShadInputOTPSeparator(),
              ShadInputOTPGroup([
                ShadInputOTPSlot(index: 3),
                ShadInputOTPSlot(index: 4),
                ShadInputOTPSlot(index: 5),
              ]),
            ],
          ),
        ]),

        // Form
        _section('Form', [
          ShadForm(
            className: 'max-w-sm space-y-4',
            children: [
              ShadFormField(
                name: 'username',
                children: [
                  ShadFormItem([
                    ShadFormLabel([Component.text('Username')]),
                    ShadFormControl([
                      ShadInput(placeholder: 'shadcn'),
                    ]),
                    ShadFormDescription([Component.text('This is your public display name.')]),
                    ShadFormMessage(),
                  ]),
                ],
              ),
              ShadButton([Component.text('Submit')]),
            ],
          ),
        ]),

        // ══════════════════════════════════════
        // PHASE 5: Complex Composite
        // ══════════════════════════════════════

        // Navigation Menu
        _section('Navigation Menu', [
          ShadNavigationMenu(
            children: [
              ShadNavigationMenuList([
                ShadNavigationMenuItem(
                  value: 'getting-started',
                  children: [
                    ShadNavigationMenuTrigger([Component.text('Getting Started')]),
                    ShadNavigationMenuContent([
                      div(
                        [
                          ShadNavigationMenuLink(
                            href: '#',
                            children: [
                              div([Component.text('Introduction')], classes: 'text-sm font-medium leading-none'),
                              p([Component.text('Re-usable components built using Jaspr and Tailwind CSS.')],
                                  classes: 'text-sm leading-snug text-muted-foreground line-clamp-2'),
                            ],
                          ),
                          ShadNavigationMenuLink(
                            href: '#',
                            children: [
                              div([Component.text('Installation')], classes: 'text-sm font-medium leading-none'),
                              p([Component.text('How to install dependencies and structure your app.')],
                                  classes: 'text-sm leading-snug text-muted-foreground line-clamp-2'),
                            ],
                          ),
                        ],
                        classes: 'grid w-[400px] gap-3 p-4 md:grid-cols-2',
                      ),
                    ]),
                  ],
                ),
                ShadNavigationMenuItem(
                  value: 'components',
                  children: [
                    ShadNavigationMenuTrigger([Component.text('Components')]),
                    ShadNavigationMenuContent([
                      div(
                        [
                          ShadNavigationMenuLink(
                            href: '#',
                            children: [
                              div([Component.text('Alert Dialog')], classes: 'text-sm font-medium leading-none'),
                              p([Component.text('A modal dialog that interrupts the user.')],
                                  classes: 'text-sm leading-snug text-muted-foreground line-clamp-2'),
                            ],
                          ),
                          ShadNavigationMenuLink(
                            href: '#',
                            children: [
                              div([Component.text('Hover Card')], classes: 'text-sm font-medium leading-none'),
                              p([Component.text('For sighted users to preview content behind a link.')],
                                  classes: 'text-sm leading-snug text-muted-foreground line-clamp-2'),
                            ],
                          ),
                        ],
                        classes: 'grid w-[400px] gap-3 p-4 md:grid-cols-2',
                      ),
                    ]),
                  ],
                ),
              ]),
            ],
          ),
        ]),

        // Calendar
        _section('Calendar', [
          div(
            [
              ShadCalendar(
                className: 'rounded-md border w-fit',
              ),
            ],
          ),
        ]),

        // Date Picker
        _section('Date Picker', [
          ShadDatePicker(
            placeholder: 'Pick a date',
          ),
        ]),

        // Command
        _section('Command', [
          div(
            [
              ShadCommand(
                className: 'rounded-lg border shadow-md max-w-[450px]',
                children: [
                  ShadCommandInput(placeholder: 'Type a command or search...'),
                  ShadCommandList([
                    ShadCommandEmpty([Component.text('No results found.')]),
                    ShadCommandGroup(
                      [
                        ShadCommandItem(
                          value: 'calendar',
                          children: [Component.text('Calendar')],
                        ),
                        ShadCommandItem(
                          value: 'search',
                          children: [Component.text('Search')],
                        ),
                        ShadCommandItem(
                          value: 'settings',
                          children: [Component.text('Settings')],
                        ),
                      ],
                      heading: 'Suggestions',
                    ),
                    ShadCommandSeparator(),
                    ShadCommandGroup(
                      [
                        ShadCommandItem(
                          value: 'profile',
                          children: [Component.text('Profile')],
                          keywords: ['user', 'account'],
                        ),
                        ShadCommandItem(
                          value: 'billing',
                          children: [Component.text('Billing')],
                        ),
                        ShadCommandItem(
                          value: 'preferences',
                          children: [Component.text('Preferences')],
                          keywords: ['settings', 'config'],
                        ),
                      ],
                      heading: 'Settings',
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ]),

        // Combobox
        _section('Combobox', [
          ShadCombobox(
            placeholder: 'Select framework...',
            searchPlaceholder: 'Search framework...',
            emptyText: 'No framework found.',
            options: [
              ComboboxOption(value: 'next', label: 'Next.js'),
              ComboboxOption(value: 'svelte', label: 'SvelteKit'),
              ComboboxOption(value: 'nuxt', label: 'Nuxt.js'),
              ComboboxOption(value: 'remix', label: 'Remix'),
              ComboboxOption(value: 'astro', label: 'Astro'),
            ],
          ),
        ]),

        // Carousel
        _section('Carousel', [
          div(
            [
              ShadCarousel(
                className: 'w-full max-w-xs',
                children: [
                  ShadCarouselContent([
                    for (var i = 1; i <= 5; i++)
                      ShadCarouselItem([
                        div(
                          [
                            ShadCard([
                              ShadCardContent([
                                div(
                                  [Component.text('$i')],
                                  classes: 'flex items-center justify-center p-6 text-4xl font-semibold',
                                ),
                              ]),
                            ]),
                          ],
                          classes: 'p-1',
                        ),
                      ]),
                  ]),
                  ShadCarouselPrevious(),
                  ShadCarouselNext(),
                ],
              ),
            ],
            classes: 'flex justify-center',
          ),
        ]),

        // Resizable
        _section('Resizable', [
          div(
            [
              ShadResizablePanelGroup(
                className: 'max-w-md rounded-lg border h-[200px]',
                children: [
                  ShadResizablePanel(
                    defaultSize: 50,
                    children: [
                      div(
                        [Component.text('Panel One')],
                        classes: 'flex h-full items-center justify-center p-6',
                      ),
                    ],
                  ),
                  ShadResizableHandle(withHandle: true),
                  ShadResizablePanel(
                    defaultSize: 50,
                    children: [
                      div(
                        [Component.text('Panel Two')],
                        classes: 'flex h-full items-center justify-center p-6',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),

        // Sidebar (inline demo, not full layout)
        _section('Sidebar', [
          div(
            [
              p([Component.text('SidebarProvider, Sidebar, SidebarContent, SidebarMenu, SidebarMenuItem, SidebarMenuButton, SidebarTrigger, SidebarRail, SidebarInset — all available.')],
                  classes: 'text-sm text-muted-foreground'),
              div([], classes: 'h-3'),
              div(
                [
                  div(
                    [
                      div(
                        [Component.text('Sidebar Demo')],
                        classes: 'px-3 py-2 text-xs font-medium text-muted-foreground uppercase tracking-wider',
                      ),
                      for (final item in ['Dashboard', 'Projects', 'Settings', 'Help'])
                        div(
                          [Component.text(item)],
                          classes: 'flex items-center gap-2 rounded-md px-3 py-2 text-sm hover:bg-accent hover:text-accent-foreground cursor-pointer',
                        ),
                    ],
                    classes: 'w-[220px] border rounded-lg bg-sidebar p-2',
                  ),
                ],
              ),
            ],
          ),
        ]),

        // Footer
        div(
          [
            ShadSeparator(),
            p(
              [Component.text('shadcn_jaspr — 48 components. Built with Jaspr + Tailwind CSS.')],
              classes: 'text-sm text-muted-foreground mt-6 text-center',
            ),
          ],
          classes: 'mt-8 pb-12',
        ),
      ],
      classes: 'container mx-auto max-w-4xl py-12 px-4',
    );
  }
}

Component _section(String title, List<Component> children) {
  return div(
    [
      h2([Component.text(title)], classes: 'text-2xl font-semibold tracking-tight mb-4'),
      ...children,
    ],
    classes: 'mb-12',
  );
}
