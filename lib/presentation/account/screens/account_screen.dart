import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.home);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Account"),
      ),
      body: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          if (state is AddProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddProductSuccess) {
            final car = state.product
                .where(
                  (car) =>
                      car.ownerId == FirebaseAuth.instance.currentUser!.uid,
                )
                .toList();
            if (car.isEmpty) {
              return const Center(child: Text("لا توجد منتجات بعد"));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      context.read<ChatsCubit>().getChats();
                      Navigator.pushNamed(
                        context,
                        Routes.chats,
                        arguments: context.read<ChatsCubit>(),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tileColor: Colors.green,
                    title: const Text(
                      "Messages",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.message, color: Colors.white),
                  ),
                  10.gap,

                  Expanded(
                    child: ListView.separated(
                      itemCount: car.length,
                      separatorBuilder: (_, __) => 10.gap,
                      itemBuilder: (context, index) {
                        final car = state.product[index];
                        return Dismissible(
                          key: Key(car.id.toString()),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.green,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              // حذف
                            } else if (direction ==
                                DismissDirection.endToStart) {
                              // تعديل
                            }
                          },
                          child: ListTile(
                            onTap: () {
                              context.read<ChatsCubit>().getChats();
                              Navigator.pushNamed(
                                context,
                                Routes.carViewAll,
                                arguments: context.read<ChatsCubit>()
                                  ..getChats(),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Image.network(
                                car.imageUrl!,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(car.carName),
                            subtitle: Text("${car.price} ج.م"),
                            trailing: Text(car.carBrand),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("لا توجد بيانات"));
          }
        },
      ),
    );
  }
}
