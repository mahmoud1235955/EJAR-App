import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/presentation/rent/enum/car_enum.dart';
import 'package:test_ejar/routes/routes.dart';
import 'package:test_ejar/sqflite/sqflite.dart';
import '../../../constants/extentions.dart';
import '../controller/cars/cubit/cars_cubit.dart';
import '../enum/contact_enum.dart';
import 'drop_down_widget.dart';
import 'text_field_widget.dart';
import 'wrap_widget.dart';

class AddCarWidget3 extends StatelessWidget {
  const AddCarWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text(
          'أجر سيارتك',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "اسم الاعلان",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  if (state is CarsFormState) {
                    return TextFieldWidget.form(
                      controller: state.adNameController,
                      hintText: "أضف اسم الاعلان",
                      labelText: "اسم الاعلان",
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              20.gap,
              const Text(
                "وصف الاعلان",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  if (state is CarsFormState) {
                    return TextFieldWidget.form(
                      controller: state.adDescController,
                      hintText: "ادخل وصف الاعلان",
                      labelText: "وصف الاعلان",
                      maxLines: 5,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              20.gap,
              const Text(
                "الموقع",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  if (state is CarsFormState) {
                    return DropDownWidget.form(
                      labelText: "الموقع",
                      hintText: "ادخل الموقع",
                      onChanged: (val) {},
                      items: [],
                      value: null,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              20.gap,
              const Text(
                "اسمك",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  if (state is CarsFormState) {
                    return TextFieldWidget.form(
                      controller: state.NameController!,
                      hintText: "ادخل اسمك",
                      labelText: "اسمك",
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              20.gap,
              const Text(
                "رقم الموبايل",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  if (state is CarsFormState) {
                    return TextFieldWidget.form(
                      controller: state.phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: "ادخل رقم الموبايل",
                      labelText: "رقم الموبايل",
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "+20",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            5.gap,
                            Container(
                              width: 2,
                              height: 24,
                              color: Colors.black,
                            ),
                            10.gap,
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              20.gap,
              const Text(
                "طريقة التواصل",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.gap,
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  final contact = ContactEnum.values;

                  if (state is CarsFormState) {
                    return AppWrapper.builder(
                      itemCount: contact.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChoiceChip(
                          label: Text(contact[index].label),
                          selected: state.selectedContact == contact[index],
                          onSelected: (bool selected) {
                            context.read<CarsCubit>().getContact(
                              contact[index],
                            );
                          },
                        );
                      },
                      itemseparatorBuilder: (BuildContext context, int index) {
                        return 10.gap;
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              30.gap,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  final state = context.read<CarsCubit>().state;
                  if (state is CarsFormState) {
                    if (state.adNameController.text.isEmpty ||
                        state.adDescController.text.isEmpty ||
                        state.NameController.text.isEmpty ||
                        state.phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "⚠️ من فضلك أكمل جميع البيانات المطلوبة",
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                      return;
                    }
                  }

                  context.read<AddProductCubit>().addProduct(
                    context.read<CarsCubit>().state as CarsFormState,
                    context.read<CarsCubit>().carBodyType.length - 1,
                  );

                  Navigator.pushReplacementNamed(context, Routes.home);
                },
                child: const Text(
                  "نشر الإعلان",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
