import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ComboboxOption {
  final String value;
  final String label;

  const ComboboxOption({required this.value, required this.label});
}

class ShadCombobox extends StatefulComponent {
  final String? value;
  final ValueChanged<String>? onValueChange;
  final List<ComboboxOption> options;
  final String? placeholder;
  final String? searchPlaceholder;
  final String? emptyText;
  final String? className;

  const ShadCombobox({
    this.value,
    this.onValueChange,
    required this.options,
    this.placeholder,
    this.searchPlaceholder,
    this.emptyText,
    this.className,
    super.key,
  });

  @override
  State<ShadCombobox> createState() => _ShadComboboxState();
}

class _ShadComboboxState extends State<ShadCombobox> {
  bool _isOpen = false;
  String _search = '';
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = component.value;
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) _search = '';
    });
  }

  void _select(String value) {
    setState(() {
      _selected = _selected == value ? null : value;
      _isOpen = false;
    });
    if (_selected != null) {
      component.onValueChange?.call(_selected!);
    }
  }

  @override
  Component build(BuildContext context) {
    final selectedLabel = component.options
        .where((o) => o.value == _selected)
        .map((o) => o.label)
        .firstOrNull;

    final filteredOptions = _search.isEmpty
        ? component.options
        : component.options
            .where(
                (o) => o.label.toLowerCase().contains(_search.toLowerCase()))
            .toList();

    return div(
      [
        // Trigger
        button(
          [
            Component.text(selectedLabel ?? component.placeholder ?? 'Select...'),
            // Chevron
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
                'class': 'ml-2 size-4 shrink-0 opacity-50',
              },
              children: [
                Component.element(
                  tag: 'path',
                  attributes: {'d': 'm7 15 5 5 5-5'},
                ),
                Component.element(
                  tag: 'path',
                  attributes: {'d': 'm7 9 5-5 5 5'},
                ),
              ],
            ),
          ],
          onClick: _toggle,
          classes: cn([
            'flex h-9 w-[200px] items-center justify-between whitespace-nowrap rounded-md border border-input bg-transparent px-3 py-2 text-sm shadow-xs ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50',
            if (selectedLabel == null) 'text-muted-foreground',
            component.className,
          ]),
          attributes: {
            'data-slot': 'combobox-trigger',
            'role': 'combobox',
            'aria-expanded': _isOpen.toString(),
            'aria-haspopup': 'listbox',
          },
        ),
        // Dropdown
        if (_isOpen)
          Component.fragment([
            div(
              [],
              classes: 'fixed inset-0 z-40',
              events: {'click': (_) => setState(() => _isOpen = false)},
            ),
            div(
              [
                // Search
                div(
                  [
                    Component.element(
                      tag: 'input',
                      attributes: {
                        'class':
                            'flex h-9 w-full rounded-md bg-transparent px-3 py-2 text-sm outline-none placeholder:text-muted-foreground',
                        'placeholder':
                            component.searchPlaceholder ?? 'Search...',
                        'value': _search,
                        'data-slot': 'combobox-search',
                      },
                      events: events<String>(
                        onInput: (value) {
                          setState(() {
                            _search = value;
                          });
                        },
                      ),
                    ),
                  ],
                  classes: 'border-b px-1',
                ),
                // Options
                div(
                  [
                    if (filteredOptions.isEmpty)
                      div(
                        [
                          Component.text(
                              component.emptyText ?? 'No results found.')
                        ],
                        classes: 'py-6 text-center text-sm',
                      )
                    else
                      for (final option in filteredOptions)
                        div(
                          [
                            span(
                              [
                                if (_selected == option.value)
                                  Component.element(
                                    tag: 'svg',
                                    attributes: {
                                      'xmlns':
                                          'http://www.w3.org/2000/svg',
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
                                      Component.element(
                                        tag: 'path',
                                        attributes: {
                                          'd': 'M20 6 9 17l-5-5'
                                        },
                                      ),
                                    ],
                                  ),
                              ],
                              classes: 'mr-2 size-4',
                            ),
                            Component.text(option.label),
                          ],
                          classes:
                              'relative flex cursor-default select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-accent hover:text-accent-foreground',
                          events: {
                            'click': (_) => _select(option.value),
                          },
                          attributes: {
                            'data-slot': 'combobox-item',
                            'data-value': option.value,
                            'role': 'option',
                            'aria-selected':
                                (_selected == option.value).toString(),
                          },
                        ),
                  ],
                  classes: 'max-h-[300px] overflow-y-auto p-1',
                ),
              ],
              classes:
                  'absolute z-50 mt-1 min-w-[200px] overflow-hidden rounded-md border bg-popover text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
              attributes: {
                'data-slot': 'combobox-content',
                'data-state': 'open',
              },
            ),
          ]),
      ],
      classes: 'relative inline-block',
      attributes: {'data-slot': 'combobox'},
    );
  }
}
