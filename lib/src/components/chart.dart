import 'dart:math' as math;

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

class ChartConfigEntry {
  final String label;
  final String? color;
  final String? icon;

  const ChartConfigEntry({
    required this.label,
    this.color,
    this.icon,
  });
}

class ChartConfig {
  final Map<String, ChartConfigEntry> entries;

  const ChartConfig(this.entries);

  String toCssStyle() {
    final parts = <String>[];
    var index = 1;
    for (final entry in entries.entries) {
      final color = entry.value.color ?? 'var(--chart-$index)';
      parts.add('--color-${entry.key}: $color');
      index++;
    }
    return parts.join('; ');
  }
}

class ShadChartContainer extends StatelessComponent {
  final ChartConfig config;
  final List<Component> children;
  final String? className;

  const ShadChartContainer({
    required this.config,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex aspect-video justify-center text-xs [&_.recharts-cartesian-axis-tick_text]:fill-muted-foreground [&_.recharts-cartesian-grid_line[stroke=#ccc]]:stroke-border/50 [&_.recharts-curve.recharts-tooltip-cursor]:stroke-border [&_.recharts-polar-grid_[stroke=#ccc]]:stroke-border [&_.recharts-radial-bar-background-sector]:fill-muted [&_.recharts-rectangle.recharts-tooltip-cursor]:fill-muted [&_.recharts-reference-line_[stroke=#ccc]]:stroke-border',
        className,
      ]),
      attributes: {
        'data-slot': 'chart',
        'data-chart': '',
        'style': config.toCssStyle(),
      },
    );
  }
}

class ShadChartTooltip extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadChartTooltip(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'pointer-events-none absolute z-50 overflow-hidden rounded-lg border bg-background px-3 py-1.5 text-sm shadow-xl',
        className,
      ]),
      attributes: {'data-slot': 'chart-tooltip'},
    );
  }
}

class ShadChartTooltipContent extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadChartTooltipContent(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex flex-col gap-1 text-muted-foreground',
        className,
      ]),
      attributes: {'data-slot': 'chart-tooltip-content'},
    );
  }
}

class ShadChartLegend extends StatelessComponent {
  final List<Component> children;
  final String? className;

  const ShadChartLegend(this.children, {this.className, super.key});

  @override
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex items-center justify-center gap-4',
        className,
      ]),
      attributes: {'data-slot': 'chart-legend'},
    );
  }
}

class ShadChartLegendContent extends StatelessComponent {
  final ChartConfig config;
  final String? className;

  const ShadChartLegendContent({
    required this.config,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final items = config.entries.entries.map((entry) {
      return div(
        [
          div([],
              classes:
                  'size-2.5 shrink-0 rounded-[2px] bg-[var(--color-${entry.key})]'),
          Component.text(entry.value.label),
        ],
        classes: 'flex items-center gap-1.5 text-sm text-muted-foreground',
      );
    }).toList();

    return div(
      items,
      classes: cn([
        'flex items-center justify-center gap-4',
        className,
      ]),
      attributes: {'data-slot': 'chart-legend-content'},
    );
  }
}

class ShadBarChart extends StatelessComponent {
  final List<Map<String, num>> data;
  final List<String> dataKeys;
  final String? categoryKey;
  final double width;
  final double height;
  final String? className;

  const ShadBarChart({
    required this.data,
    required this.dataKeys,
    this.categoryKey,
    this.width = 600,
    this.height = 300,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'bar-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final maxVal = data.fold<num>(0, (prev, row) {
      final rowMax = dataKeys.fold<num>(0, (p, key) {
        final v = row[key] ?? 0;
        return v > p ? v : p;
      });
      return rowMax > prev ? rowMax : prev;
    });

    final padding = 40.0;
    final chartW = width - padding * 2;
    final chartH = height - padding * 2;
    final groupW = chartW / data.length;
    final barW = (groupW * 0.7) / dataKeys.length;

    final bars = <Component>[];
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < dataKeys.length; j++) {
        final val = data[i][dataKeys[j]] ?? 0;
        final barH = maxVal > 0 ? (val / maxVal) * chartH : 0;
        final x = padding + i * groupW + (groupW * 0.15) + j * barW;
        final y = padding + chartH - barH;

        bars.add(Component.element(
          tag: 'rect',
          attributes: {
            'x': x.toStringAsFixed(1),
            'y': y.toStringAsFixed(1),
            'width': barW.toStringAsFixed(1),
            'height': barH.toStringAsFixed(1),
            'fill': 'var(--color-${dataKeys[j]})',
            'rx': '2',
          },
        ));
      }
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'bar-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: bars,
    );
  }
}

class ShadLineChart extends StatelessComponent {
  final List<Map<String, num>> data;
  final List<String> dataKeys;
  final double width;
  final double height;
  final String? className;

  const ShadLineChart({
    required this.data,
    required this.dataKeys,
    this.width = 600,
    this.height = 300,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'line-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final maxVal = data.fold<num>(0, (prev, row) {
      final rowMax = dataKeys.fold<num>(0, (p, key) {
        final v = row[key] ?? 0;
        return v > p ? v : p;
      });
      return rowMax > prev ? rowMax : prev;
    });

    final padding = 40.0;
    final chartW = width - padding * 2;
    final chartH = height - padding * 2;
    final stepX = data.length > 1 ? chartW / (data.length - 1) : chartW;

    final lines = <Component>[];
    for (final key in dataKeys) {
      final points = <String>[];
      for (var i = 0; i < data.length; i++) {
        final val = data[i][key] ?? 0;
        final x = padding + i * stepX;
        final y = padding + chartH - (maxVal > 0 ? (val / maxVal) * chartH : 0);
        points.add('${x.toStringAsFixed(1)},${y.toStringAsFixed(1)}');
      }

      lines.add(Component.element(
        tag: 'polyline',
        attributes: {
          'points': points.join(' '),
          'fill': 'none',
          'stroke': 'var(--color-$key)',
          'stroke-width': '2',
          'stroke-linecap': 'round',
          'stroke-linejoin': 'round',
        },
      ));
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'line-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: lines,
    );
  }
}

class ShadAreaChart extends StatelessComponent {
  final List<Map<String, num>> data;
  final List<String> dataKeys;
  final double width;
  final double height;
  final double fillOpacity;
  final String? className;

  const ShadAreaChart({
    required this.data,
    required this.dataKeys,
    this.width = 600,
    this.height = 300,
    this.fillOpacity = 0.3,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'area-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final maxVal = data.fold<num>(0, (prev, row) {
      final rowMax = dataKeys.fold<num>(0, (p, key) {
        final v = row[key] ?? 0;
        return v > p ? v : p;
      });
      return rowMax > prev ? rowMax : prev;
    });

    final padding = 40.0;
    final chartW = width - padding * 2;
    final chartH = height - padding * 2;
    final stepX = data.length > 1 ? chartW / (data.length - 1) : chartW;
    final baseline = padding + chartH;

    final elements = <Component>[];
    for (final key in dataKeys) {
      final linePoints = <String>[];
      for (var i = 0; i < data.length; i++) {
        final val = data[i][key] ?? 0;
        final x = padding + i * stepX;
        final y =
            padding + chartH - (maxVal > 0 ? (val / maxVal) * chartH : 0);
        linePoints.add('${x.toStringAsFixed(1)},${y.toStringAsFixed(1)}');
      }

      // Polygon: line points + bottom-right + bottom-left to close the area
      final firstX = padding;
      final lastX = padding + (data.length - 1) * stepX;
      final polygonPoints =
          '${linePoints.join(' ')} ${lastX.toStringAsFixed(1)},${baseline.toStringAsFixed(1)} ${firstX.toStringAsFixed(1)},${baseline.toStringAsFixed(1)}';

      elements.add(Component.element(
        tag: 'polygon',
        attributes: {
          'points': polygonPoints,
          'fill': 'var(--color-$key)',
          'fill-opacity': fillOpacity.toString(),
          'stroke': 'none',
        },
      ));

      elements.add(Component.element(
        tag: 'polyline',
        attributes: {
          'points': linePoints.join(' '),
          'fill': 'none',
          'stroke': 'var(--color-$key)',
          'stroke-width': '2',
          'stroke-linecap': 'round',
          'stroke-linejoin': 'round',
        },
      ));
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'area-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: elements,
    );
  }
}

class ShadPieChart extends StatelessComponent {
  final List<Map<String, num>> data;
  final List<String> dataKeys;
  final double width;
  final double height;
  final double innerRadius;
  final String? className;

  const ShadPieChart({
    required this.data,
    required this.dataKeys,
    this.width = 300,
    this.height = 300,
    this.innerRadius = 0,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'pie-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final cx = width / 2;
    final cy = height / 2;
    final outerR = math.min(cx, cy) - 10;
    final innerR = innerRadius;

    // Sum all values across data rows for the first dataKey
    final key = dataKeys.first;
    final values = data.map((row) => (row[key] ?? 0).toDouble()).toList();
    final total = values.fold<double>(0, (a, b) => a + b);

    if (total == 0) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'pie-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final slices = <Component>[];
    var currentAngle = 0.0;

    for (var i = 0; i < values.length; i++) {
      final sweep = (values[i] / total) * 360;
      if (sweep == 0) {
        currentAngle += sweep;
        continue;
      }

      final endAngle = currentAngle + sweep;
      final colorIndex = (i % 5) + 1;

      if (sweep >= 359.99) {
        // Full circle
        final elements = <Component>[
          Component.element(tag: 'circle', attributes: {
            'cx': cx.toStringAsFixed(1),
            'cy': cy.toStringAsFixed(1),
            'r': outerR.toStringAsFixed(1),
            'fill': 'var(--color-chart-$colorIndex)',
          }),
        ];
        if (innerR > 0) {
          elements.add(Component.element(tag: 'circle', attributes: {
            'cx': cx.toStringAsFixed(1),
            'cy': cy.toStringAsFixed(1),
            'r': innerR.toStringAsFixed(1),
            'fill': 'var(--background)',
          }));
        }
        slices.addAll(elements);
      } else {
        final startRad = (currentAngle - 90) * math.pi / 180;
        final endRad = (endAngle - 90) * math.pi / 180;
        final largeArc = sweep > 180 ? 1 : 0;

        final ox1 = cx + outerR * math.cos(startRad);
        final oy1 = cy + outerR * math.sin(startRad);
        final ox2 = cx + outerR * math.cos(endRad);
        final oy2 = cy + outerR * math.sin(endRad);

        String d;
        if (innerR > 0) {
          final ix1 = cx + innerR * math.cos(startRad);
          final iy1 = cy + innerR * math.sin(startRad);
          final ix2 = cx + innerR * math.cos(endRad);
          final iy2 = cy + innerR * math.sin(endRad);
          d = 'M ${ox1.toStringAsFixed(2)} ${oy1.toStringAsFixed(2)} '
              'A $outerR $outerR 0 $largeArc 1 ${ox2.toStringAsFixed(2)} ${oy2.toStringAsFixed(2)} '
              'L ${ix2.toStringAsFixed(2)} ${iy2.toStringAsFixed(2)} '
              'A $innerR $innerR 0 $largeArc 0 ${ix1.toStringAsFixed(2)} ${iy1.toStringAsFixed(2)} Z';
        } else {
          d = 'M ${cx.toStringAsFixed(2)} ${cy.toStringAsFixed(2)} '
              'L ${ox1.toStringAsFixed(2)} ${oy1.toStringAsFixed(2)} '
              'A $outerR $outerR 0 $largeArc 1 ${ox2.toStringAsFixed(2)} ${oy2.toStringAsFixed(2)} Z';
        }

        slices.add(Component.element(tag: 'path', attributes: {
          'd': d,
          'fill': 'var(--color-chart-$colorIndex)',
        }));
      }

      currentAngle = endAngle;
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'pie-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: slices,
    );
  }
}

class ShadRadarChart extends StatelessComponent {
  final List<Map<String, dynamic>> data;
  final List<String> dataKeys;
  final String categoryKey;
  final double width;
  final double height;
  final int gridLevels;
  final String? className;

  const ShadRadarChart({
    required this.data,
    required this.dataKeys,
    this.categoryKey = 'category',
    this.width = 400,
    this.height = 400,
    this.gridLevels = 5,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'radar-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final cx = width / 2;
    final cy = height / 2;
    final radius = math.min(cx, cy) - 30;
    final n = data.length;
    final angleStep = 360.0 / n;

    // Find max value
    num maxVal = 0;
    for (final row in data) {
      for (final key in dataKeys) {
        final v = row[key];
        if (v is num && v > maxVal) maxVal = v;
      }
    }
    if (maxVal == 0) maxVal = 1;

    final elements = <Component>[];

    // Grid polygons
    for (var level = 1; level <= gridLevels; level++) {
      final r = radius * level / gridLevels;
      final pts = <String>[];
      for (var i = 0; i < n; i++) {
        final angle = (i * angleStep - 90) * math.pi / 180;
        final x = cx + r * math.cos(angle);
        final y = cy + r * math.sin(angle);
        pts.add('${x.toStringAsFixed(1)},${y.toStringAsFixed(1)}');
      }
      elements.add(Component.element(tag: 'polygon', attributes: {
        'points': pts.join(' '),
        'fill': 'none',
        'stroke': 'var(--border)',
        'stroke-width': '1',
        'opacity': '0.3',
      }));
    }

    // Axis lines
    for (var i = 0; i < n; i++) {
      final angle = (i * angleStep - 90) * math.pi / 180;
      final x = cx + radius * math.cos(angle);
      final y = cy + radius * math.sin(angle);
      elements.add(Component.element(tag: 'line', attributes: {
        'x1': cx.toStringAsFixed(1),
        'y1': cy.toStringAsFixed(1),
        'x2': x.toStringAsFixed(1),
        'y2': y.toStringAsFixed(1),
        'stroke': 'var(--border)',
        'stroke-width': '1',
        'opacity': '0.3',
      }));

      // Category labels
      final labelR = radius + 16;
      final lx = cx + labelR * math.cos(angle);
      final ly = cy + labelR * math.sin(angle);
      final label = data[i][categoryKey]?.toString() ?? '';
      elements.add(Component.element(tag: 'text', attributes: {
        'x': lx.toStringAsFixed(1),
        'y': ly.toStringAsFixed(1),
        'text-anchor': 'middle',
        'dominant-baseline': 'central',
        'fill': 'var(--muted-foreground)',
        'font-size': '11',
      }, children: [Component.text(label)]));
    }

    // Data polygons
    for (var ki = 0; ki < dataKeys.length; ki++) {
      final key = dataKeys[ki];
      final pts = <String>[];
      for (var i = 0; i < n; i++) {
        final val = (data[i][key] is num) ? (data[i][key] as num) : 0;
        final r = radius * val / maxVal;
        final angle = (i * angleStep - 90) * math.pi / 180;
        final x = cx + r * math.cos(angle);
        final y = cy + r * math.sin(angle);
        pts.add('${x.toStringAsFixed(1)},${y.toStringAsFixed(1)}');
      }
      elements.add(Component.element(tag: 'polygon', attributes: {
        'points': pts.join(' '),
        'fill': 'var(--color-$key)',
        'fill-opacity': '0.2',
        'stroke': 'var(--color-$key)',
        'stroke-width': '2',
      }));
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'radar-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: elements,
    );
  }
}

class ShadRadialChart extends StatelessComponent {
  final List<Map<String, num>> data;
  final List<String> dataKeys;
  final double width;
  final double height;
  final double maxValue;
  final String? className;

  const ShadRadialChart({
    required this.data,
    required this.dataKeys,
    this.width = 300,
    this.height = 300,
    this.maxValue = 100,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (data.isEmpty || dataKeys.isEmpty) {
      return Component.element(
        tag: 'svg',
        attributes: {
          'data-slot': 'radial-chart',
          'width': width.toString(),
          'height': height.toString(),
          'viewBox': '0 0 $width $height',
        },
        children: [],
      );
    }

    final cx = width / 2;
    final cy = height / 2;
    final maxR = math.min(cx, cy) - 20;
    final ringWidth = 12.0;
    final ringGap = 6.0;

    final elements = <Component>[];
    final row = data.first;

    for (var i = 0; i < dataKeys.length; i++) {
      final key = dataKeys[i];
      final val = (row[key] ?? 0).toDouble();
      final fraction = (val / maxValue).clamp(0.0, 1.0);
      final r = maxR - i * (ringWidth + ringGap);
      if (r <= 0) break;

      final circumference = 2 * math.pi * r;
      final dashLen = circumference * fraction;
      final colorIndex = (i % 5) + 1;

      // Background track
      elements.add(Component.element(tag: 'circle', attributes: {
        'cx': cx.toStringAsFixed(1),
        'cy': cy.toStringAsFixed(1),
        'r': r.toStringAsFixed(1),
        'fill': 'none',
        'stroke': 'var(--muted)',
        'stroke-width': ringWidth.toStringAsFixed(1),
        'opacity': '0.3',
      }));

      // Value arc
      elements.add(Component.element(tag: 'circle', attributes: {
        'cx': cx.toStringAsFixed(1),
        'cy': cy.toStringAsFixed(1),
        'r': r.toStringAsFixed(1),
        'fill': 'none',
        'stroke': 'var(--color-chart-$colorIndex)',
        'stroke-width': ringWidth.toStringAsFixed(1),
        'stroke-dasharray':
            '${dashLen.toStringAsFixed(1)} ${circumference.toStringAsFixed(1)}',
        'stroke-dashoffset': '0',
        'stroke-linecap': 'round',
        'transform': 'rotate(-90 $cx $cy)',
      }));
    }

    return Component.element(
      tag: 'svg',
      classes: cn([className]),
      attributes: {
        'data-slot': 'radial-chart',
        'width': '100%',
        'height': '100%',
        'viewBox': '0 0 $width $height',
        'preserveAspectRatio': 'xMidYMid meet',
      },
      children: elements,
    );
  }
}
