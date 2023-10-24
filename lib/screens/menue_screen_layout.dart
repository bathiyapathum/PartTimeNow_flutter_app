import 'package:flutter/material.dart';
import 'package:parttimenow_flutter/resources/auth_method.dart';
import 'package:parttimenow_flutter/screens/login_screen.dart';
import 'package:parttimenow_flutter/utils/colors.dart';

class MenueScreen extends StatelessWidget {
  const MenueScreen({super.key});

  void signOut(context) async {
    await AuthMethod().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Menu',
          style: TextStyle(
            color: signInBtn,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: navActivaeColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 223, 223, 223),
        ),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            // body: Row(
            children: [
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 7,
                ),
                // elevation:20,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // padding: const EdgeInsets.only(left: 30, right: 20, top: 20),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 7, top: 10, bottom: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: navActivaeColor,
                          radius: 42,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1694284028434-2872aa51337b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0Nnx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                            // fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Perara Dilshan Dinal',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const Text(
                              '@23284',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            // const SizedBox(
                            //   height: 2,
                            // ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(110, 30)),
                                elevation: MaterialStateProperty.all(12.0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  signInBtn,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12.0,
                                    ), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              /////////////////////////////////////////////////////////

              // Container(
              //   //////////////////////
              //   child: Container(
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 15,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 44),
                          Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,

                            margin: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 0,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 5, right: 5, top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                // overlayColor: MaterialStateProperty.all<Color>(
                                //   Colors.white
                                // ),

                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(300, 50)),
                                elevation: MaterialStateProperty.all(12.0),

                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),

                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Row(children: [
                                Icon(Icons.star_border),
                                SizedBox(width: 50),
                                Text('Saved'),
                                SizedBox(width: 120),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ]),
                              // child: const Text('hay'),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,

                            margin: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 0,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 5, right: 5, top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                // overlayColor: MaterialStateProperty.all<Color>(
                                //   Colors.white
                                // ),

                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(300, 50)),
                                elevation: MaterialStateProperty.all(12.0),

                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),

                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Row(children: [
                                Icon(Icons.category_outlined),
                                SizedBox(width: 50),
                                Text('Categories'),
                                SizedBox(width: 90),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ]),
                              // child: const Text('hay'),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,

                            margin: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 0,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 5, right: 5, top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                // overlayColor: MaterialStateProperty.all<Color>(
                                //   Colors.white
                                // ),

                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(300, 50)),
                                elevation: MaterialStateProperty.all(12.0),

                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),

                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Row(children: [
                                Icon(Icons.location_on),
                                SizedBox(width: 50),
                                Text('Location'),
                                SizedBox(width: 107),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ]),
                              // child: const Text('hay'),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,

                            margin: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 0,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 5, right: 5, top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                // overlayColor: MaterialStateProperty.all<Color>(
                                //   Colors.white
                                // ),

                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(300, 50)),
                                elevation: MaterialStateProperty.all(12.0),

                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),

                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Row(children: [
                                Icon(Icons.feedback_outlined),
                                SizedBox(width: 50),
                                Text('Feedbacks'),
                                SizedBox(width: 92),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ]),
                              // child: const Text('hay'),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,

                            margin: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 0,
                            ),
                            // padding: const EdgeInsets.only(
                            //     left: 5, right: 5, top: 5, bottom: 5),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                // overlayColor: MaterialStateProperty.all<Color>(
                                //   Colors.white
                                // ),

                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(300, 50)),
                                elevation: MaterialStateProperty.all(12.0),

                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.black,
                                ),

                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: const Row(children: [
                                Icon(Icons.request_page_outlined),
                                SizedBox(width: 50),
                                Text('Job Request'),
                                SizedBox(width: 80),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ]),
                              // child: const Text('hay'),
                            ),
                          ),
                          const SizedBox(height: 44),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ),

              //////////////////////////////////////////
              // ),

              const Card(
                color: Colors.amber,
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 80,
                ),
                child: ButtonBar(),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
