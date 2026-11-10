# Congresso Acadêmico 2026

Aplicativo mobile em Flutter para um congresso acadêmico, desenvolvido como **atividade da aula de Desenvolvimento Mobile**.

## Funcionalidades

- **Programação**: palestras, workshops e minicursos, com detalhes e locais
- **Palestrantes**: lista, detalhes e cadastro de palestrantes
- **Inscrições**: formulário de inscrição e confirmação
- **Trabalhos**: trabalhos acadêmicos submetidos, salvos e envio de perguntas
- **Minha Agenda**: atividades e favoritos do participante

Os dados são simulados (mock), sem backend. O projeto segue o padrão **MVVM** (`models`, `viewmodels`, `views`, `widgets`).

## Instalação

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3.13 ou superior)
- Android Studio ou VS Code com a extensão Flutter
- Um emulador Android/iOS ou um dispositivo físico conectado

Verifique se o ambiente está pronto:

```bash
flutter doctor
```

### Passos

1. Clone o repositório:

   ```bash
   git clone https://github.com/guimaraesfe1/ProjetinLais.git
   cd ProjetinLais
   ```

2. Instale as dependências:

   ```bash
   flutter pub get
   ```

3. Execute o aplicativo:

   ```bash
   flutter run
   ```

## Estrutura

```
lib/
├── data/         # Dados mockados
├── models/       # Modelos de dados
├── theme/        # Tema e cores do app
├── viewmodels/   # Lógica de estado (ChangeNotifier)
├── views/        # Telas
├── widgets/      # Componentes reutilizáveis
└── main.dart     # Ponto de entrada
```
