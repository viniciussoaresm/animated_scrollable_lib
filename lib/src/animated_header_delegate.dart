import 'package:flutter/material.dart';

/// Define a assinatura da função para construir o cabeçalho animado.
///
/// O [context] fornece o contexto de construção.
/// O [shrinkOffset] indica o quanto o cabeçalho foi reduzido.
/// O [percent] é um valor entre 0.0 e 1.0 que representa o estado da animação,
/// onde 1.0 é totalmente expandido e 0.0 é totalmente colapsado.
typedef HeaderBuilder =
    Widget Function(BuildContext context, double shrinkOffset, double percent);

/// Um delegado para [SliverPersistentHeader] que permite criar cabeçalhos
/// com animações customizadas baseadas no scroll.
class AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// A altura máxima que o cabeçalho pode atingir quando expandido.
  final double maxHeight;

  /// A altura mínima que o cabeçalho mantém quando totalmente colapsado.
  final double minHeight;

  /// A função responsável por construir o conteúdo do cabeçalho.
  final HeaderBuilder builder;

  /// Cria um [AnimatedHeaderDelegate].
  ///
  /// Requer [maxHeight], [minHeight] e um [builder].
  AnimatedHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.builder,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double range = maxHeight - minHeight;
    final double percent = range > 0
        ? (maxHeight - shrinkOffset - minHeight) / range
        : 0.0;

    final double clampedPercent = percent.clamp(0.0, 1.0);

    return ClipRect(
      child: OverflowBox(
        minHeight: minHeight,
        maxHeight: maxHeight,
        // Mudança crucial: topCenter faz o header parecer fixo no topo
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: maxHeight,
          width: double.infinity,
          child: builder(context, shrinkOffset, clampedPercent),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant AnimatedHeaderDelegate oldDelegate) => true;
}
