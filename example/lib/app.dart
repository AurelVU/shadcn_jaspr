import 'package:jaspr/jaspr.dart';

import 'pages/showcase.dart';

class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Document.head(
      title: 'shadcn_jaspr — Component Showcase',
      children: [
        DomComponent(tag: 'link', attributes: {
          'href': 'styles.css',
          'rel': 'stylesheet',
        }),
      ],
    );
    yield ShowcasePage();
  }
}
