import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobi_ai/shared/providers.dart';

void main() {
  late ProviderContainer container;

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  group('filtroPeriodoProvider', () {
    test('inicia em "Hoje" e sem comparacao', () {
      final FiltroPeriodo filtro = container.read(filtroPeriodoProvider);
      expect(filtro.tipo, PeriodoTipo.hoje);
      expect(filtro.comparar, isFalse);
    });

    test('últimos 15 dias define um intervalo de 14 dias', () {
      container.read(filtroPeriodoProvider.notifier).selecionar(PeriodoTipo.ultimos15);
      final FiltroPeriodo filtro = container.read(filtroPeriodoProvider);
      expect(filtro.fim.difference(filtro.inicio).inDays, 14);
    });

    test('intervalo personalizado muda o tipo do filtro', () {
      final DateTimeRange intervalo = DateTimeRange(
        start: DateTime(2026, 1, 1),
        end: DateTime(2026, 1, 31),
      );
      container.read(filtroPeriodoProvider.notifier).definirIntervalo(intervalo);

      final FiltroPeriodo filtro = container.read(filtroPeriodoProvider);
      expect(filtro.tipo, PeriodoTipo.personalizado);
      expect(filtro.inicio, intervalo.start);
      expect(filtro.fim, intervalo.end);
    });

    test('alterna a comparacao entre períodos', () {
      container.read(filtroPeriodoProvider.notifier).alternarComparacao();
      expect(container.read(filtroPeriodoProvider).comparar, isTrue);
    });
  });

  group('filtroDemandaProvider', () {
    test('define e limpa a linha selecionada', () {
      final FiltroDemandaNotifier notifier =
          container.read(filtroDemandaProvider.notifier);

      notifier.setLinha('101');
      expect(container.read(filtroDemandaProvider).linha, '101');

      notifier.setLinha(null);
      expect(container.read(filtroDemandaProvider).linha, isNull);
    });

    test('alterna a exibicao dos finais de semana', () {
      container.read(filtroDemandaProvider.notifier).alternarFinaisDeSemana();
      expect(container.read(filtroDemandaProvider).ocultarFinaisDeSemana, isTrue);
    });
  });

  group('assistenteProvider', () {
    test('enviar mensagem gera resposta e renomeia a conversa', () {
      container.read(assistenteProvider.notifier).enviar('Qual a receita do mês?');

      final EstadoAssistente estado = container.read(assistenteProvider);
      expect(estado.atual.mensagens.length, 2);
      expect(estado.atual.mensagens.first.doUsuario, isTrue);
      expect(estado.atual.mensagens.last.doUsuario, isFalse);
      expect(estado.atual.titulo, 'Qual a receita do mês?');
    });

    test('mensagem vazia e ignorada', () {
      container.read(assistenteProvider.notifier).enviar('   ');
      expect(container.read(assistenteProvider).atual.mensagens, isEmpty);
    });

    test('nova conversa fica selecionada', () {
      container.read(assistenteProvider.notifier).novaConversa();
      final EstadoAssistente estado = container.read(assistenteProvider);
      expect(estado.conversas.length, 2);
      expect(estado.atual.mensagens, isEmpty);
    });
  });

  group('sessaoProvider', () {
    test('guarda e limpa o usuario', () {
      container.read(sessaoProvider.notifier).entrar('ana@semob.gov.br');
      expect(container.read(sessaoProvider), 'ana@semob.gov.br');

      container.read(sessaoProvider.notifier).sair();
      expect(container.read(sessaoProvider), isNull);
    });
  });
}
