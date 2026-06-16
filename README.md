# Essence

Descobridor de perfumes — app Flutter que sugere fragrâncias com base no seu momento (emoção, lugar, elemento, cor). Os dados ficam salvos localmente em SQLite e funcionam offline.

## Pré-requisitos

- Flutter instalado.
- Um dispositivo ou emulador configurado (Android, iOS, web, Linux, macOS ou Windows)

## Rodar o app

```bash
# 1. Clonar o repositório
git clone https://github.com/leigueed/essense.git

# 2. Entrar no diretório do projeto
cd essense

# 3. Baixar as dependências
flutter pub get

# 4. Rodar em modo debug
flutter run
```

## Estrutura
```bash
lib/
├── main.dart              — entrada do app
├── app.dart               — widget raiz
├── core/                  — tema, cores, constantes
├── data/
│   ├── database_helper.dart  — banco SQLite
│   ├── perfume_repository.dart
│   ├── perfumes_data.dart
│   └── models/               — usuario, consulta, perfume
├── features/
│   ├── auth/                 — cadastro / login
│   ├── consultas/            — histórico de consultas
└── shared/                   — widgets reutilizáveis
```
