import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

import '../utils/cn.dart';

enum ResizableDirection { horizontal, vertical }

class ShadResizablePanelGroup extends StatelessComponent {
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
  Component build(BuildContext context) {
    return div(
      children,
      classes: cn([
        'flex w-full',
        direction == ResizableDirection.vertical ? 'flex-col' : 'flex-row',
        className,
      ]),
      attributes: {
        'data-slot': 'resizable-panel-group',
        'data-direction': direction.name,
        'data-panel-group': '',
      },
    );
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
    return div(
      children,
      classes: cn(['overflow-hidden', className]),
      attributes: {
        'data-slot': 'resizable-panel',
        'data-panel': '',
        'style': 'flex: $defaultSize 1 0%; overflow: hidden',
        if (minSize != null) 'data-min-size': '$minSize',
        if (maxSize != null) 'data-max-size': '$maxSize',
      },
    );
  }
}

class ShadResizableHandle extends StatelessComponent {
  final bool withHandle;
  final String? className;

  const ShadResizableHandle({
    this.withHandle = false,
    this.className,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        if (withHandle)
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
        'relative flex w-px items-center justify-center bg-border after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring focus-visible:ring-offset-1 data-[direction=vertical]:h-px data-[direction=vertical]:w-full data-[direction=vertical]:after:left-0 data-[direction=vertical]:after:h-1 data-[direction=vertical]:after:w-full data-[direction=vertical]:after:-translate-y-1/2 data-[direction=vertical]:after:translate-x-0 [&[data-direction=vertical]>div]:rotate-90',
        className,
      ]),
      attributes: {
        'data-slot': 'resizable-handle',
        'data-panel-resize-handle': '',
        'role': 'separator',
        'tabindex': '0',
      },
    );
  }
}
