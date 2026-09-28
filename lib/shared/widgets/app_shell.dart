import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../providers.dart';
import 'app_widgets.dart';

class NavItem {
  const NavItem(this.rota, this.label, this.icone);

  final String rota;
  final String label;
  final IconData icone;
}

const List<NavItem> navItems = <NavItem>[
  NavItem('/dashboard', 'Dashboard', Icons.space_dashboard_outlined),
  NavItem('/demanda', 'Demanda', Icons.groups_outlined),
  NavItem('/receita', 'Receita', Icons.payments_outlined),
  NavItem('/creditos', 'Créditos', Icons.credit_card_outlined),
  NavItem('/frota', 'Frota', Icons.directions_bus_outlined),
  NavItem('/quilometragem', 'Quilometragem', Icons.route_outlined),
  NavItem('/documentos', 'Documentos', Icons.description_outlined),
  NavItem('/assistente', 'Assistente IA', Icons.smart_toy_outlined),
  NavItem('/relatorios', 'Relatórios', Icons.download_outlined),
];

/// Casca da aplicacao: sidebar da marca no desktop e Drawer no mobile.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child, required this.rotaAtual});

  final Widget child;
  final String rotaAtual;

  int get _indice {
    final int i = navItems.indexWhere((NavItem n) => rotaAtual.startsWith(n.rota));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool largo = MediaQuery.sizeOf(context).width >= 900;
    final String titulo = navItems[_indice].label;

    if (largo) {
      return Scaffold(
        body: Row(
          children: <Widget>[
            _Sidebar(indice: _indice),
            Expanded(
              child: Column(
                children: <Widget>[
                  _Header(titulo: titulo),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo, style: AppTextStyles.title),
        actions: const <Widget>[_BotaoSair(), SizedBox(width: AppSpacing.sm)],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.brandTop,
        child: _Sidebar(indice: _indice, dentroDoDrawer: true),
      ),
      body: child,
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.indice, this.dentroDoDrawer = false});

  final int indice;
  final bool dentroDoDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? usuario = ref.watch(sessaoProvider);

    final Widget conteudo = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: AppLogo(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            children: <Widget>[
              for (int i = 0; i < navItems.length; i++)
                _ItemNav(
                  item: navItems[i],
                  selecionado: i == indice,
                  onTap: () {
                    if (dentroDoDrawer) Navigator.of(context).pop();
                    context.go(navItems[i].rota);
                  },
                ),
            ],
          ),
        ),
        const Divider(color: Colors.white24),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white.withValues(alpha: 0.12),
                child: const Icon(Icons.person_outline,
                    size: 18, color: Colors.white),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  usuario ?? 'Modo demonstração',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ),
              const _BotaoSair(claro: true),
            ],
          ),
        ),
      ],
    );

    if (dentroDoDrawer) return FundoMarca(child: conteudo);

    return SizedBox(
      width: 252,
      child: FundoMarca(child: conteudo),
    );
  }
}

class _ItemNav extends StatelessWidget {
  const _ItemNav({
    required this.item,
    required this.selecionado,
    required this.onTap,
  });

  final NavItem item;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color cor =
        selecionado ? AppColors.accent : Colors.white.withValues(alpha: 0.72);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Material(
        color: selecionado ? Colors.white.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
            child: Row(
              children: <Widget>[
                Icon(item.icone, size: 20, color: cor),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          selecionado ? FontWeight.w600 : FontWeight.w400,
                      color: selecionado ? Colors.white : cor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(titulo, style: AppTextStyles.title)),
          const _BotaoSair(),
        ],
      ),
    );
  }
}

class _BotaoSair extends ConsumerWidget {
  const _BotaoSair({this.claro = false});

  final bool claro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Sair',
      icon: Icon(
        Icons.logout,
        size: 20,
        color: claro ? Colors.white70 : AppColors.textSecondary,
      ),
      onPressed: () {
        ref.read(sessaoProvider.notifier).sair();
        context.go('/login');
      },
    );
  }
}

/// Container padrao de conteudo: scroll + largura maxima + padding responsivo.
class PaginaConteudo extends StatelessWidget {
  const PaginaConteudo({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final double padding =
        MediaQuery.sizeOf(context).width < 700 ? AppSpacing.md : AppSpacing.lg;

    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (final Widget w in children) ...<Widget>[
                w,
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
