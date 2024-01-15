// ignore_for_file: unnecessary_import, non_constant_identifier_names, file_names

import 'dart:ui';

import 'package:campon_app/example/Utils/Colors.dart';
import 'package:flutter/material.dart';

CustomAppbar(
    {centertext,
    ActionIcon,
    bgcolor,
    Color? actioniconcolor,
    leadingiconcolor,
    titlecolor}) {
  return AppBar(
      actions: [
        Padding(
            padding: const EdgeInsets.only(top: 30, right: 18),
            child: Icon(
              ActionIcon,
              color: actioniconcolor,
            ))
      ],
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          centertext,
          style: TextStyle(color: titlecolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      leading: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: BackButton(
            color: leadingiconcolor,
          )),
      elevation: 0,
      backgroundColor: bgcolor);
}

textfield({String? text, prefix, suffix, Color? hintcolor, feildcolor}) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: feildcolor),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: hintcolor, fontFamily: "Gilroy Medium"),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: prefix,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: suffix,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: greyColor,
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
      ));
}

AppButton({onclick, buttontext}) {
  return InkWell(
    onTap: onclick,
    child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Darkblue),
        child: Center(
            child: Text(buttontext,
                style: TextStyle(
                    fontSize: 16,
                    color: WhiteColor,
                    fontFamily: "Gilroy Bold")))),
  );
}

cupon({text1, text2, buttontext, Function()? onClick}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1,
              style: TextStyle(
                  fontSize: 15, color: greyColor, fontFamily: "Gilroy Medium")),
          const SizedBox(height: 4),
          Text(text2,
              style: TextStyle(
                  fontSize: 16, color: Darkblue, fontFamily: "Gilroy Bold")),
        ],
      ),
      InkWell(
        onTap: onClick,
        child: Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Darkblue),
          child: Center(
            child: Text(
              buttontext,
              style: TextStyle(
                  fontSize: 15, color: WhiteColor, fontFamily: "Gilroy Bold"),
            ),
          ),
        ),
      ),
    ],
  );
}

AccountSetting(
    {IconData? icon,
    String? text,
    image,
    Color? TextColor,
    boxcolor,
    ImageColor,
    iconcolor,
    Function()? onclick}) {
  return InkWell(
    onTap: onclick,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: boxcolor),
      child: ListTile(
        leading: Image.asset(
          image,
          height: 25,
          color: ImageColor,
        ),
        title: Text(text!,
            style: TextStyle(
                fontSize: 15, color: TextColor, fontFamily: "Gilroy Bold")),
        trailing: Icon(icon, color: iconcolor),
      ),
    ),
  );
}

List hotelList = [
  {
    "id": "1",
    "title": "Grand Park City Hotel",
    "img": "assets/images/SingaporeHotel.jpg",
    "price": "\$26/Night",
    "address": "155 Rajadamri Road, Bangkok 10330 Thailand"
  },
  {
    "id": "2",
    "title": "Voco an ihg hotel",
    "img": "assets/images/VocoHotel.jpg",
    "price": "\$28/Night",
    "address": "Chao Anou Road, 112 Vat Chan Village, Chanthabouly District"
  },
  {
    "id": "3",
    "title": "Mandarin Oriental",
    "img": "assets/images/BangkokHotel.jpg",
    "price": "\$30/Night",
    "address": "1091/336 New Patchier Road, 10400 Bangkok, Thailand"
  },
  {
    "id": "4",
    "title": "Anantara Siam hotel",
    "img": "assets/images/AnantaraHotel.jpg",
    "price": "\$32/Night",
    "address": "87 Wireless Road, Phatumwan, 10330, Bangkok"
  },
  {
    "id": "5",
    "title": "Boutique Hotel",
    "img": "assets/images/BoutiqueHotel.jpg",
    "price": "\$34/Night",
    "address": "Sheikh Mohammed Bin Rashed Boulevard, Downtown Dubai"
  },
  {
    "id": "6",
    "title": "Sterling Hotel",
    "img": "assets/images/SterlingHotel.jpeg",
    "price": "\$36/Night",
    "address": "103 River Street, Ballina, Ballina, Australia"
  },
  {
    "id": "7",
    "title": "Royal Fort Hotel",
    "img": "assets/images/RoyalHotel.jpg",
    "price": "\$38/Night",
    "address": "449 Sainte-Hélène St Montréal, Quebec, H2Y 2K9 Canada"
  },
  {
    "id": "8",
    "title": "Singapore Hotel",
    "img": "assets/images/SwissHotel.jpg",
    "price": "\$40/Night",
    "address": "1, Voznesensky Avenue"
  },
  {
    "id": "9",
    "title": "Hyatt Hotel",
    "img": "assets/images/HyattHotel.jpg",
    "price": "\$42/Night",
    "address":
        "Bandra Kurla Complex Vicinity, Mumbai, Maharashtra, India, 400 055"
  },
  {
    "id": "10",
    "title": "Luxury Hotel",
    "img": "assets/images/LuxuryHotel.jpg",
    "price": "\$44/Night",
    "address": "14, Moyka river embankment."
  },
];

List hotelList2 = [
  {
    "id": "1",
    "title": "Grand Park City Hotel",
    "img": "assets/images/SwissHotel.jpg",
    "price": "\$26/",
    "address": "155 Rajadamri Road, Bangkok 10330 Thailand",
    "Night": "Night",
    "review": "4.9",
    "reviewCount": "(160 Reviews)"
  },
  {
    "id": "2",
    "title": "The Leela hotel",
    "img": "assets/images/TheLeelaHotel.jpg",
    "price": "\$28/",
    "address": "Chao Anou Road, 112 Vat Chan Village, Chanthabouly District",
    "Night": "Night",
    "review": "4.8",
    "reviewCount": "(150 Reviews)"
  },
  {
    "id": "3",
    "title": "Mandarin Oriental",
    "img": "assets/images/NationalHotel.jpg",
    "price": "\$30/",
    "address": "1091/336 New Petchburi Road, 10400 Bangkok, Thailand",
    "Night": "Night",
    "review": "4.7",
    "reviewCount": "(140 Reviews)"
  },
  {
    "id": "4",
    "title": "Anantara Siam hotel",
    "img": "assets/images/dubaiHotel.jpg",
    "price": "\$32/",
    "address": "87 Wireless Road, Phatumwan, 10330, Bangkok",
    "Night": "Night",
    "review": "4.6",
    "reviewCount": "(130 Reviews)"
  },
  {
    "id": "5",
    "title": "Boutique Hotel",
    "img": "assets/images/AnticipatedHotel.jpg",
    "price": "\$34/",
    "address": "Sheikh Mohammed Bin Rashed Boulevard, Downtown Dubai",
    "Night": "Night",
    "review": "4.5",
    "reviewCount": "(120 Reviews)"
  },
  {
    "id": "6",
    "title": "Sterling Hotel",
    "img": "assets/images/IntercontinentalHotel.jpg",
    "price": "\$36/",
    "address": "103 River Street, Ballina, Ballina, Australia",
    "Night": "Night",
    "review": "4.4",
    "reviewCount": "(110 Reviews)"
  },
  {
    "id": "7",
    "title": "Royal Fort Hotel",
    "img": "assets/images/StateHotel.jpg",
    "price": "\$38/",
    "address": "449 Sainte-Hélène St Montréal, Quebec, H2Y 2K9 Canada",
    "Night": "Night",
    "review": "4.3",
    "reviewCount": "(100 Reviews)"
  },
  {
    "id": "8",
    "title": "Singapore Hotel",
    "img": "assets/images/vishakhapatnamHotel.jpg",
    "price": "\$40/",
    "address": "1, Voznesensky Avenue",
    "Night": "Night",
    "review": "4.2",
    "reviewCount": "(90 Reviews)"
  },
  {
    "id": "9",
    "title": "Hyatt Hotel",
    "img": "assets/images/hotel.jpg",
    "price": "\$42/",
    "address":
        "Bandra Kurla Complex Vicinity, Mumbai, Maharashtra, India, 400 055",
    "Night": "Night",
    "review": "4.1",
    "reviewCount": "(80 Reviews)"
  },
  {
    "id": "10",
    "title": "Luxury Hotel",
    "img": "assets/images/SagamoreResort.jpg",
    "price": "\$44/",
    "address": "14, Moyka river embankment.",
    "Night": "Night",
    "review": "3.8",
    "reviewCount": "(70 Reviews)"
  },
];

List hotelList3 = [
  {"price": "\$44"},
  {"price": "\$42"},
  {"price": "\$40"},
  {"price": "\$38"},
  {"price": "\$40"},
  {"price": "\$34"},
  {"price": "\$32"},
  {"price": "\$30"},
  {"price": "\$46"},
  {"price": "\$44"},
];

List hotelList4 = [
  {
    "id": "1",
    "title": "John kennedy",
    "img": "assets/images/person.jpg",
    "price": "\$26/Night",
    "massage": "hotel is named among the best hotels in the state",
    "review": "4.8",
  },
  {
    "id": "2",
    "title": "Alexander",
    "img": "assets/images/person1.jpeg",
    "price": "\$28/Night",
    "massage": "Thank you for booking our hotel",
    "review": "4.6",
  },
  {
    "id": "3",
    "title": "Emanuel",
    "img": "assets/images/person2.jpg",
    "price": "\$30/Night",
    "massage": "50% discount on first booking at Amari Hotel",
    "review": "4.5",
  },
  {
    "id": "4",
    "title": "Jamison",
    "img": "assets/images/person12.jpg",
    "price": "\$32/Night",
    "massage": "You will have more fun in  hotel than any other hotel",
    "review": "4.4",
  },
  {
    "id": "5",
    "title": "Quentin",
    "img": "assets/images/person5.jpg",
    "price": "\$34/Night",
    "massage": "Thank you for booking our hotel",
    "review": "4.3",
  },
  {
    "id": "6",
    "title": "Albert",
    "img": "assets/images/person6.jpg",
    "price": "\$36/Night",
    "massage": "This hotel is better than other hotel",
    "review": "4.6",
  },
  {
    "id": "7",
    "title": "Lawrence",
    "img": "assets/images/person7.jpg",
    "price": "\$38/Night",
    "massage": " Sainte-Hélène St Montréal, Quebec, H2Y 2K9 Canada",
    "review": "4.7",
  },
  {
    "id": "8",
    "title": "Alessandro",
    "img": "assets/images/person8.jpg",
    "price": "\$40/Night",
    "massage": "hotel is named among the best hotels in the state",
    "review": "4.1",
  },
  {
    "id": "9",
    "title": "Harrison",
    "img": "assets/images/person9.jpg",
    "price": "\$42/Night",
    "massage": "Money back if you don't enjoy our hotel",
    "review": "4.0",
  },
  {
    "id": "10",
    "title": "Maverick",
    "img": "assets/images/person13.jpg",
    "price": "\$44/Night",
    "massage": "50% discount on first booking at Amari Hotel",
    "review": "3.9",
  },
];

List hotelList5 = [
  {
    "title": "Kim Hayo Send You a Message",
    "subtitle":
        "Hi mariana, are you looking for hotel in Purwokerto? You can check our hotel",
    "massagetime": "1:m Ago"
  },
  {
    "title": "John  Send You a Message",
    "subtitle":
        "The service is on point, and I really like the facilities. Good job!",
    "massagetime": "2:m Ago"
  },
  {
    "title": "Alexander Send You a Message",
    "subtitle":
        "The hotels give me amazing view, I really like it!. All people must try this hotel.",
    "massagetime": "3:m Ago"
  },
  {
    "title": "Maverick Send You a Message",
    "subtitle":
        "Comfortable room and amazing beach view in every room, make me happy!",
    "massagetime": "4:m Ago"
  },
  {
    "title": "Harrison Send You a Message",
    "subtitle":
        "Hello Marine, Yes the room is available,so you can make an order.",
    "massagetime": "5:m Ago"
  },
  {
    "title": "Lawrence Send You a Message",
    "subtitle": "You will have more fun in  hotel than any other hotel",
    "massagetime": "6:m Ago"
  },
  {
    "title": "Quentin Send You a Message",
    "subtitle":
        "The hotels give me amazing view, I really like it!. All people must try this hotel.",
    "massagetime": "7:m Ago"
  },
  {
    "title": "Albert Send You a Message",
    "subtitle":
        "Comfortable room and amazing beach view in every room, make me happy!",
    "massagetime": "8:m Ago"
  },
  {
    "title": "Emanuel Send You a Message",
    "subtitle":
        "Hi mariana, are you looking for hotel in Purwokerto? You can check our hotel",
    "massagetime": "9:m Ago"
  },
  {
    "title": "Jamison Send You a Message",
    "subtitle":
        "The service is on point, and I really like the facilities. Good job!",
    "massagetime": "10:m Ago"
  },
];
