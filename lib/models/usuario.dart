import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:und1_mobile/configs/app_settings.dart';
import 'package:und1_mobile/mocks/mock_filme.dart';

import '../mocks/mock_serie.dart';

class Usuario {
  String email;
  String senha;

  static String? uid;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Usuario({required this.email, required this.senha});

  static signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    uid = null;
  }

  static deleteAccount() async {
    final db = FirebaseFirestore.instance;

    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser?.delete();
    }

    // await db.collection("users").doc(Usuario.uid).delete().then(
    //   (doc) => print("Document deleted"),
    // );
    uid = null;
  }

  Future<String> salvarUsuario() async {
    if (uid == null) {
      return await _cadastrarUsuario();
    } else {
      //TODO _atualizarUsuario();
      return 'Não foi possível atualizar o usuário';
    }
  }

  Future<String> _cadastrarUsuario() async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((result) {
        List<dynamic> producoesIniciais = [];
        producoesIniciais.addAll(FILMES);
        producoesIniciais.addAll(SERIES);
        producoesIniciais.shuffle();
        uid = result.user?.uid;
        _db.collection('users').doc(uid).set({
          "email": email,
          "naoAvaliados": producoesIniciais.map((p) => p.id),
          "naoCurtidos": [],
          "curtidos": []
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        return 'Esse email já foi cadastrado.';
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Não foi possível cadastrar usuário.';
    }

    return '';
  }

  static Future<Usuario?> login(String usuario, String senha) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usuario,
      password: senha,
    );
    User? user = userCredential.user;

    if (user != null) {
      User firebaseUser = FirebaseAuth.instance.currentUser!;
      String userEmail = firebaseUser.email ?? '';
      String userId = firebaseUser.uid;

      Usuario usuario = Usuario(email: userEmail, senha: senha);
      Usuario.uid = userId;
      // Salvar o usuário logado.
      AppSettings.save(user.email!);
      return usuario;
    } else {
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      debugPrint('Erro ao excluir o usuário: $e');
    }
  }

  Future<String> atualizarEmailESenha(
    String novoEmail,
    String novaSenha,
  ) async {
    User? user = FirebaseAuth.instance.currentUser!;

    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: senha,
      );

      user.reauthenticateWithCredential(credential).then(
        (value) async {
          await user.updateEmail(novoEmail);
          await user.updatePassword(novaSenha);
          email = novoEmail;
          senha = novaSenha;
        },
      );
      return "Email e senha atualizados com sucesso";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else {
        return 'Erro ao atualizar email/senha: ${e.message}';
      }
    } catch (e) {
      return 'Erro ao atualizar email/senha: $e';
    }
  }

  static Future<bool> atualizarListas(Map<String, List<dynamic>> listas) async {
    if (uid != null) {
      var db = FirebaseFirestore.instance;
      final usuarioRef = db.collection('users').doc(uid);
      usuarioRef.update(
        {
          "naoAvaliados": listas['naoAvaliados']?.map((e) => e.id),
          "curtidos": listas['curtidos']?.map((e) => e.id),
          "naoCurtidos": listas['naoCurtidos']?.map((e) => e.id)
        },
      );

      return true;
    }
    return false;
  }

  static Future<Map<String, List<dynamic>>> carregarListas() async {
    var db = FirebaseFirestore.instance;

    if (uid != null) {
      final userData = db.collection("users").doc(Usuario.uid);
      Map<String, dynamic>? data;
      await userData.get().then(
        (DocumentSnapshot doc) {
          data = doc.data() as Map<String, dynamic>;
        },
      );
      List<dynamic> producoes = [];
      producoes.addAll(SERIES);
      producoes.addAll(FILMES);
      var producoesNaoAvaliadas = data?['naoAvaliados'];
      var producoesNaoCurtidas = data?['naoCurtidos'];
      var producoesCurtidas = data?['curtidos'];
      return {
        'naoAvaliados': producoes
            .where((element) => producoesNaoAvaliadas.contains(element.id))
            .toList(),
        'naoCurtidos': producoes
            .where((element) => producoesNaoCurtidas.contains(element.id))
            .toList(),
        'curtidos': producoes
            .where((element) => producoesCurtidas.contains(element.id))
            .toList(),
      };
    }
    return {
      'naoAvaliados': [],
      'naoCurtidos': [],
      'curtidas': [],
    };
  }

  static Future<String> emailDoUsuario(String id) async {
    var db = FirebaseFirestore.instance;
    Map<String, dynamic>? data;
    var userData = await db.collection('users').doc(id).get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
      },
    );
    return data?['email'];
  }
}
