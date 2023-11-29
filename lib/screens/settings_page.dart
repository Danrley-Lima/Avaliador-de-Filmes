// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:und1_mobile/components/modal_confirmacao.dart';
import 'package:und1_mobile/configs/app_settings.dart';
import 'package:und1_mobile/models/usuario.dart';
import 'package:und1_mobile/styles.dart';
import 'package:und1_mobile/utils/app_routes.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cores = Theme.of(context).colorScheme;
    final FirebaseAuth auth = FirebaseAuth.instance;

    logOut() async {
      await Usuario.signOut();
      AppSettings.logout();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.LOGIN,
        ModalRoute.withName('/'),
      );
    }

    deletarConta() async {
      await Usuario.deleteAccount();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.LOGIN,
        ModalRoute.withName('/'),
      );
    }

    ButtonStyle buttonStyle = ButtonStyle(
      padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(12)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      backgroundColor: MaterialStatePropertyAll<Color>(
        cores.primaryContainer,
      ),
      foregroundColor: MaterialStatePropertyAll<Color>(
        cores.onPrimaryContainer,
      ),
      textStyle: const MaterialStatePropertyAll<TextStyle>(
        estiloSubTitulo3,
      ),
    );

    return Scaffold(
      backgroundColor: cores.secondary,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Configurações",
            style: estiloTitulo3,
          ),
        ),
        leading: GestureDetector(
          onTap: () => {Navigator.pop(context)},
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => {logOut()},
                  style: buttonStyle,
                  child: const Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      Text(
                        'Sair',
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ModalConfirmacao(
                          title: "Apagar Conta",
                          content: "Você realmente deseja apagar a sua conta?",
                          onConfirmed: (resposta) {
                            if (resposta) {
                              deletarConta();
                            }
                          },
                        );
                      },
                    )
                  },
                  style: buttonStyle,
                  child: const Row(
                    children: [
                      Icon(Icons.delete),
                      Text(
                        'Excluir conta',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
