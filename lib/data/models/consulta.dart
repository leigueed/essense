class Consulta {
  final int? id;
  final int usuarioId;
  final DateTime data;
  final String emocao;
  final String lugar;
  final String elemento;
  final String cor;
  final List<String> resultadoIds;

  Consulta({
    this.id,
    required this.usuarioId,
    required this.data,
    required this.emocao,
    required this.lugar,
    required this.elemento,
    required this.cor,
    required this.resultadoIds,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'usuario_id': usuarioId,
        'data': data.toIso8601String(),
        'emocao': emocao,
        'lugar': lugar,
        'elemento': elemento,
        'cor': cor,
        'resultado_json': resultadoIds.join(','),
      };

  factory Consulta.fromMap(Map<String, dynamic> map) => Consulta(
        id: map['id'],
        usuarioId: map['usuario_id'],
        data: DateTime.parse(map['data']),
        emocao: map['emocao'],
        lugar: map['lugar'],
        elemento: map['elemento'],
        cor: map['cor'],
        resultadoIds: (map['resultado_json'] as String).split(','),
      );
}
