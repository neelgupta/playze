import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:playze/Reusability/shared/custom_btmbar.dart';
import 'package:playze/Reusability/utils/util.dart';
import 'package:playze/app/routes/app_pages.dart';

import '../controllers/full_details_controller.dart';

class FullDetailsView extends GetView<FullDetailsController> {
  const FullDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Container(
              height: Get.height*0.3,
              width: Get.width,
              child:
                  Stack(
                    children: [
                      Swiper(
                        scrollDirection:Axis.horizontal,
                        itemBuilder:(BuildContext context, int index) {
                          return Container(
                            height: Get.height*0.25,
                            width: Get.width,
                            child: Image.asset("assets/images/view.png",fit: BoxFit.fill),
                          );
                        },
                        itemCount: 3,
                        layout: SwiperLayout.DEFAULT,
                        pagination: new SwiperPagination(margin: EdgeInsets.only(bottom: 30)),

                        autoplay: true,
                      ),
                      Positioned(
                        top: 30,
                        left: 10,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                height: Get.height * 0.07,
                                decoration: BoxDecoration(
                                ),
                                child: Center(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Image(
                                        image:
                                        AssetImage("assets/images/back.png"),
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Details",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        right: 20,
                        child: Container(
                          height: Get.height*0.06,
                          width: Get.width*0.06,
                          child: Image.asset("assets/images/dil.png"),
                        ),
                      )
                    ],
                  )
            ),
            Positioned(
              top: 210,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                height: Get.height*0.72,
                width: Get.width,
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            children: [
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
                                  Row(
                                    children: [
                                      Image(image: AssetImage("assets/images/plus.png"),width: 25,),
                                      Text("  Playze Workspace"),
                                    ],
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(height: Get.height*0.03,),
                              Align(child: Text("La Ronde",style: TextStyle(fontSize: 22),),alignment: Alignment.topLeft,),
                              SizedBox(height: Get.height*0.01,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: RatingBar.builder(
                                  itemSize: 20,
                                  initialRating: 3.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),SizedBox(height: Get.height*0.01,),
                              Text("Get your adrenaline pumping on one of its many roller coasters or other thrill seeking rides and enjoy panoramic views from the Ferris wheel. Take the smaller kids on a boat ride, a train ride, a tea cup ride or a carousel. There is also live entertainment, shopping and dining facilities, as well as annual events.",style: TextStyle(fontSize: 12),),
                              SizedBox(height: Get.height*0.01,),
                              Obx(()=>controller.tabon.value == true? Align(child: Text("Highlights",style: TextStyle(fontSize: 18),),alignment: Alignment.topLeft,):SizedBox(height: Get.height*0.01,)),
                                Obx(()=>controller.tabon.value == true?
                                   RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: ".",style: TextStyle(fontSize: 40,color: Colors.cyan)),
                                        TextSpan(
                                            text: " Lorem ipsum dolor sit amet, consetetur sadipscing elitr,    sed diam nonumy eirmod tempor",
                                            style: TextStyle(fontSize: 12,color: Colors.black)),]
                                  )):SizedBox(width: Get.width*0.01,),
                                ),
                                Obx(()=>controller.tabon.value == true?
                                   RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: ".",style: TextStyle(fontSize: 40,color: Colors.cyan)),
                                        TextSpan(
                                            text: " Lorem ipsum dolor sit amet, consetetur sadipscing elitr,    sed diam nonumy eirmod tempor",
                                            style: TextStyle(fontSize: 12,color: Colors.black)),]
                                  )):SizedBox(width: Get.width*0.01,),
                                ),
                              Obx(()=>controller.tabon.value == true?
                                     RichText(text: TextSpan(
                                      children: [
                                        TextSpan(text: ".",style: TextStyle(fontSize: 40,color: Colors.cyan)),
                                        TextSpan(
                                            text: " Lorem ipsum dolor sit amet, consetetur sadipscing elitr,    sed diam nonumy eirmod tempor",
                                            style: TextStyle(fontSize: 12,color: Colors.black)),]
                                  )):SizedBox(width: Get.width*0.01,),
                                ),
                              SizedBox(height: Get.height*0.01,),
                              GestureDetector(
                                  onTap: () {
                                    print("11");
                                    controller.tabon.value = !controller.tabon.value;
                                    print(controller.tabon.value);
                                  },
                                  child: Align(child: Text("Read More",style: TextStyle(fontSize: 12,color: Colors.blueAccent),),alignment: Alignment.topLeft,)),
                              SizedBox(height: Get.height*0.02,),
                              Align(child: Text("Images",style: TextStyle(fontSize: 18),),alignment: Alignment.topLeft,),
                              SizedBox(height: Get.height*0.02,),
                              Container(
                                height: Get.height*0.2,
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 5,itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                Get.toNamed(Routes.REVIEW_IMAGES);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                  image: DecorationImage(image: AssetImage("assets/images/view.png"),fit: BoxFit.fill)
                                                ),
                                                height: Get.height*0.15,
                                                width: Get.width*0.5,
                                              ),
                                            ),
                                            w(20),

                                          ],
                                        ),
                                        h(5),
                                        Text("Lorem ipsum dolor sit amet",style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                  );
                                },),
                              ),
                              h(10),
                              Align(child: Text("Videos",style: TextStyle(fontSize: 18),),alignment: Alignment.topLeft,),
                              SizedBox(height: Get.height*0.02,),
                              Container(
                                height: Get.height*0.2,
                                child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 5,itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap:(){
                                                Get.toNamed(Routes.REVIEW_VIDEOS);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    image: DecorationImage(image: AssetImage("assets/images/view.png"),fit: BoxFit.fill),
                                                ),
                                                height: Get.height*0.15,
                                                    child: Image.asset("assets/images/play.png"),
                                                width: Get.width*0.5,
                                              ),
                                            ),
                                            w(20),

                                          ],
                                        ),
                                        h(5),
                                        Text("Lorem ipsum dolor sit amet",style: TextStyle(fontSize: 12),),
                                      ],
                                    ),
                                  );
                                },),
                              ),
                              h(5),
                              Divider(),
                              h(10),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Cost",style: TextStyle(fontSize: 22),),
                                          ],
                                        ),
                                        height: Get.height*0.05,
                                      ),
                                      w(20),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("For Adults     :",style: TextStyle(fontSize: 20),),
                                          Text("For Children  : ",style: TextStyle(fontSize: 20),)
                                        ],
                                      ),
                                      w(5),
                                      Column(
                                        children: [
                                          Text("\$  30",style: TextStyle(fontSize: 18,color: Colors.blueAccent),),
                                          Text("\$  30",style: TextStyle(fontSize: 18,color: Colors.blueAccent),)
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              h(10),
                              Divider(),
                              h(10),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: Get.height*0.06,
                                          width: Get.width*0.07,
                                        child: Image.asset("assets/images/phone.png"),
                                      ),
                                      w(5),
                                      Text("+1 514-397-2000",style: TextStyle(fontSize: 14,color: Colors.grey),)
                                    ],
                                  ),
                                  h(2),
                                  Row(
                                    children: [
                                      Container(
                                        height: Get.height*0.06,
                                          width: Get.width*0.07,
                                        child: Image.asset("assets/images/mapyellow.png"),
                                      ),
                                      w(5),
                                      Container(width: Get.width*0.7,child: Text("22 Chem. Macdonald, Montréal, QC H3C 6A3, Canada",style: TextStyle(fontSize: 14,color: Colors.grey,overflow: TextOverflow.ellipsis),))
                                    ],
                                  ),
                                  h(2),
                                  Row(
                                    children: [
                                      Container(
                                        height: Get.height*0.06,
                                          width: Get.width*0.07,
                                        child: Image.asset("assets/images/time.png"),
                                      ),
                                      w(5),
                                      Text("9AM to 11 PM",style: TextStyle(fontSize: 14,color: Colors.grey),)
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: Get.height*0.2,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image:AssetImage("assets/images/map_02.png"),fit: BoxFit.fill)
                              ),
                              child: Image.asset("assets/images/locationred.png"),
                            ),
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Container(
                                height: Get.height*0.07,
                                width: Get.width*0.08,
                                child: Image.asset("assets/images/blueback.png"),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: 20,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                height: Get.height*0.11,
                                width: Get.width*0.1,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle
                                ),
                                child: Image.asset("assets/images/Block.png"),
                              ),
                            )
                          ],
                        ),
                        h(10),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Rating & Reviews",style: TextStyle(fontSize: 20),),
                                  ButtonWithStyle(
                                    onPressed: () {
                                      Get.toNamed(Routes.WRITEAREVIEW);
                                    },
                                    textVal: "Add Reviews",
                                    btnwidth: Get.width*0.25,
                                  ),
                                ],
                              ),
                              h(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("Total Ratings",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                      Text("50",style: TextStyle(color: Colors.black,fontSize: 26),),
                                      h(20),
                                      Text("Avg Rating",style: TextStyle(color: Colors.grey,fontSize: 16),),
                                      Row(
                                        children: [
                                          Container(
                                            height: Get.height*0.04,
                                            width: Get.width*0.05,
                                            child: Image.asset("assets/images/star.png"),
                                          ),
                                          w(2),
                                          Text("4.8",style: TextStyle(color: Colors.black,fontSize: 26),),

                                        ],
                                      )
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: 10,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Column(
                                      children: <Widget>[
                                         Row(
                                           children: [
                                             LinearPercentIndicator(
                                               isRTL: true,
                                               addAutomaticKeepAlive: true,
                                              width: Get.width*0.42,
                                              lineHeight: 8.0,
                                              percent: 0.2,
                                              progressColor: Colors.amber,
                                        ),
                                             Text("5 Star",style: TextStyle(color: Colors.grey))
                                           ],
                                         ),
                                        h(10),
                                        Row(
                                          children: [
                                            LinearPercentIndicator(
                                              isRTL: true,
                                              addAutomaticKeepAlive: true,
                                              width: Get.width*0.42,
                                              lineHeight: 8.0,
                                              percent: 0.2,
                                              progressColor: Colors.amber,
                                            ),
                                            Text("4 Star",style: TextStyle(color: Colors.grey))
                                          ],
                                        ),
                                        h(10),
                                        Row(
                                          children: [
                                            LinearPercentIndicator(
                                              isRTL: true,
                                              addAutomaticKeepAlive: true,
                                              width: Get.width*0.42,
                                              lineHeight: 8.0,
                                              percent: 0.2,
                                              progressColor: Colors.amber,
                                            ),
                                            Text("3 Star",style: TextStyle(color: Colors.grey))
                                          ],
                                        ),
                                        h(10),
                                        Row(
                                          children: [
                                            LinearPercentIndicator(
                                              isRTL: true,
                                              addAutomaticKeepAlive: true,
                                              width: Get.width*0.42,
                                              lineHeight: 8.0,
                                              percent: 0.2,
                                              progressColor: Colors.amber,
                                            ),
                                            Text("2 Star",style: TextStyle(color: Colors.grey))
                                          ],
                                        ),
                                           h(10),
                                        Row(
                                          children: [
                                            LinearPercentIndicator(
                                              isRTL: true,
                                              addAutomaticKeepAlive: true,
                                              width: Get.width*0.42,
                                              lineHeight: 8.0,
                                              percent: 0.2,
                                              progressColor: Colors.amber,
                                            ),
                                            Text("1 Star",style: TextStyle(color: Colors.grey),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        h(10),
                        DefaultTabController(
                            length: 3, // length of tabs
                            initialIndex: 0,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                              Container(
                                child: TabBar(
                                  labelColor: Color(0xffFE7702),
                                  indicatorColor: Colors.transparent,
                                  padding: EdgeInsets.only(right: 100),
                                  unselectedLabelColor: Colors.grey,
                                  unselectedLabelStyle: TextStyle(fontSize: 12),
                                  labelStyle: TextStyle(fontSize: 16),
                                  tabs: [
                                    Tab(text: 'Reviews',),
                                    Tab(text: 'Images'),
                                    Tab(text: 'Videos'),
                                  ],

                                ),
                              ),
                              Container(
                                  height: Get.height*0.8, //height of TabBarView
                                  decoration: BoxDecoration(
                                      border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                                  ),
                                  child: TabBarView(children: <Widget>[
                                    Container(
                                      height: Get.height,
                                        width: Get.width,
                                      margin: EdgeInsets.only(left: 20,right: 20),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: Get.height*0.35,
                                                  width: Get.width*0.13,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: Get.height*0.1,
                                                        width: Get.width*0.15,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle
                                                        ),
                                                        child: Image.asset("assets/images/profilepic.png"),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                w(20),
                                                Container(
                                                  padding: EdgeInsets.only(top: 20),
                                                  height: Get.height*0.35,
                                                  width: Get.width*0.7,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.topLeft,
                                                        child: RatingBar.builder(
                                                          itemSize: 20,
                                                          initialRating: 3.5,
                                                          minRating: 1,
                                                          direction: Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                          itemBuilder: (context, _) => Icon(
                                                            Icons.star,
                                                            size: 16,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate: (rating) {
                                                            print(rating);
                                                          },
                                                        ),
                                                      ),
                                                      h(5),
                                                      Text("by Darryl McKinnon on April 22, 2020",style: TextStyle(fontSize: 14),),
                                                      h(5),
                                                      Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum...",style: TextStyle(fontSize: 10),),
                                                      h(5),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              image: DecorationImage(image: AssetImage("assets/images/view.png"),fit: BoxFit.fill)
                                                            ),
                                                            width: Get.width*0.32,
                                                            height: Get.height*0.1,
                                                          ),
                                                          w(5),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                              image: DecorationImage(image: AssetImage("assets/images/view.png"),fit: BoxFit.fill)
                                                            ),
                                                            width: Get.width*0.32,
                                                            height: Get.height*0.1,
                                                          ),
                                                        ],
                                                      ),
                                                      h(5),
                                                      ButtonWithStyle(
                                                        onPressed: () {

                                                        },
                                                        textVal: "VIEW MORE",
                                                        style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w300),
                                                        btnwidth: Get.width*0.2,

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(child: Text("Nearby Places",style: TextStyle(fontSize: 18),),alignment: Alignment.topLeft,),
                                            SizedBox(height: Get.height*0.02,),
                                            Container(
                                              height: Get.height*0.28,
                                              child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: 5,itemBuilder: (context, index) {
                                                return Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  image: DecorationImage(image: AssetImage("assets/images/view.png"),fit: BoxFit.fill),
                                                                ),
                                                                height: Get.height*0.15,

                                                                width: Get.width*0.5,
                                                              ),
                                                              Positioned(
                                                                top : 3,
                                                                left : 10,
                                                                child: Container(
                                                                  height: Get.height*0.06,
                                                                  width: Get.width*0.06,
                                                                  child: Image.asset("assets/images/dil.png"),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          w(20),
                                                        ],
                                                      ),
                                                      h(5),
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
                                                          Text("2 min",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                          SizedBox(width: Get.width*0.02,),
                                                          Text("1 km away",style: TextStyle(fontSize: 12,color: Colors.grey)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },),
                                            ),
                                          ],
                                        ),
                                      )
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      child: Center(
                                        child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ])
                              )
                            ])
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),
        bottomNavigationBar: btmbar(fromOther: true),
      extendBody: true,
    );
  }
}
