import 'package:flutter/material.dart';
import 'package:whatsapp_chatbot/whatsapp_chatbot.dart';



class WhatsappChatbotScreen extends StatefulWidget {
  const WhatsappChatbotScreen({super.key});

  @override
  State<WhatsappChatbotScreen> createState() => _WhatsappChatbotScreenState();
}

class _WhatsappChatbotScreenState extends State<WhatsappChatbotScreen> {
  final List<String> keywords = [];

  final config = Config(
    botDelay: 3,
    waitText: 'Bot Thinking...',
    defaultResponseMessage: "Sorry! I didn't catch that!\nPlease try again!",
    keywords: [
      'hello',
      'hi',
      'how are you',
    ],
    response: [
      'Hi\nHow can I assist you today?',
      'Hello!\nHow can I be of help?',
      'I am doing great!',
    ],
    greetings: "Hi there👋🏾\nHow can I help you?",
    headerText:'My Sons School',// 'Iksoft Technologies',
    subHeaderText: 'Online',
    buttonText: 'Start Chat',
    buttonColor: Color.fromARGB(255, 0, 34, 7),
    chatIcon: const Icon(Icons.person),
    headerColor: Color.fromARGB(255, 0, 34, 7),
    message: 'Hello! This is a direct WhatsApp message.',
    phoneNumber: '+201551885357',//'+233550138086',
    chatBackgroundColor: const Color.fromARGB(255, 238, 231, 223),
    onlineIndicator: const Color.fromARGB(255, 37, 211, 102),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            WhatsappChatBot(
              settings: config,
            )
          ],
        ));
  }
}