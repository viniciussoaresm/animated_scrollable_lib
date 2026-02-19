import 'package:flutter/material.dart';
import 'animated_header_delegate.dart';

/// Um widget que fornece uma estrutura de página (Scaffold) com um cabeçalho
/// animado que reage ao scroll.
///
/// O [AnimatedScrollableScanfold] combina um [CustomScrollView] com um
/// [SliverPersistentHeader] para criar efeitos de expansão e contração
/// conforme o usuário desliza a tela.
class AnimatedScrollableScanfold extends StatelessWidget {
  /// Uma barra de ferramentas opcional para exibir no topo do Scaffold.
  final PreferredSizeWidget? appBar;

  /// A função que constrói o conteúdo do cabeçalho animado.
  /// Recebe o progresso da animação e o deslocamento do scroll.
  final HeaderBuilder header;

  /// A lista de widgets que compõem o corpo rolável da página.
  final List<Widget> items;

  /// Um widget opcional para ser exibido fixo na parte inferior da tela,
  /// fora da área de scroll.
  final Widget? bottomWidget;

  /// A altura do cabeçalho quando está totalmente expandido.
  /// O padrão é 200.0.
  final double expandedHeight;

  /// A altura do cabeçalho quando está totalmente contraído.
  /// Se nulo, será calculado com base na presença do [appBar].
  final double? collapsedHeight;

  /// A decoração visual (cor, gradiente, bordas) do container principal.
  final BoxDecoration? decoration;

  /// O espaçamento interno ao redor da lista de itens.
  final EdgeInsetsGeometry? padding;

  /// Altura final calculada para o estado contraído do cabeçalho.
  final double _finalCollapsedHeight;

  /// Cria um [AnimatedScrollableScanfold].
  ///
  /// Os parâmetros [header] e [items] são obrigatórios.
  const AnimatedScrollableScanfold({
    super.key,
    this.appBar,
    required this.header,
    required this.items,
    this.bottomWidget,
    this.expandedHeight = 200.0,
    this.collapsedHeight,
    this.decoration,
    this.padding = const EdgeInsets.all(0),
  }) : _finalCollapsedHeight =
           collapsedHeight ?? (appBar != null ? 0.0 : kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Scaffold(
            appBar: appBar,
            body: Container(
              decoration: decoration,
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      slivers: [
                        SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: AnimatedHeaderDelegate(
                            maxHeight: expandedHeight,
                            minHeight: _finalCollapsedHeight,
                            builder: header,
                          ),
                        ),
                        SliverPadding(
                          padding: padding ?? EdgeInsets.zero,
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(items),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 120)),
                      ],
                    ),
                  ),
                  if (bottomWidget != null)
                    SafeArea(top: false, child: bottomWidget!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
