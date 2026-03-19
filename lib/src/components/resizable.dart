import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import 'package:universal_web/web.dart' as web;

import '../utils/cn.dart';

enum ResizableDirection { horizontal, vertical }

class ShadResizablePanelGroup extends StatefulComponent {
  final ResizableDirection direction;
  final List<Component> children;
  final String? className;

  const ShadResizablePanelGroup({
    this.direction = ResizableDirection.horizontal,
    required this.children,
    this.className,
    super.key,
  });

  @override
  State<ShadResizablePanelGroup> createState() =>
      _ShadResizablePanelGroupState();
}

class _ShadResizablePanelGroupState extends State<ShadResizablePanelGroup> {
  late List<double> _panelSizes;
  bool _initialized = false;
  // Mutable counter box used by child panels during build to determine their index
  final List<int> _panelCounter = [0];
  // Mutable counter box used by child handles during build to determine their index
  final List<int> _handleCounter = [0];

  void _initializeSizes() {
    if (_initialized) return;
    _initialized = true;
    _panelSizes = [];
    for (final child in component.children) {
      if (child is ShadResizablePanel) {
        _panelSizes.add(child.defaultSize.toDouble());
      }
    }
  }

  void _onResize(int handleIndex, double delta) {
    final beforeIdx = handleIndex;
    final afterIdx = handleIndex + 1;
    if (beforeIdx >= _panelSizes.length || afterIdx >= _panelSizes.length) {
      return;
    }

    final beforeSize = _panelSizes[beforeIdx];
    final afterSize = _panelSizes[afterIdx];
    final total = beforeSize + afterSize;

    var newBefore = beforeSize + delta;
    var newAfter = afterSize - delta;

    const minSize = 5.0;
    if (newBefore < minSize) {
      newBefore = minSize;
      newAfter = total - minSize;
    }
    if (newAfter < minSize) {
      newAfter = minSize;
      newBefore = total - minSize;
    }

    setState(() {
      _panelSizes[beforeIdx] = newBefore;
      _panelSizes[afterIdx] = newAfter;
    });
  }

  @override
  Component build(BuildContext context) {
    _initializeSizes();
    // Reset counters before children build
    _panelCounter[0] = 0;
    _handleCounter[0] = 0;

    return _ShadResizableScope(
      direction: component.direction,
      panelSizes: _panelSizes,
      panelCounter: _panelCounter,
      handleCounter: _handleCounter,
      onResize: _onResize,
      child: div(
        component.children,
        classes: cn([
          'flex w-full',
          component.direction == ResizableDirection.vertical
              ? 'flex-col'
              : 'flex-row',
          component.className,
        ]),
        attributes: {
          'data-slot': 'resizable-panel-group',
          'data-direction': component.direction.name,
          'data-panel-group': '',
        },
      ),
    );
  }
}

class _ShadResizableScope extends InheritedComponent {
  final ResizableDirection direction;
  final List<double> panelSizes;
  final List<int> panelCounter;
  final List<int> handleCounter;
  final void Function(int handleIndex, double delta) onResize;

  const _ShadResizableScope({
    required this.direction,
    required this.panelSizes,
    required this.panelCounter,
    required this.handleCounter,
    required this.onResize,
    required super.child,
  });

  static _ShadResizableScope of(BuildContext context) {
    return context
        .dependOnInheritedComponentOfExactType<_ShadResizableScope>()!;
  }

  @override
  bool updateShouldNotify(covariant _ShadResizableScope oldComponent) {
    return true;
  }
}

class ShadResizablePanel extends StatelessComponent {
  final int defaultSize;
  final int? minSize;
  final int? maxSize;
  final List<Component> children;
  final String? className;

  const ShadResizablePanel({
    required this.defaultSize,
    this.minSize,
    this.maxSize,
    required this.children,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final scope = _ShadResizableScope.of(context);
    final idx = scope.panelCounter[0]++;
    final size = idx < scope.panelSizes.length
        ? scope.panelSizes[idx]
        : defaultSize.toDouble();

    return div(
      children,
      classes: cn(['overflow-hidden', className]),
      attributes: {
        'data-slot': 'resizable-panel',
        'data-panel': '',
        'style': 'flex: $size 1 0%; overflow: hidden',
        if (minSize != null) 'data-min-size': '$minSize',
        if (maxSize != null) 'data-max-size': '$maxSize',
      },
    );
  }
}

class ShadResizableHandle extends StatefulComponent {
  final bool withHandle;
  final String? className;

  const ShadResizableHandle({
    this.withHandle = false,
    this.className,
    super.key,
  });

  @override
  State<ShadResizableHandle> createState() => _ShadResizableHandleState();
}

class _ShadResizableHandleState extends State<ShadResizableHandle> {
  StreamSubscription<web.MouseEvent>? _moveSub;
  StreamSubscription<web.MouseEvent>? _upSub;

  void _onMouseDown(dynamic event) {
    final e = event as web.MouseEvent;
    e.preventDefault();

    final scope = _ShadResizableScope.of(context);
    final isHorizontal = scope.direction == ResizableDirection.horizontal;

    // Determine handle index
    final handleIdx = scope.handleCounter[0] - 1; // Already incremented during build

    // Get the panel group element to calculate relative delta
    final groupEl = web.document.querySelector('[data-panel-group]');
    if (groupEl == null) return;

    final groupRect = groupEl.getBoundingClientRect();
    final groupSize = isHorizontal ? groupRect.width : groupRect.height;

    double totalFlex = 0;
    for (final v in scope.panelSizes) {
      totalFlex += v;
    }

    var lastPos = isHorizontal ? e.clientX : e.clientY;

    _moveSub = web.EventStreamProvider<web.MouseEvent>('mousemove')
        .forElement(web.document.documentElement!)
        .listen((moveEvent) {
      final currentPos =
          isHorizontal ? moveEvent.clientX : moveEvent.clientY;
      final pixelDelta = (currentPos - lastPos).toDouble();
      lastPos = currentPos;

      if (pixelDelta.abs() > 0) {
        final flexDelta = (pixelDelta / groupSize) * totalFlex;
        scope.onResize(handleIdx, flexDelta);
      }
    });

    _upSub = web.EventStreamProvider<web.MouseEvent>('mouseup')
        .forElement(web.document.documentElement!)
        .listen((_) {
      _moveSub?.cancel();
      _upSub?.cancel();
      _moveSub = null;
      _upSub = null;
    });
  }

  @override
  void dispose() {
    _moveSub?.cancel();
    _upSub?.cancel();
    super.dispose();
  }

  @override
  Component build(BuildContext context) {
    final scope = _ShadResizableScope.of(context);
    // Increment handle counter during build
    scope.handleCounter[0]++;

    return div(
      [
        if (component.withHandle)
          div(
            [
              Component.element(
                tag: 'svg',
                attributes: {
                  'xmlns': 'http://www.w3.org/2000/svg',
                  'width': '10',
                  'height': '10',
                  'viewBox': '0 0 24 24',
                  'fill': 'none',
                  'stroke': 'currentColor',
                  'stroke-width': '2',
                  'stroke-linecap': 'round',
                  'stroke-linejoin': 'round',
                },
                children: [
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '9', 'cy': '12', 'r': '1'},
                  ),
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '9', 'cy': '5', 'r': '1'},
                  ),
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '9', 'cy': '19', 'r': '1'},
                  ),
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '15', 'cy': '12', 'r': '1'},
                  ),
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '15', 'cy': '5', 'r': '1'},
                  ),
                  Component.element(
                    tag: 'circle',
                    attributes: {'cx': '15', 'cy': '19', 'r': '1'},
                  ),
                ],
              ),
            ],
            classes:
                'z-10 flex size-4 items-center justify-center rounded-xs border bg-border',
          ),
      ],
      classes: cn([
        'relative flex w-px items-center justify-center bg-border cursor-col-resize select-none after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring focus-visible:ring-offset-1 data-[direction=vertical]:h-px data-[direction=vertical]:w-full data-[direction=vertical]:cursor-row-resize data-[direction=vertical]:after:left-0 data-[direction=vertical]:after:h-1 data-[direction=vertical]:after:w-full data-[direction=vertical]:after:-translate-y-1/2 data-[direction=vertical]:after:translate-x-0 [&[data-direction=vertical]>div]:rotate-90',
        component.className,
      ]),
      events: {
        'mousedown': _onMouseDown,
      },
      attributes: {
        'data-slot': 'resizable-handle',
        'data-panel-resize-handle': '',
        'data-direction': scope.direction.name,
        'role': 'separator',
        'tabindex': '0',
      },
    );
  }
}
