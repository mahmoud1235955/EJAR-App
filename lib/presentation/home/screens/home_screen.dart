import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ejar/presentation/home/models/car_model.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/addProduct/cubit/add_product_cubit.dart';
import 'package:test_ejar/presentation/rent/controller/cubit/database_cubit.dart';
import 'package:test_ejar/routes/routes.dart';

import '../../rent/controller/cars/cubit/cars_cubit.dart';
import '../controllers/home_cubit.dart';
import '../widgets/card_widget.dart';
import '../widgets/rent_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://i.pinimg.com/1200x/4b/80/71/4b8071a85c849dee587eb5088f577a08.jpg",
      "https://i.pinimg.com/1200x/4b/80/71/4b8071a85c849dee587eb5088f577a08.jpg",
      "https://i.pinimg.com/1200x/4b/80/71/4b8071a85c849dee587eb5088f577a08.jpg",
    ];

    String selectedCity = "القاهرة"; // default

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..sliderLength = images.length
            ..startAutoSlide(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text(
            "EJAR",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==================== المدن و الاشعارات
              BlocBuilder<CarsCubit, CarsState>(
                builder: (context, state) {
                  final cubit = context.watch<CarsCubit>();
                  return Row(
                    children: [
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButton<String>(
                              value: selectedCity,
                              isExpanded: true,
                              items: cubit.egyptCities
                                  .map(
                                    (city) => DropdownMenuItem<String>(
                                      value: city,
                                      child: Text(city),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => selectedCity = value);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                    ],
                  );
                },
              ),
              //==================== البحث
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "هتأجر ايه؟",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              //==================== الفئات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: const [
                    Text(
                      "استكشف الفئات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "مشاهدة الكل",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) {
                    return BlocBuilder<CarsCubit, CarsState>(
                      builder: (context, state) {
                        final cubit = context.watch<CarsCubit>();
                        if (state is CarsFormState) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      cubit.screens[index],
                                      arguments: cubit.categoriesList[index],
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent.withOpacity(
                                        0.4,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      cubit.iconsList[index],
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                cubit.categoriesList[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: 4,
                ),
              ),
              const SizedBox(height: 10),
              //==================== السلايدر
              SizedBox(
                height: 180,
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return PageView.builder(
                      itemCount: images.length,
                      controller: context.read<HomeCubit>().pageController,
                      onPageChanged: (index) {
                        context.read<HomeCubit>().changePage(index);
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, size: 50),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              //==================== كروت المنتجات
              BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, state) {
                  if (state is AddProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AddProductSuccess) {
                    // فلترة العربيات اللي مش بتاعة المستخدم الحالي
                    final cars = state.product
                        .where(
                          (car) =>
                              car.ownerId !=
                              FirebaseAuth.instance.currentUser!.uid,
                        )
                        .toList();

                    if (cars.isEmpty) {
                      return const Center(child: Text("لا توجد منتجات بعد"));
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cars.length > 4 ? 4 : cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.carViewAll,
                                arguments: car,
                              );
                            },
                            child: CardWidget(
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              img:
                                  car.imageUrl ??
                                  "https://via.placeholder.com/150",
                              ProductName: car.carBrand ?? "اسم المنتج",
                              ProductPrice: car.price?.toString() ?? "0",
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is AddProductError) {
                    return Center(child: Text("خطأ: ${state.error}"));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              ElevatedButton(onPressed: (){
              
              }, child:Text("data"))
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.green,
              currentIndex: context.read<HomeCubit>().bottomNavIndex,
              onTap: (index) {
                context.read<HomeCubit>().bottomNav(
                  index,
                  context.read<HomeCubit>().bottomNavRoutes,
                  context,
                );

                if (index == 2) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const RentWidget(),
                  );
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ad_units),
                  label: "Ads",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sell_rounded, size: 30),
                  label: "Rent",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
