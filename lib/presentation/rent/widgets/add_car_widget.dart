import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/sqflite/sqflite.dart';

import '../../../constants/extentions.dart';
import '../controller/cars/cubit/cars_cubit.dart';
import '../enum/car_enum.dart';
import 'add_car_widget2.dart';
import 'drop_down_widget.dart';
import 'text_field_widget.dart';

class AddCarWidget extends StatelessWidget {
  const AddCarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CarsCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CarsCubit, CarsState>(
            builder: (context, state) {
              if (state is! CarsFormState) {
                return const Center(child: CircularProgressIndicator());
              }
              final formState = state;
              final hasImage = formState.imgLinkController.text.isNotEmpty;

              return Form(
                key: cubit.globalKey, // ربط الـ Form بالـ Cubit
                child: Column(
                  children: [
                    10.gap,
                    const Text(
                      "ادخل البيانات الاساسيه ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    10.gap,
                    const Text(
                      "القسم",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    5.gap,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "عربيات وقطع غيار",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: const Align(
                          alignment: Alignment.center,
                          child: Text("عربيات للايجار"),
                        ),
                        trailing: const CircleAvatar(
                          child: Icon(Icons.car_rental, color: Colors.black),
                        ),
                        tileColor: Colors.green[300],
                      ),
                    ),

                    /// صورة السيارة
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: hasImage
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        formState.imgLinkController.text,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[300],
                            ),
                            child: !hasImage
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.camera_alt,
                                        size: 50,
                                        color: Colors.black54,
                                      ),
                                      10.gap,
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller: formState
                                                          .imgLinkController,
                                                      decoration: const InputDecoration(
                                                        labelText:
                                                            "رابط صورة السياره",
                                                        hintText:
                                                            "ادخل رابط صورة السيارة",
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "من فضلك أدخل رابط الصورة";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    10.gap,
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.black,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        "اضف الصوره",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          "اضافه صوره",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                          if (hasImage)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    formState.imgLinkController.clear();
                                    cubit.emit(
                                      formState.copyWith(
                                        imgLinkController:
                                            formState.imgLinkController,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    10.gap,

                    /// Dropdown ماركات العربيات
                    DropDownWidget.form(
                      items: formState.carsList,
                      onChanged: (value) {
                        cubit.selectCarBrand(value.toString());
                      },
                      value: formState.selectedBrand,
                      hintText: "اختار",
                      labelText: "الماركه",
                    ),

                    20.gap,

                    /// نسخة العربية
                    TextFormField(
                      controller: formState.versionCarController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "نسخة",
                        hintText: "ادخل نسخة السياره",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك أدخل نسخة السيارة";
                        }
                        return null;
                      },
                    ),

                    10.gap,

                    /// CarEnum options
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: CarEnum.values.map((e) {
                        final isSelected = formState.selectedState == e;
                        return GestureDetector(
                          onTap: () => cubit.setSelectedState(e),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isSelected
                                  ? Colors.blueAccent
                                  : Colors.grey[300],
                            ),
                            child: Text(
                              e.arabicStatus,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    10.gap,

                    /// حقل الكيلومترات لو العربية مستعملة
                    if (formState.selectedState == CarEnum.NotNew)
                      TextFormField(
                        controller: formState.kiloMeterController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          labelText: "كيلومترات",
                          hintText: "ادخل الكيلومترات ",
                        ),
                        validator: (value) {
                          if (formState.selectedState == CarEnum.NotNew) {
                            if (value == null || value.isEmpty) {
                              return "من فضلك أدخل عدد الكيلومترات";
                            }
                          }
                          return null;
                        },
                      ),

                    10.gap,

                    /// السنة
                    TextFormField(
                      controller: formState.yearController,
                      decoration: const InputDecoration(
                        labelText: "السنة",
                        hintText: "ادخل السنه",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "من فضلك أدخل سنة الصنع";
                        }
                        return null;
                      },
                    ),

                    10.gap,

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (cubit.globalKey.currentState!.validate()) {
                          // ✅ لو البيانات صح → انتقل للصفحة التالية
                          final state = context.read<CarsCubit>().state;
                          if (state is CarsFormState) {
                            if (state.imgLinkController.text.isEmpty ||
                                state.selectedBrand.isEmpty ||
                                state.versionCarController.text.isEmpty ||
                                state.yearController.text.isEmpty) {
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
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                    return const AddCarWidget2();
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
                        } else {
                          // ❌ بيانات ناقصة → التحذيرات هتظهر أوتوماتيك تحت الحقول
                        }
                      },
                      child: const Text(
                        "التالي",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
