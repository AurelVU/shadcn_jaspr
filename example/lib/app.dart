import 'package:jaspr/jaspr.dart';

import 'pages/showcase.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(
        title: 'shadcn_jaspr — Component Showcase',
        children: [
          Component.element(tag: 'link', attributes: {
            'href': 'styles.css',
            'rel': 'stylesheet',
          }),
        ],
      ),
      ShowcasePage(),
    ]);
  }
}
