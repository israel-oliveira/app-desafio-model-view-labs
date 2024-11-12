import 'package:asyncstate/asyncstate.dart';
import 'package:desafio_modelviewlabs/src/core/helpers/messages.dart';
import 'package:desafio_modelviewlabs/src/pages/home/home_controller.dart';
import 'package:desafio_modelviewlabs/src/repositories/random/http_random_repository.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixix {
  HomeController controller =
      HomeController(randomRepository: HttpRandomRepository());

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("principal"),
            Form(
              child: Column(
                children: [
                  Watch((_) {
                    return TextField(
                      controller: TextEditingController(text: controller.password().toString()),
                    );
                  }),
                  const TextField()
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await controller.getRandomPassword().asyncLoader();
      }),
    );
  }
}
