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

  // Generate 10 detailed reports with stronger reasoning
  List<String> generateReports() {
    if (language == 'English') {
      return [
        "Dear WhatsApp Support,\n\nI am writing to report that my WhatsApp account linked to $phone has been banned mistakenly. I use this account daily for personal and professional communication, including coordinating with family, colleagues, and clients. I assure you that I strictly follow WhatsApp’s Terms of Service and community guidelines. I kindly request a thorough review of my case and prompt restoration of my account.\n\nThank you for your assistance.",

        "Hello WhatsApp Team,\n\nMy account registered with $phone was banned unexpectedly. This number is my primary means of communication with business partners and personal contacts. I strongly believe this suspension is an error as I have never engaged in spam, bulk messaging, or violations of WhatsApp policies. Please re-check the decision and reinstate my account at the earliest convenience.",

        "Respected WhatsApp Support,\n\nI am unable to access my account $phone as it was banned recently. I depend on this account for essential conversations with my workplace, study groups, and family. I request your urgent support to resolve this matter. I assure you that I have always used WhatsApp responsibly and in accordance with the rules. Please consider restoring my account after re-evaluation.",

        "Hi WhatsApp Support,\n\nThe account linked to $phone has been blocked unfairly. This account plays a crucial role in my daily activities such as coordinating professional tasks, staying in touch with relatives, and managing important services. I kindly appeal to you to lift the ban as it is disrupting my work and personal life. I guarantee compliance with all future policies and seek your quick action.",

        "Dear Support Team,\n\nMy WhatsApp number $phone has been mistakenly banned. I am confident that I have not engaged in any behavior that violates WhatsApp standards. This sudden suspension has caused serious inconvenience for both my business communication and personal commitments. I humbly request a detailed review of this matter and the reinstatement of my account at the earliest.",

        "Greetings WhatsApp,\n\nI am reaching out regarding the ban on my account $phone. This has affected my ability to communicate with clients and family members during critical times. I assure you that I have always respected your policies, and I strongly believe this was a technical error. Please resolve this issue quickly and help me regain access to my account.",

        "Hello WhatsApp,\n\nThe WhatsApp number $phone is currently banned, which I believe is incorrect. My account is used exclusively for genuine and private communication, not for spam or misuse. This ban has created serious obstacles in my work and studies. I kindly request a review of my account’s status and quick restoration so I can resume normal usage.",

        "Respected WhatsApp Team,\n\nI am appealing for the unban of my account $phone. I heavily depend on this number for customer support, educational discussions, and personal matters. Losing access has greatly disturbed my daily routine. I am confident there must have been a mistake in the system that flagged my account. Please reinstate my number after reviewing my case carefully.",

        "Dear WhatsApp,\n\nMy account $phone has been suspended unfairly. I assure you that I have always maintained compliance with WhatsApp’s rules and never engaged in abusive or spam-related activity. This suspension has created significant communication gaps in my professional responsibilities. I kindly request urgent help to restore access to my account.",

        "Hi WhatsApp Support,\n\nThis is a humble request to unban my account $phone which was recently restricted. This number is extremely important to me as it connects me with colleagues, clients, and close relatives. I sincerely apologize if there was any unintentional activity flagged as suspicious. I pledge to adhere strictly to all your policies in the future. Please resolve this matter and grant me access again.",
      ];
    } else if (language == 'Portuguese') {
      return [
        "Prezado Suporte do WhatsApp,\n\nMinha conta vinculada ao número $phone foi suspensa incorretamente. Utilizo esta conta diariamente para comunicação pessoal e profissional, incluindo contato com clientes, familiares e colegas. Sempre respeitei os Termos de Serviço do WhatsApp. Solicito uma revisão completa e a restauração da minha conta.\n\nAgradeço pela atenção.",

        "Olá equipe do WhatsApp,\n\nMinha conta $phone foi banida inesperadamente. Esse número é essencial para meu trabalho e comunicação pessoal. Tenho certeza de que essa suspensão foi um erro, já que nunca pratiquei spam ou violações. Solicito que revisem a decisão e reativem minha conta o quanto antes.",

        "Respeitada equipe WhatsApp,\n\nNão consigo acessar minha conta $phone devido a um bloqueio inesperado. Dependo deste número para assuntos de trabalho, estudo e família. Garanto que sempre respeitei as regras da plataforma. Por favor, revisem meu caso e restaurem minha conta com urgência.",

        "Olá Suporte WhatsApp,\n\nA conta $phone foi bloqueada de forma injusta. Esse número é essencial para meu cotidiano, tanto em atividades profissionais quanto pessoais. Peço gentilmente que revisem essa decisão, pois a suspensão está impactando meu trabalho e vida pessoal. Comprometo-me a cumprir todas as regras.",

        "Prezada equipe de suporte,\n\nMeu número $phone foi banido erroneamente. Tenho convicção de que não cometi nenhuma violação das políticas. Esta suspensão inesperada está me causando grandes prejuízos. Solicito uma revisão detalhada do meu caso e a reativação imediata da conta.",

        "Saudações WhatsApp,\n\nEscrevo para relatar o bloqueio da minha conta $phone. Esse número é usado diariamente para comunicação com clientes, familiares e parceiros de estudo. Estou certo de que houve um erro técnico. Por favor, revisem e restaurem minha conta o mais rápido possível.",

        "Olá WhatsApp,\n\nO número $phone foi banido, o que acredito ter sido incorreto. Essa conta é usada apenas para comunicações legítimas e privadas. O bloqueio trouxe sérios problemas para meu trabalho e vida acadêmica. Solicito que revisem a situação e restaurem meu acesso.",

        "Equipe do WhatsApp,\n\nSolicito o desbloqueio da conta $phone. Dependo fortemente desse número para atividades profissionais, educacionais e pessoais. Estou confiante de que houve um erro do sistema. Peço que revisem cuidadosamente e restaurem minha conta.",

        "Prezada equipe,\n\nMinha conta $phone foi suspensa de forma injusta. Sempre cumpri todas as políticas do WhatsApp e nunca utilizei o serviço para fins inadequados. Esse bloqueio trouxe sérios problemas à minha rotina profissional. Solicito ajuda urgente para recuperar o acesso.",

        "Olá WhatsApp,\n\nVenho solicitar a revisão do bloqueio da minha conta $phone. Esse número é fundamental para manter contato com colegas, clientes e familiares. Caso alguma atividade tenha sido considerada suspeita, comprometo-me a evitar tais situações no futuro. Solicito a reativação imediata.",
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
            color: Colors.green.shade900.withAlpha((255 * 0.3).round()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.greenAccent, width: 2),
            ),
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(24),
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
