import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadCalendar extends StatefulComponent {
  final DateTime? selected;
  final ValueChanged<DateTime>? onSelect;
  final DateTime? initialMonth;
  final String? className;

  const ShadCalendar({
    this.selected,
    this.onSelect,
    this.initialMonth,
    this.className,
    super.key,
  });

  @override
  State<ShadCalendar> createState() => _ShadCalendarState();
}

class _ShadCalendarState extends State<ShadCalendar> {
  late int _displayYear;
  late int _displayMonth;

  @override
  void initState() {
    super.initState();
    final initial = component.initialMonth ?? component.selected ?? DateTime.now();
    _displayYear = initial.year;
    _displayMonth = initial.month;
  }

  void _prevMonth() {
    setState(() {
      _displayMonth--;
      if (_displayMonth < 1) {
        _displayMonth = 12;
        _displayYear--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      _displayMonth++;
      if (_displayMonth > 12) {
        _displayMonth = 1;
        _displayYear++;
      }
    });
  }

  void _selectDay(int day) {
    final date = DateTime(_displayYear, _displayMonth, day);
    component.onSelect?.call(date);
  }

  @override
  Component build(BuildContext context) {
    final daysInMonth = DateTime(_displayYear, _displayMonth + 1, 0).day;
    final firstWeekday = DateTime(_displayYear, _displayMonth, 1).weekday; // 1=Mon
    final weekdayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];

    final selected = component.selected;
    final isSelectedMonth = selected != null &&
        selected.year == _displayYear &&
        selected.month == _displayMonth;

    // Build grid cells
    final cells = <Component>[];
    // Empty cells before first day
    for (var i = 1; i < firstWeekday; i++) {
      cells.add(div([], classes: 'size-8'));
    }
    // Day cells
    for (var day = 1; day <= daysInMonth; day++) {
      final isSelected = isSelectedMonth && selected.day == day;
      final isToday = DateTime.now().year == _displayYear &&
          DateTime.now().month == _displayMonth &&
          DateTime.now().day == day;
      final d = day;

      cells.add(
        button(
          [Component.text('$day')],
          onClick: () => _selectDay(d),
          classes: cn([
            'inline-flex size-8 items-center justify-center rounded-md text-sm p-0 font-normal',
            if (isSelected)
              'bg-primary text-primary-foreground hover:bg-primary hover:text-primary-foreground'
            else
              'hover:bg-accent hover:text-accent-foreground',
            if (isToday && !isSelected) 'bg-accent text-accent-foreground',
          ]),
          attributes: {
            'data-slot': 'calendar-day',
            'data-day': '$day',
            if (isSelected) 'data-selected': '',
            if (isToday) 'data-today': '',
            'aria-selected': isSelected.toString(),
          },
        ),
      );
    }

    return div(
      [
        // Header with nav
        div(
          [
            button(
              [
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '16',
                    'height': '16',
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
                      attributes: {'d': 'm15 18-6-6 6-6'},
                    ),
                  ],
                ),
              ],
              onClick: _prevMonth,
              classes:
                  'inline-flex items-center justify-center rounded-md size-7 bg-transparent p-0 opacity-50 hover:opacity-100',
              attributes: {
                'data-slot': 'calendar-nav-prev',
                'aria-label': 'Previous month',
              },
            ),
            div(
              [Component.text('${monthNames[_displayMonth - 1]} $_displayYear')],
              classes: 'text-sm font-medium',
              attributes: {'data-slot': 'calendar-heading'},
            ),
            button(
              [
                Component.element(
                  tag: 'svg',
                  attributes: {
                    'xmlns': 'http://www.w3.org/2000/svg',
                    'width': '16',
                    'height': '16',
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
                      attributes: {'d': 'm9 18 6-6-6-6'},
                    ),
                  ],
                ),
              ],
              onClick: _nextMonth,
              classes:
                  'inline-flex items-center justify-center rounded-md size-7 bg-transparent p-0 opacity-50 hover:opacity-100',
              attributes: {
                'data-slot': 'calendar-nav-next',
                'aria-label': 'Next month',
              },
            ),
          ],
          classes: 'flex items-center justify-between px-1',
          attributes: {'data-slot': 'calendar-header'},
        ),
        // Weekday headers
        div(
          [
            for (final name in weekdayNames)
              div(
                [Component.text(name)],
                classes:
                    'text-muted-foreground flex size-8 items-center justify-center text-[0.8rem] font-normal',
              ),
          ],
          classes: 'grid grid-cols-7 mt-2',
        ),
        // Days grid
        div(
          cells,
          classes: 'grid grid-cols-7 mt-1 gap-y-1',
          attributes: {'data-slot': 'calendar-grid'},
        ),
      ],
      classes: cn(['p-3', component.className]),
      attributes: {
        'data-slot': 'calendar',
        'role': 'grid',
        'aria-label': '${monthNames[_displayMonth - 1]} $_displayYear',
      },
    );
  }
}
