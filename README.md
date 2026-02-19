# Animated Scrollable Scaffold

Uma solução completa para criar **headers animados** e **efeitos de scroll** profissionais no Flutter sem a complexidade de lidar com Slivers manualmente.

## O que faz este pacote?
Este pacote resolve o problema de criar cabeçalhos que precisam diminuir de tamanho, mudar de cor ou desaparecer conforme o usuário rola a lista, mantendo um desempenho de 60fps.

### Principais Funcionalidades:
* **Header Reativo:** Use o `percent` (0.0 a 1.0) para animar qualquer widget no topo.
* **Altura Inteligente:** Detecta automaticamente se deve colapsar para o tamanho de uma AppBar.
* **Header Fixo (Sticky):** O cabeçalho nunca foge da tela, ele apenas se adapta.
* **Sem Erros de Layout:** Proteção nativa contra `Infinite Height` e `Overflow`.

## Instalação
Adicione ao seu `pubspec.yaml`:
```yaml
dependencies:
  animated_scrollable: ^1.0.0