import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class DataTableColumn<T> {
  final String id;
  final String header;
  final List<Component> Function(T row) cell;
  final bool sortable;

  const DataTableColumn({
    required this.id,
    required this.header,
    required this.cell,
    this.sortable = false,
  });
}

enum SortDirection { asc, desc }

class ShadDataTable<T> extends StatefulComponent {
  final List<T> data;
  final List<DataTableColumn<T>> columns;
  final bool selectable;
  final ValueChanged<List<T>>? onSelectionChange;
  final int? pageSize;
  final String? className;

  const ShadDataTable({
    required this.data,
    required this.columns,
    this.selectable = false,
    this.onSelectionChange,
    this.pageSize,
    this.className,
    super.key,
  });

  @override
  State<ShadDataTable<T>> createState() => _ShadDataTableState<T>();
}

class _ShadDataTableState<T> extends State<ShadDataTable<T>> {
  String? _sortColumn;
  SortDirection _sortDirection = SortDirection.asc;
  Set<int> _selectedIndices = {};
  int _currentPage = 0;

  void _toggleSort(String columnId) {
    setState(() {
      if (_sortColumn == columnId) {
        _sortDirection = _sortDirection == SortDirection.asc
            ? SortDirection.desc
            : SortDirection.asc;
      } else {
        _sortColumn = columnId;
        _sortDirection = SortDirection.asc;
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices = Set.from(_selectedIndices)..remove(index);
      } else {
        _selectedIndices = Set.from(_selectedIndices)..add(index);
      }
    });
    _notifySelection();
  }

  void _toggleSelectAll(List<T> rows) {
    setState(() {
      if (_selectedIndices.length == rows.length) {
        _selectedIndices = {};
      } else {
        _selectedIndices = Set.from(List.generate(rows.length, (i) => i));
      }
    });
    _notifySelection();
  }

  void _notifySelection() {
    component.onSelectionChange
        ?.call(_selectedIndices.map((i) => component.data[i]).toList());
  }

  @override
  Component build(BuildContext context) {
    final data = component.data;
    final pageSize = component.pageSize;
    final totalPages =
        pageSize != null ? (data.length / pageSize).ceil() : 1;

    // Paginate
    final paginatedData = pageSize != null
        ? data.skip(_currentPage * pageSize).take(pageSize).toList()
        : data;

    return div(
      [
        // Table
        div(
          [
            Component.element(
              tag: 'table',
              classes: cn(['w-full caption-bottom text-sm', component.className]),
              attributes: {'data-slot': 'data-table'},
              children: [
                // Header
                Component.element(
                  tag: 'thead',
                  classes: '[&_tr]:border-b',
                  attributes: {'data-slot': 'data-table-header'},
                  children: [
                    Component.element(
                      tag: 'tr',
                      classes:
                          'border-b transition-colors hover:bg-muted/50',
                      children: [
                        if (component.selectable)
                          Component.element(
                            tag: 'th',
                            classes: 'h-10 w-10 px-2',
                            children: [
                              button(
                                [
                                  div(
                                    [
                                      if (_selectedIndices.length ==
                                          paginatedData.length &&
                                          paginatedData.isNotEmpty)
                                        Component.element(
                                          tag: 'svg',
                                          attributes: {
                                            'xmlns': 'http://www.w3.org/2000/svg',
                                            'width': '14',
                                            'height': '14',
                                            'viewBox': '0 0 24 24',
                                            'fill': 'none',
                                            'stroke': 'currentColor',
                                            'stroke-width': '3',
                                          },
                                          children: [
                                            Component.element(
                                              tag: 'path',
                                              attributes: {'d': 'M20 6 9 17l-5-5'},
                                            ),
                                          ],
                                        ),
                                    ],
                                    classes: 'grid place-content-center',
                                  ),
                                ],
                                onClick: () =>
                                    _toggleSelectAll(paginatedData),
                                classes:
                                    'size-4 shrink-0 rounded-[4px] border border-input shadow-xs',
                                attributes: {
                                  'role': 'checkbox',
                                  'aria-checked': (_selectedIndices.length ==
                                          paginatedData.length &&
                                      paginatedData.isNotEmpty)
                                      .toString(),
                                },
                              ),
                            ],
                          ),
                        for (final col in component.columns)
                          Component.element(
                            tag: 'th',
                            classes:
                                'h-10 px-2 text-left align-middle font-medium text-muted-foreground',
                            attributes: {'data-column': col.id},
                            children: [
                              if (col.sortable)
                                button(
                                  [
                                    Component.text(col.header),
                                    Component.text(
                                        _sortColumn == col.id
                                            ? (_sortDirection == SortDirection.asc
                                                ? ' \u2191'
                                                : ' \u2193')
                                            : ''),
                                  ],
                                  onClick: () => _toggleSort(col.id),
                                  classes:
                                      'inline-flex items-center gap-1 hover:text-foreground',
                                )
                              else
                                Component.text(col.header),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
                // Body
                Component.element(
                  tag: 'tbody',
                  classes: '[&_tr:last-child]:border-0',
                  attributes: {'data-slot': 'data-table-body'},
                  children: [
                    if (paginatedData.isEmpty)
                      Component.element(
                        tag: 'tr',
                        children: [
                          Component.element(
                            tag: 'td',
                            classes:
                                'h-24 text-center text-muted-foreground',
                            attributes: {
                              'colspan':
                                  '${component.columns.length + (component.selectable ? 1 : 0)}',
                            },
                            children: [Component.text('No results.')],
                          ),
                        ],
                      )
                    else
                      for (var i = 0; i < paginatedData.length; i++)
                        Component.element(
                          tag: 'tr',
                          classes: cn([
                            'border-b transition-colors hover:bg-muted/50',
                            if (_selectedIndices.contains(i)) 'bg-muted',
                          ]),
                          attributes: {
                            'data-state':
                                _selectedIndices.contains(i) ? 'selected' : '',
                          },
                          children: [
                            if (component.selectable)
                              Component.element(
                                tag: 'td',
                                classes: 'w-10 px-2',
                                children: [
                                  _buildCheckbox(i),
                                ],
                              ),
                            for (final col in component.columns)
                              Component.element(
                                tag: 'td',
                                classes: 'p-2 align-middle',
                                children: col.cell(paginatedData[i]),
                              ),
                          ],
                        ),
                  ],
                ),
              ],
            ),
          ],
          classes: 'relative w-full overflow-x-auto rounded-md border',
        ),
        // Pagination
        if (pageSize != null && totalPages > 1)
          div(
            [
              div(
                [
                  Component.text(
                      '${_selectedIndices.length} of ${data.length} row(s) selected.'),
                ],
                classes: 'flex-1 text-sm text-muted-foreground',
              ),
              div(
                [
                  button(
                    [Component.text('Previous')],
                    disabled: _currentPage <= 0,
                    onClick: () {
                      setState(() => _currentPage--);
                    },
                    classes:
                        'inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent h-8 px-3',
                  ),
                  button(
                    [Component.text('Next')],
                    disabled: _currentPage >= totalPages - 1,
                    onClick: () {
                      setState(() => _currentPage++);
                    },
                    classes:
                        'inline-flex items-center justify-center rounded-md text-sm font-medium border border-input bg-background hover:bg-accent h-8 px-3',
                  ),
                ],
                classes: 'flex items-center gap-2',
              ),
            ],
            classes: 'flex items-center justify-between py-4',
            attributes: {'data-slot': 'data-table-pagination'},
          ),
      ],
      attributes: {'data-slot': 'data-table-wrapper'},
    );
  }

  Component _buildCheckbox(int index) {
    final isChecked = _selectedIndices.contains(index);
    return button(
      [
        if (isChecked)
          div(
            [
              Component.element(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '14',
                  'height': '14',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '3',
                },
                children: [
                  Component.element(
                    tag: 'path',
                    attributes: {'d': 'M20 6 9 17l-5-5'},
                  ),
                ],
              ),
            ],
            classes: 'grid place-content-center',
          ),
      ],
      onClick: () => _toggleSelection(index),
      classes:
          'size-4 shrink-0 rounded-[4px] border border-input shadow-xs data-[state=checked]:border-primary data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground',
      attributes: {
        'role': 'checkbox',
        'aria-checked': isChecked.toString(),
        'data-state': isChecked ? 'checked' : 'unchecked',
      },
    );
  }
}
