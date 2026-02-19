import 'package:flutter/material.dart';
import 'package:animated_scrollable/animated_scrollable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated Scrollable Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
        appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollableScanfold(
      expandedHeight: 200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scanfold com Animação no Header',
          style: TextStyle(color: Colors.white),
        ),
      ),
      header: (context, offset, percent) {
        return Container(
          color: Colors.blueGrey,
          child: percent > 0.5
              ? Column(
                  mainAxisAlignment: percent > 0.5
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    if (percent > 0.5)
                      const Icon(
                        Icons.arrow_drop_down_circle,
                        size: 36,
                        color: Colors.white,
                      ),

                    const Text(
                      "Header",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        );
      },
      items: List.generate(
        20,
        (i) => ListTile(
          title: Text("Registro numero $i"),
          subtitle: Text('Exemplo de uso'),
        ),
      ),
      bottomWidget: Container(
        color: Colors.blueGrey,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Footer",
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
