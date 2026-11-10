import 'package:flutter/material.dart';
import '../../models/academic_paper.dart';
import '../../viewmodels/papers_viewmodel.dart';

/// Tela 4: Envio de Perguntas aos Autores da Apresentação.
/// Otimizada: processamento imediato sem delays artificiais, tema verde escuro.
class SubmitQuestionView extends StatefulWidget {
  final AcademicPaper paper;
  final PapersViewModel viewModel;

  const SubmitQuestionView({
    super.key,
    required this.paper,
    required this.viewModel,
  });

  @override
  State<SubmitQuestionView> createState() => _SubmitQuestionViewState();
}

class _SubmitQuestionViewState extends State<SubmitQuestionView> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _participantController = TextEditingController(text: 'Participante do Congresso');

  @override
  void dispose() {
    _questionController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final questionText =
        '${_questionController.text.trim()} (por ${_participantController.text.trim()})';

    // Registro síncrono e imediato no ViewModel (sem timer artificial para economizar recursos)
    widget.viewModel.addQuestion(widget.paper.id, questionText);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pergunta enviada com sucesso para a sessão de debate!'),
        backgroundColor: Color(0xFF1B4332),
        duration: Duration(seconds: 3),
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Dúvida aos Autores', style: TextStyle(fontSize: 17)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card do Trabalho
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2EC),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: const Color(0xFFC3D8CC)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SESSÃO DO CONGRESSO',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF1B4332),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.paper.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F261C),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${widget.paper.presentationDate} às ${widget.paper.presentationTime} • ${widget.paper.room}',
                      style: const TextStyle(fontSize: 11.5, color: Color(0xFF52615B)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Identificação do Participante
              const Text(
                'Seu Nome / Identificação',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _participantController,
                style: const TextStyle(fontSize: 13.5),
                decoration: const InputDecoration(
                  hintText: 'Ex: João da Silva (Discente)',
                  prefixIcon: Icon(Icons.person_outline, size: 20, color: Color(0xFF1B4332)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFD3E0D8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFD3E0D8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFF1B4332), width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe seu nome ou identificação.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pergunta / Dúvida
              const Text(
                'Sua Pergunta ou Comentário Técnico',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _questionController,
                maxLines: 4,
                style: const TextStyle(fontSize: 13.5),
                decoration: const InputDecoration(
                  hintText:
                      'Ex: Gostaria de saber mais sobre a metodologia de validação utilizada no estudo...',
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFD3E0D8)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFD3E0D8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFF1B4332), width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, escreva a sua dúvida.';
                  }
                  if (value.trim().length < 8) {
                    return 'A pergunta deve ter pelo menos 8 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 22),

              // Botão de Envio Imediato
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text(
                    'Enviar Pergunta aos Autores',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
