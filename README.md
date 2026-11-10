# Congresso Acadêmico 2026

Aplicativo mobile em Flutter para um congresso acadêmico, desenvolvido como **atividade da aula de Desenvolvimento Mobile inspirado no Congresso Estudantil de Pesquisa e Pós-graduação do UNIMAM (CEPP)**.

## Funcionalidades

- **Programação**: palestras, workshops e minicursos, com detalhes e locais
- **Palestrantes**: lista, detalhes e cadastro de palestrantes
- **Inscrições**: formulário de inscrição e confirmação
- **Trabalhos**: trabalhos acadêmicos submetidos, salvos e envio de perguntas
- **Minha Agenda**: atividades e favoritos do participante

Os dados são simulados (mock), sem backend. O projeto segue o padrão **MVVM** (`models`, `viewmodels`, `views`, `widgets`).

## Instalação

O aplicativo é compilado **para Android**. Você pode executá-lo em um emulador ou em um celular Android real.

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart 3.13 ou superior)
- [Android Studio](https://developer.android.com/studio) com o **Android SDK**, **Android SDK Platform-Tools** e **Android SDK Command-line Tools** instalados (pelo *SDK Manager*)
- VS Code com a extensão Flutter (opcional, se preferir não usar o Android Studio como editor)

Aceite as licenças do Android SDK e verifique se o ambiente está pronto:

```bash
flutter doctor --android-licenses
flutter doctor
```

O item **Android toolchain** deve aparecer marcado como OK.

### 1. Baixar o projeto

```bash
git clone https://github.com/guimaraesfe1/ProjetinLais.git
cd ProjetinLais
flutter pub get
```

### 2. Escolher onde executar

#### Opção A: Emulador Android

1. Abra o Android Studio e vá em **More Actions → Virtual Device Manager** (ou **Tools → Device Manager** com um projeto aberto).
2. Clique em **Create Virtual Device**, escolha um aparelho (ex.: Pixel) e uma imagem de sistema recente (baixe-a se necessário).
3. Inicie o emulador pelo Device Manager, ou pelo terminal:

   ```bash
   flutter emulators                      # lista os emuladores disponíveis
   flutter emulators --launch <id_do_emulador>
   ```

> No Linux, ative a aceleração por hardware (KVM) para o emulador ter um desempenho aceitável.

#### Opção B: Celular Android real

1. No celular, abra **Configurações → Sobre o telefone** e toque 7 vezes em **Número da versão** para ativar as **Opções do desenvolvedor**.
2. Em **Configurações → Sistema → Opções do desenvolvedor**, ative a **Depuração USB**.
3. Conecte o celular ao computador por um cabo USB (que transmita dados) e, no aviso que aparecer no celular, toque em **Permitir** a depuração.
4. Confirme que o aparelho foi reconhecido:

   ```bash
   adb devices
   ```

   O aparelho deve aparecer com o status `device`. Se aparecer `unauthorized`, desbloqueie o celular e aceite o aviso de depuração.

> **Linux:** se o aparelho não aparecer, pode ser necessário configurar as regras `udev` e adicionar seu usuário ao grupo `plugdev` (ou equivalente da sua distribuição).
>
> **Sem cabo (Android 11+):** também é possível usar a **Depuração por Wi-Fi**, pareando com `adb pair <ip>:<porta>` e depois `adb connect <ip>:<porta>`.

### 3. Executar o aplicativo

Com o emulador aberto ou o celular conectado, liste os dispositivos e execute:

```bash
flutter devices
flutter run
```

Se houver mais de um dispositivo conectado, especifique qual usar:

```bash
flutter run -d <id_do_dispositivo>
```

Durante a execução, pressione `r` para *hot reload*, `R` para *hot restart* e `q` para encerrar.

### 4. Gerar o APK (opcional)

Para instalar o app sem precisar do computador conectado:

```bash
flutter build apk --release
```

O arquivo é gerado em `build/app/outputs/flutter-apk/app-release.apk`. Para instalá-lo:

- **Celular conectado/emulador aberto:** `flutter install` (ou `adb install build/app/outputs/flutter-apk/app-release.apk`)
- **Celular sem cabo:** copie o `.apk` para o aparelho, abra o arquivo e permita a instalação de **fontes desconhecidas** quando solicitado.

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
