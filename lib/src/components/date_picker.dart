import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ShadDatePicker extends StatefulComponent {
  final DateTime? selected;
  final ValueChanged<DateTime>? onSelect;
  final String? placeholder;
  final String? className;

  const ShadDatePicker({
    this.selected,
    this.onSelect,
    this.placeholder,
    this.className,
    super.key,
  });

  @override
  State<ShadDatePicker> createState() => _ShadDatePickerState();
}

class _ShadDatePickerState extends State<ShadDatePicker> {
  bool _isOpen = false;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = component.selected;
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _onSelect(DateTime date) {
    setState(() {
      _selected = date;
      _isOpen = false;
    });
    component.onSelect?.call(date);
  }

  String _formatDate(DateTime date) {
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Component build(BuildContext context) {
    return div(
      [
        // Trigger button
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
                'class': 'mr-2 size-4',
              },
              children: [
                Component.element(tag: 'path', attributes: {'d': 'M8 2v4'}),
                Component.element(tag: 'path', attributes: {'d': 'M16 2v4'}),
                Component.element(
                  tag: 'rect',
                  attributes: {
                    'width': '18',
                    'height': '18',
                    'x': '3',
                    'y': '4',
                    'rx': '2',
                  },
                ),
                Component.element(tag: 'path', attributes: {'d': 'M3 10h18'}),
              ],
            ),
            Component.text(
              _selected != null
                  ? _formatDate(_selected!)
                  : (component.placeholder ?? 'Pick a date'),
            ),
          ],
          onClick: _toggle,
          classes: cn([
            'inline-flex items-center justify-start whitespace-nowrap rounded-md text-sm font-normal ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 border border-input bg-background hover:bg-accent hover:text-accent-foreground h-9 px-3 py-2 w-[240px]',
            if (_selected == null) 'text-muted-foreground',
            component.className,
          ]),
          attributes: {
            'data-slot': 'date-picker-trigger',
            'aria-haspopup': 'dialog',
            'aria-expanded': _isOpen.toString(),
          },
        ),
        // Calendar popover
        if (_isOpen)
          Component.fragment([
            // Backdrop
            div(
              [],
              classes: 'fixed inset-0 z-40',
              events: {'click': (_) => setState(() => _isOpen = false)},
            ),
            div(
              [
                // Inline calendar widget
                _DatePickerCalendar(
                  selected: _selected,
                  onSelect: _onSelect,
                ),
              ],
              classes:
                  'absolute z-50 mt-1 rounded-md border bg-popover text-popover-foreground shadow-md animate-in fade-in-0 zoom-in-95',
              attributes: {
                'data-slot': 'date-picker-content',
                'data-state': 'open',
              },
            ),
          ]),
      ],
      classes: 'relative inline-block',
      attributes: {'data-slot': 'date-picker'},
    );
  }
}

/// Internal calendar for DatePicker
class _DatePickerCalendar extends StatefulComponent {
  final DateTime? selected;
  final ValueChanged<DateTime> onSelect;

  const _DatePickerCalendar({
    this.selected,
    required this.onSelect,
  });

  @override
  State<_DatePickerCalendar> createState() => _DatePickerCalendarState();
}

class _DatePickerCalendarState extends State<_DatePickerCalendar> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    final initial = component.selected ?? DateTime.now();
    _year = initial.year;
    _month = initial.month;
  }

  void _prevMonth() {
    setState(() {
      _month--;
      if (_month < 1) { _month = 12; _year--; }
    });
  }

  void _nextMonth() {
    setState(() {
      _month++;
      if (_month > 12) { _month = 1; _year++; }
    });
  }

  @override
  Component build(BuildContext context) {
    final daysInMonth = DateTime(_year, _month + 1, 0).day;
    final firstWeekday = DateTime(_year, _month, 1).weekday;
    final weekdays = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final sel = component.selected;
    final isSelMonth = sel != null && sel.year == _year && sel.month == _month;

    final cells = <Component>[];
    for (var i = 1; i < firstWeekday; i++) {
      cells.add(div([], classes: 'size-8'));
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final isSel = isSelMonth && sel.day == day;
      final isToday = DateTime.now().year == _year &&
          DateTime.now().month == _month &&
          DateTime.now().day == day;
      final d = day;
      cells.add(
        button(
          [Component.text('$day')],
          onClick: () => component.onSelect(DateTime(_year, _month, d)),
          classes: cn([
            'inline-flex size-8 items-center justify-center rounded-md text-sm p-0 font-normal',
            if (isSel)
              'bg-primary text-primary-foreground'
            else
              'hover:bg-accent hover:text-accent-foreground',
            if (isToday && !isSel) 'bg-accent text-accent-foreground',
          ]),
        ),
      );
    }

    return div(
      [
        div(
          [
            button(
              [Component.text('<')],
              onClick: _prevMonth,
              classes: 'inline-flex items-center justify-center size-7 bg-transparent p-0 opacity-50 hover:opacity-100',
            ),
            div([Component.text('${months[_month - 1]} $_year')], classes: 'text-sm font-medium'),
            button(
              [Component.text('>')],
              onClick: _nextMonth,
              classes: 'inline-flex items-center justify-center size-7 bg-transparent p-0 opacity-50 hover:opacity-100',
            ),
          ],
          classes: 'flex items-center justify-between px-1',
        ),
        div(
          [for (final n in weekdays) div([Component.text(n)], classes: 'text-muted-foreground flex size-8 items-center justify-center text-[0.8rem]')],
          classes: 'grid grid-cols-7 mt-2',
        ),
        div(cells, classes: 'grid grid-cols-7 mt-1 gap-y-1'),
      ],
      classes: 'p-3',
    );
  }
}
