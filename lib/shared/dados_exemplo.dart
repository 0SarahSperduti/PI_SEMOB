/// Dados minimos apenas para renderizar a interface do prototipo.
/// NAO representam dados reais da SEMOB e devem ser substituidos pela API
/// quando o backend existir.
library;

class PontoSerie {
  const PontoSerie(this.rotulo, this.valor);

  final String rotulo;
  final double valor;
}

class Veiculo {
  const Veiculo({
    required this.prefixo,
    required this.status,
    required this.kmDia,
  });

  final String prefixo;
  final String status; // Em operacao | Garagem | Manutencao
  final double kmDia;
}

class LinhaOnibus {
  const LinhaOnibus({
    required this.codigo,
    required this.nome,
    required this.empresa,
    required this.veiculos,
  });

  final String codigo;
  final String nome;
  final String empresa;
  final List<Veiculo> veiculos;
}

class DocumentoPdf {
  const DocumentoPdf({
    required this.arquivo,
    required this.remetente,
    required this.recebidoEm,
    required this.status,
  });

  final String arquivo;
  final String remetente;
  final String recebidoEm;
  final String status; // Recebido | Processado | Falha
}

class DadosExemplo {
  const DadosExemplo._();

  static const List<String> empresas = <String>[
    'Viação Central',
    'Expresso Norte',
    'Rodo Sul',
  ];

  static const List<LinhaOnibus> linhas = <LinhaOnibus>[
    LinhaOnibus(
      codigo: '101',
      nome: 'Centro / Terminal Norte',
      empresa: 'Viação Central',
      veiculos: <Veiculo>[
        Veiculo(prefixo: '1021', status: 'Em operação', kmDia: 182.4),
        Veiculo(prefixo: '1034', status: 'Garagem', kmDia: 0),
        Veiculo(prefixo: '1057', status: 'Manutenção', kmDia: 12.6),
      ],
    ),
    LinhaOnibus(
      codigo: '204',
      nome: 'Jardim Industrial / Centro',
      empresa: 'Expresso Norte',
      veiculos: <Veiculo>[
        Veiculo(prefixo: '2210', status: 'Em operação', kmDia: 204.1),
        Veiculo(prefixo: '2245', status: 'Em operação', kmDia: 197.8),
      ],
    ),
    LinhaOnibus(
      codigo: '318',
      nome: 'Terminal Sul / Universidade',
      empresa: 'Rodo Sul',
      veiculos: <Veiculo>[
        Veiculo(prefixo: '3301', status: 'Em operação', kmDia: 165.2),
        Veiculo(prefixo: '3318', status: 'Garagem', kmDia: 0),
      ],
    ),
  ];

  static const List<DocumentoPdf> documentos = <DocumentoPdf>[
    DocumentoPdf(
      arquivo: 'relatorio_catraca_01.pdf',
      remetente: 'operacao@viacaocentral.com',
      recebidoEm: '28/09 08:12',
      status: 'Processado',
    ),
    DocumentoPdf(
      arquivo: 'relatorio_catraca_02.pdf',
      remetente: 'dados@expressonorte.com',
      recebidoEm: '28/09 08:40',
      status: 'Recebido',
    ),
    DocumentoPdf(
      arquivo: 'fechamento_semanal.pdf',
      remetente: 'financeiro@rodosul.com',
      recebidoEm: '27/09 19:05',
      status: 'Falha',
    ),
  ];

  static const List<PontoSerie> passageirosDiario = <PontoSerie>[
    PontoSerie('Seg', 41200),
    PontoSerie('Ter', 43850),
    PontoSerie('Qua', 44100),
    PontoSerie('Qui', 42960),
    PontoSerie('Sex', 46700),
    PontoSerie('Sáb', 28400),
    PontoSerie('Dom', 15200),
  ];

  static const List<PontoSerie> passageirosSemanal = <PontoSerie>[
    PontoSerie('S1', 248000),
    PontoSerie('S2', 252400),
    PontoSerie('S3', 244900),
    PontoSerie('S4', 261300),
  ];

  static const List<PontoSerie> passageirosMensal = <PontoSerie>[
    PontoSerie('Mai', 985000),
    PontoSerie('Jun', 1012000),
    PontoSerie('Jul', 940500),
    PontoSerie('Ago', 1045800),
    PontoSerie('Set', 1006700),
  ];

  static const List<PontoSerie> receitaPorPeriodo = <PontoSerie>[
    PontoSerie('Seg', 186400),
    PontoSerie('Ter', 194200),
    PontoSerie('Qua', 199000),
    PontoSerie('Qui', 191500),
    PontoSerie('Sex', 210300),
    PontoSerie('Sáb', 128700),
    PontoSerie('Dom', 68900),
  ];

  static const List<PontoSerie> receitaPorEmpresa = <PontoSerie>[
    PontoSerie('Viação Central', 520400),
    PontoSerie('Expresso Norte', 398100),
    PontoSerie('Rodo Sul', 360500),
  ];

  static const List<PontoSerie> receitaPorLinha = <PontoSerie>[
    PontoSerie('101', 210800),
    PontoSerie('204', 184300),
    PontoSerie('318', 152900),
  ];

  static const List<PontoSerie> creditosVendidos = <PontoSerie>[
    PontoSerie('Mai', 412000),
    PontoSerie('Jun', 428500),
    PontoSerie('Jul', 401200),
    PontoSerie('Ago', 447800),
    PontoSerie('Set', 433100),
  ];

  static const List<PontoSerie> creditosUtilizados = <PontoSerie>[
    PontoSerie('Mai', 388400),
    PontoSerie('Jun', 401900),
    PontoSerie('Jul', 378600),
    PontoSerie('Ago', 419500),
    PontoSerie('Set', 405200),
  ];

  static const List<PontoSerie> kmDiaria = <PontoSerie>[
    PontoSerie('Seg', 12480),
    PontoSerie('Ter', 12610),
    PontoSerie('Qua', 12530),
    PontoSerie('Qui', 12440),
    PontoSerie('Sex', 12890),
    PontoSerie('Sáb', 8720),
    PontoSerie('Dom', 5140),
  ];

  static const List<PontoSerie> kmMensal = <PontoSerie>[
    PontoSerie('Mai', 342000),
    PontoSerie('Jun', 351500),
    PontoSerie('Jul', 338900),
    PontoSerie('Ago', 359400),
    PontoSerie('Set', 347200),
  ];

  static const List<String> sugestoesAssistente = <String>[
    'Qual foi a demanda de passageiros da linha 101 esta semana?',
    'Compare a receita de catraca entre as empresas no mês atual.',
    'Quais linhas tiveram queda de quilometragem nos últimos 15 dias?',
  ];
}
