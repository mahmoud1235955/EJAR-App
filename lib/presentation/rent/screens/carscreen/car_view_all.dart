import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/chats/controllers/cubit/chats_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

import '../../../../constants/extentions.dart';
import '../../../home/models/car_model.dart';
import '../../controller/cars/cubit/cars_cubit.dart';
import '../../enum/contact_enum.dart';

class CarViewAll extends StatelessWidget {
  const CarViewAll({super.key});
  @override
  Widget build(BuildContext context) {
    final carList = ModalRoute.of(context)!.settings.arguments as CarModel;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<CarsCubit, CarsState>(
          builder: (context, state) {
            final carCubit = context.read<CarsCubit>();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(carList.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  10.gap,
                  Row(
                    children: [
                      Text(carList.rentSystem!),
                      10.gap,
                      Text(
                        "${carList.price!}ج.م  ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  20.gap,
                  Text(
                    carList.carName!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.indigo,
                    ),
                  ),
                  20.gap,
                  // Text(carList.location!),
                  // 10.gap,
                  Text(
                    "التفاصيل",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  DetailsColumn(
                    fuelType: carList.fuelType!,
                    name: "نوع الوقود",
                  ),
                  DetailsColumn(name: "نوع الهيكل", fuelType: carList.carBody!),
                  DetailsColumn(
                    name: "ناقل الحركه",
                    fuelType: carList.gearType!,
                  ),
                  DetailsColumn(
                    name: "نوع الايجار",
                    fuelType: carList.rentSystem!,
                  ),
                  DetailsColumn(
                    name: "نوع العربيه",
                    fuelType: carList.carBrand!,
                  ),
                  10.gap,
                  Divider(thickness: 2, color: Colors.green),
                  20.gap,
                  Text(
                    "الوصف",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  10.gap,
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2),
                    ),
                    child: Text(carList.description!, maxLines: 5),
                  ),
                  10.gap,
                  Divider(thickness: 2, color: Colors.green),
                  Text(
                    "المدرجة من قبل الوكالة",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  7.gap,
                  Text(carList.ownerName ?? "ASHOUR"),
                  Divider(thickness: 2, color: Colors.green),
                  10.gap,
                  // Text(
                  //   "الموقع",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  // ),
                  // Text(carList.location!),
                  // 10.gap,
                  Divider(thickness: 2, color: Colors.green),
                  10.gap,
                  Text(
                    "بيانات المؤجر",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  10.gap,
                  if (state is CarsFormState)
                    if (state.selectedContact == ContactEnum.both ||
                        state.selectedContact == ContactEnum.phone)
                      Text("رقم الهاتف:  ${carList.contactPhone}"),
                  if (state is CarsFormState)
                    if (carList.contactPhone != null ||
                        state.selectedContact == ContactEnum.ejarChat)
                      BlocBuilder<ChatsCubit, ChatsState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<ChatsCubit>().openChat(
                                carList.ownerId,
                              );
                              Navigator.of(context).pushNamed(
                                Routes.viewChats,
                                arguments: carList.ownerId,
                              );
                            },
                            child: Text("راسل المالك"),
                          );
                        },
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailsColumn extends StatelessWidget {
  const DetailsColumn({super.key, required this.name, required this.fuelType});

  final String name;
  final String fuelType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(color: Colors.greenAccent[200]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                fuelType,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
