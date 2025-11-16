import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/rent/enum/car_enum.dart';
import 'package:test_ejar/sqflite/sqflite.dart';

import '../../../constants/extentions.dart';
import '../controller/cars/cubit/cars_cubit.dart';
import '../enum/gear_enum.dart';
import '../enum/rent_system_enum.dart';
import '../enum/rent_type_enum.dart';
import 'add_car_widget3.dart';
import 'drop_down_widget.dart';
import 'text_field_widget.dart';
import 'wrap_widget.dart';

class AddCarWidget2 extends StatelessWidget {
  const AddCarWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final carsCubit = context.read<CarsCubit>();
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
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "ناقل الحركة",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    return AppWrapper.builder(
                      itemseparatorBuilder: (context, index) => 10.gap,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        final gearOptions = [
                          GearEnum.automatic,
                          GearEnum.manual,
                        ];
                        return ChoiceChip(
                          selectedColor: Colors.greenAccent,
                          backgroundColor: Colors.transparent,
                          label: Text(gearOptions[index]),
                          selected:
                              state is CarsFormState &&
                              state.selectedGear == gearOptions[index],
                          onSelected: (bool selected) {
                            if (selected) {
                              carsCubit.gearState(gearOptions[index]);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
                20.gap,
                Text(
                  "نظام الايجار",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    final carsCubit = context.read<CarsCubit>();
                    return AppWrapper.builder(
                      itemseparatorBuilder: (context, index) => 10.gap,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        final rentSystem = [
                          RentSystemEnum.bydriver,
                          RentSystemEnum.withoutdriver,
                          RentSystemEnum.both,
                        ];
                        return ChoiceChip(
                          selectedColor: Colors.greenAccent,
                          backgroundColor: Colors.transparent,
                          label: Text(rentSystem[index]),
                          selected:
                              state is CarsFormState &&
                              state.selectedRentSystem == rentSystem[index],
                          onSelected: (bool selected) {
                            if (selected) {
                              carsCubit.rentSystem(rentSystem[index]);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
                20.gap,
                Text(
                  "نوع الايجار",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    return AppWrapper.builder(
                      itemseparatorBuilder: (context, index) => 10.gap,
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        final rentType = [
                          RentTypeEnum.byhour,
                          RentTypeEnum.byday,
                          RentTypeEnum.bymonth,
                          RentTypeEnum.byyear,
                          RentTypeEnum.byweek,
                          RentTypeEnum.bytrip,
                          RentTypeEnum.bykm,
                          RentTypeEnum.byfuel,
                          RentTypeEnum.all,
                        ];
                        return ChoiceChip(
                          padding: const EdgeInsets.all(8),
                          selectedColor: Colors.greenAccent,
                          backgroundColor: Colors.transparent,
                          label: Text(rentType[index]),
                          selected:
                              state is CarsFormState &&
                              state.selcteedTypeRent == rentType[index],
                          onSelected: (bool selected) {
                            if (selected) {
                              carsCubit.updateTypeRent(rentType[index]);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
                20.gap,
                const Text(
                  "رسوم الايجار",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    if (state is CarsFormState) {
                      return TextFieldWidget.form(
                        controller: state.Moneycontroller,
                        keyboardType: TextInputType.number,
                        hintText: "أضف رسوم الايجار",
                        labelText: "رسوم الايجار",
                        suffixIcon: Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 2,
                                height: 24,
                                color: Colors.black,
                              ),
                              5.gap,
                              const Text("ج.م"),
                              5.gap,
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    if (state is CarsFormState) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: [
                            Checkbox(
                              value: state.checkBoxValue,
                              onChanged: (val) {
                                carsCubit.checkBoxChanged(val);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              activeColor: Colors.greenAccent,
                              checkColor: Colors.white,
                            ),
                            const Expanded(
                              child: Text(
                                "قابل للنقاش",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                20.gap,
                Text(
                  "نوع الهيكل",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    if (state is CarsFormState) {
                      return DropDownWidget.form(
                        hintText: "اختر نوع الهيكل",
                        labelText: "نوع الهيكل",
                        onChanged: (value) {
                          if (value != null) {
                            carsCubit.updateCarBody(value.toString());
                          }
                        },
                        items: state.carBodyType,
                        value: state.selectedCarBody,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                20.gap,
                Text(
                  "نوع الوقود",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                10.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    final carsCubit = context.read<CarsCubit>();
                    return DropDownWidget.form(
                      labelText: "نوع الوقود",
                      hintText: "اختر نوع الوقود",
                      onChanged: (value) {
                        if (value != null) {
                          carsCubit.updateFuelType(value.toString());
                        }
                      },
                      items: state is CarsFormState ? state.fuelType : [],
                      value: state is CarsFormState ? state.fuelValue : null,
                    );
                  },
                ),
                20.gap,
                BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (state is CarsFormState) {
                          // التحقق من المدخلات
                          if (state.selectedGear == null ||
                              state.selectedRentSystem == null ||
                              state.selcteedTypeRent == null ||
                              state.Moneycontroller.text.isEmpty ||
                              state.selectedCarBody == null ||
                              state.fuelValue == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "من فضلك أكمل جميع البيانات أولاً",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                        }

                        // لو البيانات صح نروح للصفحة التالية
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                                  return BlocProvider.value(
                                    value: context.read<CarsCubit>(),
                                    child: const AddCarWidget3(),
                                  );
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

                                  final tween = Tween(
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
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "التالي",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
