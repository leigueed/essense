class Perfume {
  final String id;
  final String nome;
  final String marca;
  final String frasePoetica;
  final String notasTopo;
  final String notasCoracao;
  final String notasFundo;
  final String corHex;
  final Map<String, double> tags;

  const Perfume({
    required this.id,
    required this.nome,
    required this.marca,
    required this.frasePoetica,
    required this.notasTopo,
    required this.notasCoracao,
    required this.notasFundo,
    required this.corHex,
    required this.tags,
  });
}
