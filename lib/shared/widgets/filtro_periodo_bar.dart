import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../providers.dart';
import 'app_widgets.dart';

/// Barra de filtro de periodo compartilhada pelas telas analiticas.
class FiltroPeriodoBar extends ConsumerWidget {
  const FiltroPeriodoBar({super.key, this.mostrarComparacao = true});

  final bool mostrarComparacao;

  Future<void> _escolherIntervalo(BuildContext context, WidgetRef ref) async {
    final FiltroPeriodo atual = ref.read(filtroPeriodoProvider);
    final DateTimeRange? intervalo = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: atual.inicio, end: atual.fim),
      helpText: 'Selecione o período',
      saveText: 'Aplicar',
    );
    if (intervalo != null) {
      ref.read(filtroPeriodoProvider.notifier).definirIntervalo(intervalo);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FiltroPeriodo filtro = ref.watch(filtroPeriodoProvider);

    return AppCard(
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          for (final PeriodoTipo tipo in PeriodoTipo.values)
            if (tipo != PeriodoTipo.personalizado)
              ChoiceChip(
                label: Text(tipo.label),
                selected: filtro.tipo == tipo,
                onSelected: (_) =>
                    ref.read(filtroPeriodoProvider.notifier).selecionar(tipo),
              ),
          ActionChip(
            avatar: const Icon(Icons.calendar_month_outlined, size: 18),
            label: Text(
              filtro.tipo == PeriodoTipo.personalizado
                  ? filtro.descricao
                  : 'Período personalizado',
            ),
            backgroundColor: filtro.tipo == PeriodoTipo.personalizado
                ? AppColors.primary.withValues(alpha: 0.12)
                : null,
            onPressed: () => _escolherIntervalo(context, ref),
          ),
          if (mostrarComparacao)
            FilterChip(
              avatar: const Icon(Icons.compare_arrows, size: 18),
              label: const Text('Comparar períodos'),
              selected: filtro.comparar,
              onSelected: (_) =>
                  ref.read(filtroPeriodoProvider.notifier).alternarComparacao(),
            ),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Text(filtro.descricao, style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }
}
