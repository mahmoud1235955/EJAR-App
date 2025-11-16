import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/constants/extentions.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

class CarsscreenView extends StatelessWidget {
  const CarsscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // final carUpdate = ModalRoute.of(context)!.settings.arguments as String; // لو مش محتاجينها ممكن نحذف
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.greenAccent,
        title: const Text(
          "أختار سيارتك",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          if (state is AddProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddProductSuccess) {
            // فلترة العربيات اللي مش بتاع الـ current user
            final cars = state.product
                .where(
                  (car) =>
                      car.ownerId != FirebaseAuth.instance.currentUser!.uid,
                )
                .toList();

            if (cars.isEmpty) {
              return const Center(child: Text("لا توجد سيارات متاحة"));
            }

            return ListView.separated(
              itemCount: cars.length,
              separatorBuilder: (_, __) => 10.gap,
              itemBuilder: (context, index) {
                final car = cars[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Routes.carViewAll,
                      arguments: car,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  car.imageUrl ??
                                      "https://via.placeholder.com/150",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          10.gap,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${car.price.toString()} ج.م",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                5.gap,
                                Text(
                                  car.carName ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                5.gap,
                                Text(
                                  car.carBrand ?? "",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
