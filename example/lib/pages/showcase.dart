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
            p([Component.text('A Dart port of shadcn/ui for Jaspr')],
                classes: 'text-lg text-muted-foreground mt-2'),
          ],
          classes: 'mb-12',
        ),

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
