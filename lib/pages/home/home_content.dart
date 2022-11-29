import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:drink_it/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
            // appBar: AppBar(
            //   title: const Text('Hello Jhon'),
            // ),
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.blue[500],
              child: Row(
                children: [
                  RotatedBox(
                    quarterTurns: 135,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text('Discovery'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 220,
                      color: Colors.blue[400],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotatedBox(
                        quarterTurns: 135,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          child: const Text('Ingredients'),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 135,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          child: const Text('Category'),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 135,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          child: const Text('Alcoholic'),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.blue[300],
                          height: 100,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.blue[200],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
            // bottomNavigationBar: BottomNavigationBar(items: const []),
            );
      });
}
