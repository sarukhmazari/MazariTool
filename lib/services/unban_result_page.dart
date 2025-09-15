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
        "Subject: Urgent Request to Review Account Ban – Phone Number $phone\n\nDear WhatsApp Support Team,\n\nI am writing to formally appeal the recent ban on my account associated with the phone number $phone. I believe this action may have been taken in error. My account is essential for both personal and professional communication, and its suspension has caused significant disruption. I kindly request a thorough review of my case to determine the cause and reinstate my account. I am committed to following all WhatsApp policies and community guidelines. Thank you for your prompt attention to this matter.",
        "Subject: Appeal for Reinstatement of WhatsApp Account $phone\n\nDear WhatsApp Team,\n\nI am writing to request a review of the ban on my WhatsApp account linked to the number $phone. I have always used WhatsApp responsibly and in compliance with its terms of service. The sudden suspension of my account is a major concern, as it is my primary tool for daily communication with family, friends, and colleagues. I apologize if there was any unintentional violation on my part and assure you that I will be more cautious in the future. Please consider restoring my account. Thank you for your time and consideration.",
        "Subject: Account Ban Review Request - $phone\n\nTo the WhatsApp Review Team,\n\nMy WhatsApp account, with the number $phone, was recently banned, and I am writing to appeal this decision. I am a long-standing and committed user and believe that my account was unfairly flagged. I rely on WhatsApp for critical communication and have not engaged in any activities that would warrant a ban. I am happy to provide any additional information you may need to resolve this issue and would be grateful if you could restore my account at your earliest convenience.",
        "Subject: Formal Request to Unban Account – $phone\n\nDear WhatsApp Support,\n\nI am submitting a formal request for the unbanning of my WhatsApp account, $phone, which has been incorrectly disabled. This account is vital for my business and personal life, and I am confident that I have not violated any of WhatsApp's guidelines. I am willing to cooperate fully to resolve this matter. Please review my account activity and take the necessary steps to lift the ban. Your assistance is greatly appreciated.",
        "Subject: Account Suspension Appeal for Number $phone\n\nHello WhatsApp Support,\n\nI am writing to appeal the recent suspension of my account, $phone. I have been a dedicated user for a long time and am very surprised by this ban, as I believe I have always adhered to the rules. I use WhatsApp for legitimate purposes and am deeply concerned about losing access to my contacts and conversations. I would be grateful if you could investigate this matter and restore my account. Thank you for your attention to this appeal.",
        "Subject: Inquiry Regarding Account Ban – $phone\n\nDear WhatsApp Support,\n\nI am contacting you to inquire about the ban on my account, $phone. The ban has prevented me from communicating with my network, which is very problematic. I have reviewed the terms of service and am not aware of any specific violation. I urge you to re-examine my account and provide more details about the reason for the ban. I am eager to resolve this and regain access to my account. Thank you.",
        "Subject: Plea for Account Restoration - WhatsApp Number $phone\n\nTo the WhatsApp Team,\n\nI am writing with an urgent plea for the restoration of my account, $phone. The ban has been a significant setback for my daily activities. I have not knowingly violated any of WhatsApp's policies and believe this is a genuine mistake. My account is a critical communication link for my family and my work. I ask for your compassionate review of my case and hope for a quick resolution. Sincerely, a loyal user seeking help.",
        "Subject: Account Review Request - $phone\n\nDear WhatsApp Support,\n\nI am writing to respectfully ask for a review of the ban on my account, $phone. I believe my account was flagged by mistake, and I am very concerned about the loss of communication. I use WhatsApp for my daily business operations and personal interactions, and the ban has severely impacted my ability to connect with my clients and friends. I promise to be more vigilant about my account's usage in the future and would be very thankful if you could reinstate my account.",
        "Subject: Appeal Against Unjust Ban – WhatsApp Account $phone\n\nDear WhatsApp Moderation Team,\n\nI am writing to appeal what I consider to be an unjust ban on my account, $phone. I have been a compliant user of WhatsApp for years and have never engaged in any malicious or unauthorized activity. My account serves a legitimate purpose, and I am unable to understand the reason for this ban. I kindly request a thorough investigation into my account activity and its immediate reinstatement. Thank you for your time and efforts.",
        "Subject: Request to Unban Account $phone\n\nHello, WhatsApp Support,\n\nI am a user of WhatsApp and my account, with the number $phone, has been banned. I am writing to appeal this decision, as I am certain I have not breached any of your terms of service. This account is essential for keeping in touch with my contacts, and the ban has disconnected me from them. I am requesting your assistance in reviewing my account and restoring my access. Your help in this matter would be greatly appreciated. Thank you.",
      ];
    } else if (language == 'Portuguese') {
      return [
        "Assunto: Pedido Urgente de Revisão do Bloqueio da Conta – Número de Telefone $phone\n\nPrezada Equipe de Suporte do WhatsApp,\n\nEscrevo para apelar formalmente do recente bloqueio da minha conta associada ao número de telefone $phone. Acredito que esta ação possa ter sido tomada por engano. Minha conta é essencial para minha comunicação pessoal e profissional, e sua suspensão causou uma interrupção significativa. Solicito gentilmente uma revisão completa do meu caso para determinar a causa e reativar minha conta. Comprometo-me a seguir todas as políticas e diretrizes da comunidade do WhatsApp. Agradeço a sua pronta atenção a este assunto.",
        "Assunto: Apelo para a Restauração da Conta do WhatsApp $phone\n\nPrezada Equipe do WhatsApp,\n\nEscrevo para solicitar uma revisão do bloqueio da minha conta WhatsApp vinculada ao número $phone. Sempre usei o WhatsApp de forma responsável e em conformidade com seus termos de serviço. A suspensão repentina da minha conta é uma grande preocupação, pois é minha principal ferramenta para comunicação diária com familiares, amigos e colegas. Peço desculpas se houve alguma violação não intencional da minha parte e garanto que serei mais cauteloso no futuro. Por favor, considere restaurar minha conta. Obrigado pelo seu tempo e consideração.",
        "Assunto: Solicitação de Revisão de Bloqueio de Conta - $phone\n\nPara a Equipe de Revisão do WhatsApp,\n\nMinha conta WhatsApp, com o número $phone, foi recentemente bloqueada, e escrevo para apelar desta decisão. Sou um usuário de longa data e comprometido, e acredito que minha conta foi sinalizada injustamente. Dependo do WhatsApp para comunicações críticas e não me envolvi em nenhuma atividade que justificasse um bloqueio. Estou feliz em fornecer qualquer informação adicional que precisem para resolver este problema e ficaria muito grato se pudessem restaurar minha conta o mais breve possível.",
        "Assunto: Pedido Formal para Desbloquear Conta – $phone\n\nPrezado Suporte do WhatsApp,\n\nEstou enviando um pedido formal para o desbloqueio da minha conta WhatsApp, $phone, que foi incorretamente desativada. Esta conta é vital para minha vida profissional e pessoal, e estou confiante de que não violei nenhuma das diretrizes do WhatsApp. Estou disposto a cooperar totalmente para resolver este assunto. Por favor, revise a atividade da minha conta e tome as medidas necessárias para levantar o bloqueio. Sua assistência é muito apreciada.",
        "Assunto: Apelo de Suspensão de Conta para o Número $phone\n\nOlá Suporte do WhatsApp,\n\nEscrevo para apelar da recente suspensão da minha conta, $phone. Sou um usuário dedicado há muito tempo e estou muito surpreso com este bloqueio, pois acredito que sempre segui as regras. Uso o WhatsApp para fins legítimos e estou profundamente preocupado em perder o acesso aos meus contatos e conversas. Agradeceria se pudessem investigar este assunto e restaurar minha conta. Agradeço a sua atenção a este apelo.",
        "Assunto: Consulta sobre Bloqueio de Conta – $phone\n\nPrezado Suporte do WhatsApp,\n\nEstou entrando em contato para perguntar sobre o bloqueio da minha conta, $phone. O bloqueio me impediu de me comunicar com minha rede, o que é muito problemático. Revisei os termos de serviço e não tenho conhecimento de nenhuma violação específica. Peço que reexamine minha conta e forneça mais detalhes sobre o motivo do bloqueio. Estou ansioso para resolver isso e recuperar o acesso à minha conta. Obrigado.",
        "Assunto: Súplica pela Restauração da Conta - Número WhatsApp $phone\n\nPara a Equipe do WhatsApp,\n\nEscrevo com uma súplica urgente para a restauração da minha conta, $phone. O bloqueio tem sido um grande obstáculo para minhas atividades diárias. Não violei conscientemente nenhuma das políticas do WhatsApp e acredito que isso seja um erro genuíno. Minha conta é um elo de comunicação crítico para minha família e meu trabalho. Peço sua revisão compassiva do meu caso e espero uma rápida resolução. Atenciosamente, um usuário leal em busca de ajuda.",
        "Assunto: Pedido de Revisão de Conta - $phone\n\nPrezado Suporte do WhatsApp,\n\nEscrevo para pedir respeitosamente uma revisão do bloqueio da minha conta, $phone. Acredito que minha conta foi sinalizada por engano, e estou muito preocupado com a perda de comunicação. Uso o WhatsApp para minhas operações comerciais diárias e interações pessoais, e o bloqueio impactou severamente minha capacidade de me conectar com meus clientes e amigos. Prometo ser mais vigilante sobre o uso da minha conta no futuro e ficaria muito grato se pudessem reativá-la.",
        "Assunto: Apelo Contra Bloqueio Injusto – Conta WhatsApp $phone\n\nPrezada Equipe de Moderação do WhatsApp,\n\nEscrevo para apelar do que considero ser um bloqueio injusto na minha conta, $phone. Sou um usuário que cumpre as regras do WhatsApp há anos e nunca me envolvi em atividades maliciosas ou não autorizadas. Minha conta serve a um propósito legítimo e sou incapaz de entender o motivo deste bloqueio. Solicito gentilmente uma investigação completa da atividade da minha conta e sua imediata reativação. Obrigado pelo seu tempo e esforço.",
        "Assunto: Pedido para Desbloquear Conta $phone\n\nOlá, Suporte do WhatsApp,\n\nSou um usuário do WhatsApp e minha conta, com o número $phone, foi bloqueada. Escrevo para apelar desta decisão, pois tenho certeza de que não violei nenhum dos seus termos de serviço. Esta conta é essencial para manter contato com meus contatos, e o bloqueio me desconectou deles. Estou solicitando sua assistência para revisar minha conta e restaurar meu acesso. Sua ajuda neste assunto seria muito apreciada. Obrigado.",
      ];
    } else {
      return ["Nenhuma mensagem disponível para o idioma selecionado."];
    }
  }

  @override
  Widget build(BuildContext context) {
    final reports = generateReports();

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          "Unban Reports",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        elevation: 6,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shadowColor: Colors.greenAccent.withOpacity(0.5),
            color: Colors.black.withOpacity(0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(
                color: Colors.greenAccent.withOpacity(0.7),
                width: 1.6,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reports[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.greenAccent,
                          size: 28,
                        ),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: reports[index]),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Message copied to clipboard!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
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
