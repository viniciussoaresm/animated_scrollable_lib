# Animated Scrollable Scaffold 🚀

Uma biblioteca Flutter para criar headers animados incríveis que reagem ao scroll de forma simples e performática.

## ✨ Características
* 🛠 **Header Dinâmico**: Controle total com `percent` e `shrinkOffset`.
* 🧠 **Inteligente**: Detecta automaticamente se deve colapsar para 0 ou para a altura da Toolbar.
* 📦 **Simples**: Sem necessidade de gerenciar Slivers manualmente.
* 📱 **Fixo ou Scrollable**: Escolha o que fica fixo no rodapé com o `bottomWidget`.

## 🚀 Como usar

```dart
AnimatedScrollableScanfold(
  expandedHeight: 250.0,
  appBar: AppBar(title: Text("Meu App")), // Opcional
  header: (context, shrinkOffset, percent) {
    return Center(
      child: Opacity(
        opacity: percent,
        child: Icon(Icons.star, size: 50 * percent),
      ),
    );
  },
  items: [
    ListTile(title: Text("Item 1")),
    ListTile(title: Text("Item 2")),
  ],
  bottomWidget: ElevatedButton(
    onPressed: () {},
    child: Text("Ação Fixa"),
  ),
)