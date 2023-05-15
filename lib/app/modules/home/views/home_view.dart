import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/shared/drawer.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/modules/BottomNavigationbar/controllers/bottom_navigationbar_controller.dart';
import 'package:playze/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final controller = Get.put<HomeController>(HomeController());
  final controllerc = Get.put<BottomNavigationbarController>(BottomNavigationbarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _key,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1, //
        flexibleSpace: Container(
          height: Get.height * 0.2,
          color: Color(0xff0264C5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 10, bottom: 10,right: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: const BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: const Image(
                                image:
                                AssetImage("assets/images/menu.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Home",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,

                                )),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.NOTIFICATIONS);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: Get.height * 0.06,
                        decoration: BoxDecoration(
                        ),
                        child: Center(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              child: Image(
                                image:
                                AssetImage("assets/images/beel.png"),
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: CsDrawer(),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        )
            :Obx(()=>controller.ison.value!=true?
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Get.height*0.85,
                        width: Get.width,
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(target: HomeController.location1,zoom: 14.5),
                          markers: Set<Marker>.of(controller.markers),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: Get.height*0.1,),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.SEARCH);
                            },
                            child: Container(
                              height: Get.height*0.06,
                              width: Get.width*0.75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(25))
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: Get.width*0.03,),
                                  Container(
                                      height: Get.height*0.05,
                                      width: Get.width*0.07,
                                      child: Image(image: AssetImage("assets/images/search.png"))),
                                  SizedBox(width: Get.width*0.03,),
                                  Container(
                                    height: Get.height*0.3,
                                    width: Get.width*0.5,
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: "Search places",
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width*0.02,),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(Routes.FILTER);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: Get.height*0.06,
                              width: Get.width*0.13,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Image.asset("assets/images/menu2.png"),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 100,
                        left: 20,
                        child: GestureDetector(
                          onTap: (){
                            controller.ison.value = true;
                            controllerc.Dpop.value = false;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.blueAccent),
                              color: Colors.white,
                            ),
                            height: Get.height*0.05,
                            width: Get.width*0.4,
                            child: Row(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    width: Get.width*0.25,
                                    child: Text("List View")),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: Get.height*0.05,
                                  width: Get.width*0.07,
                                  child: Image.asset("assets/images/list.png"),
                                ),
                                SizedBox(width: Get.width*0.03,)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 115,
                        right: 20,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: Get.height*0.09,
                          width: Get.width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: Image.asset("assets/images/location.png"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ):
            Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height*0.1,),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.SEARCH);
                          },
                          child: Container(
                            height: Get.height*0.06,
                            width: Get.width*0.75,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: Get.width*0.03,),
                                Container(
                                    height: Get.height*0.05,
                                    width: Get.width*0.07,
                                    child: Image(image: AssetImage("assets/images/search.png"))),
                                SizedBox(width: Get.width*0.03,),
                                Container(
                                  height: Get.height*0.3,
                                  width: Get.width*0.5,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: "Search places",
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width*0.02,),
                        GestureDetector(
                          onTap: (){
                            Get.offNamed(Routes.FILTER);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: Get.height*0.06,
                            width: Get.width*0.13,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Image.asset("assets/images/menu2.png"),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      color: Colors.white,
                      height: Get.height*0.75,
                      width: Get.width,
                      child: ListView.builder(itemCount: 3,itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            height: Get.height*0.25,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: 10,
                                            child: Container(
                                              child: Image(image: AssetImage("assets/images/dil.png")),
                                              height: Get.height*0.02,
                                            ),
                                          )
                                        ],
                                      ),
                                      height: Get.height*0.12,
                                      width: Get.width*0.4,
                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Children’s Museum"),
                                          SizedBox(
                                            height: Get.
                                            height*0.01,),
                                          Row(
                                            children: [
                                              Container(
                                                  height: Get.height*0.02,
                                                  child: Image(image: AssetImage("assets/images/star.png"))),
                                              SizedBox(width: Get.width*0.02,),
                                              Text("4.0",style: TextStyle(fontSize: 16),),
                                              SizedBox(width: Get.width*0.02,),
                                              Text("150 Reviews",style: TextStyle(fontSize: 12,color: Colors.grey),),


                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.
                                            height*0.01,),
                                          Row(
                                            children: [
                                              Container(
                                                  height: Get.height*0.02,
                                                  child: Image(image: AssetImage("assets/images/log.png"))),
                                              SizedBox(width: Get.width*0.02,),
                                              Container(width:Get.width*0.35,child: Text("100 Laurier Street, Gatineau..",style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12,color: Colors.grey),)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Get.
                                            height*0.01,),
                                          Row(
                                            children: [
                                              Container(
                                                  height: Get.height*0.02,
                                                  child: Image(image: AssetImage("assets/images/walking.png"))),
                                              SizedBox(width: Get.width*0.02,),
                                              Text("2 min",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                              SizedBox(width: Get.width*0.02,),
                                              Text("1 km away",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Get.height*0.025,),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image(image: AssetImage("assets/images/go.png"),width: 25,),

                                        Text("  Go"),
                                      ],
                                    ),
                                    SizedBox(width: Get.width*0.025,),
                                    Row(
                                      children: [
                                        Image(image: AssetImage("assets/images/plan.png"),width: 25,),
                                        Text("  My Plan"),
                                      ],
                                    ),
                                    ButtonWithStyle(
                                      onPressed: () {
                                        Get.toNamed(Routes.FULL_DETAILS);
                                      },
                                      textVal: "Details",
                                      btnwidth: Get.width*0.3,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                )
                              ],
                            ),
                          ),
                        );
                      },),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 72,
                  child: Container(padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    height: Get.height*0.08,
                    width: Get.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.ison.value = false;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Colors.blueAccent),
                              color: Colors.white,
                            ),
                            height: Get.height*0.05,
                            width: Get.width*0.4,
                            child: Row(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    width: Get.width*0.25,
                                    child: Text("Map View")),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: Get.height*0.05,
                                  width: Get.width*0.07,
                                  child: Image.asset("assets/images/mapviwe.png"),
                                ),
                                SizedBox(width: Get.width*0.03,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
