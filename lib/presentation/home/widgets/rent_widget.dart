import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';

import '../../rent/controller/cars/cubit/cars_cubit.dart';
import '../controllers/icons/cubit/icons_cubit.dart';

class RentWidget extends StatelessWidget {
  const RentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IconsCubit, IconsState>(
      builder: (context, state) {
        final iconsCubit = context.read<IconsCubit>();

        return BlocProvider(
          create: (context) => CarsCubit(context.read<ChatsCubit>()),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.black,
                title: const Text(
                  "تحب تعرض اي ؟",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                centerTitle: true,
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final icon = iconsCubit.getIcon(index);
                    final iconName = iconsCubit.getIconName(index);

                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        left: 10,
                        bottom: 10,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    final carsCubit = context.read<CarsCubit>();
                                    return carsCubit.currentScreen(index);
                                  },
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween = Tween(
                                      begin: begin,
                                      end: end,
                                    ).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.green,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: icon,
                        ),
                        title: Text(
                          iconName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
