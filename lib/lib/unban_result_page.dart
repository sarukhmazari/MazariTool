import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnbanResultPage extends StatelessWidget {
  final String language;
  final String phone;

  const UnbanResultPage({
    super.key,
    required this.language,
    required this.phone,
  });

  // Generate 10 detailed reports without numbering
  List<String> generateReports() {
    if (language == 'English') {
      return [
        "Hello WhatsApp support, my account linked to $phone has been wrongly banned. Kindly assist in recovering it. I rely on this account for daily communication and request urgent help to restore access.",
        "Hi WhatsApp team, the account with number $phone is banned incorrectly. Please help me regain access. This ban is affecting my work and personal communication.",
        "Greetings, my WhatsApp account $phone is blocked unfairly. Requesting support to unban it as soon as possible. I have always followed WhatsApp policies and believe this was a mistake.",
        "Dear WhatsApp support, I cannot access my account $phone due to a ban. Kindly review and restore access. I appreciate your prompt assistance.",
        "Hello, my WhatsApp number $phone has been mistakenly banned. Please provide assistance to reactivate it. This account is very important for my contacts.",
        "WhatsApp support, my account $phone is disabled in error. I need help recovering it immediately. I have not violated any terms of service.",
        "Hi team, the number $phone associated with my account is banned incorrectly. Please rectify this issue quickly. I am unable to communicate with my contacts.",
        "Dear WhatsApp, my account $phone is blocked without reason. I would appreciate prompt support to unban it. Kindly check and help me restore my account.",
        "Hello, I am unable to use WhatsApp for $phone as my account is banned wrongly. Kindly help restore access. I am a regular user and this must be a mistake.",
        "WhatsApp support, please review the ban on my account $phone and assist in unlocking it. Thank you for your attention and support in resolving this issue.",
      ];
    } else if (language == 'Portuguese') {
      return [
        "Olá suporte do WhatsApp, minha conta vinculada ao número $phone foi bloqueada incorretamente. Por favor, ajudem-me a recuperá-la. Eu dependo desta conta para comunicação diária e preciso de ajuda urgente.",
        "Olá equipe WhatsApp, a conta com o número $phone foi banida por engano. Preciso de ajuda para recuperar o acesso. Esse bloqueio está afetando meu trabalho e comunicação pessoal.",
        "Saudações, minha conta $phone foi bloqueada injustamente. Solicito suporte para desbloqueá-la o quanto antes. Sempre segui as políticas do WhatsApp e acredito que houve um erro.",
        "Prezado suporte do WhatsApp, não consigo acessar minha conta $phone devido a um banimento. Por favor, revise e restaure o acesso. Agradeço sua assistência rápida.",
        "Olá, meu número $phone foi banido por engano. Solicito assistência para reativá-lo. Esta conta é muito importante para meus contatos.",
        "Suporte do WhatsApp, minha conta $phone foi desativada erroneamente. Preciso de ajuda para recuperá-la imediatamente. Não violei nenhum termo de serviço.",
        "Olá equipe, o número $phone associado à minha conta foi banido incorretamente. Por favor, corrijam este problema rapidamente. Estou impossibilitado de comunicar com meus contatos.",
        "Prezado WhatsApp, minha conta $phone foi bloqueada sem motivo. Agradeço suporte rápido para desbloqueá-la. Por favor, verifiquem e ajudem a restaurar minha conta.",
        "Olá, não consigo usar o WhatsApp para $phone, pois minha conta foi banida erroneamente. Por favor, ajudem a restaurar o acesso. Sou um usuário regular e deve ter sido um erro.",
        "Suporte do WhatsApp, revise o bloqueio da minha conta $phone e ajude a desbloqueá-la. Obrigado pela atenção e suporte na resolução deste problema.",
      ];
    } else {
      return ["No messages available for the selected language."];
    }
  }

  @override
  Widget build(BuildContext context) {
    final reports = generateReports();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text("Unban Reports"),
        backgroundColor: Colors.green.shade900,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green.shade900.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.greenAccent, width: 2),
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(24),
              // Make card height adaptive to text content
              constraints: const BoxConstraints(minHeight: 180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reports[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.greenAccent,
                        size: 32,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: reports[index]));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Message copied to clipboard!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
