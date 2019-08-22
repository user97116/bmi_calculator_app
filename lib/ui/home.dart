import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	var heightVal = 0.0;
	var weightVal = 0.0;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: <Widget>[
					Container(
						decoration: BoxDecoration(
							gradient: LinearGradient(
									colors: [
										Colors.pink.withOpacity(0.6),
										Colors.pink,
									],
									begin: Alignment.topLeft
							),
						),
					),
					getLayer0(),
					getShade(10),
					getShade(15),
					getShade(30),
					getShade(55),

					Align(
						alignment: Alignment.bottomCenter,
						child: ClipPath(
							clipper: MyClipper(),
							child: Container(
								height: 200.0,
								padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
								color: Colors.white,
								child: Column(
									mainAxisAlignment: MainAxisAlignment.end,
									children: <Widget>[
										Text(
											"Body mass index, or BMI, is used to determine whether"
													" you are in a healthy weight range for your height",
											style: TextStyle(
												color: Colors.grey,
												fontWeight: FontWeight.w600,
												fontSize: 14.0,
												fontStyle: FontStyle.normal,
											),
										),
										SizedBox(height: 15.0),
										Text(
											"* This calculator shouldn't be used for pregrant women or children",
											style: TextStyle(
												color: Colors.grey,
												fontWeight: FontWeight.w500,
												fontSize: 11.0,
												fontStyle: FontStyle.italic,
											),
										),
									],
								),
							),
						),
					),
					Align(
						alignment: Alignment(0.8, 0.5),
						child: FloatingActionButton(
							onPressed: () {},
							backgroundColor: Colors.white,
							child: Icon(
								Icons.navigate_next,
								color: Colors.pink,
							),
						),
					)
				],
			),
		);
	}
	getShade(offset) {
		return Align(
			alignment: Alignment.bottomCenter,
			child: ClipPath(
				clipper: MyClipper(),
				child: Container(
					height: 200.0 + offset,
					color: Colors.white30,
				),
			),
		);
	}

	getLayer0() {
		return Column(
			children: <Widget>[
				Container(
					margin: EdgeInsets.only(top: 64),
				),
				Text(
					"GENDER",
					style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
				),
				SizedBox(height: 20.0),
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						_buildMaterialButton(true,FontAwesomeIcons.male, "Male"),
						_buildMaterialButton(false,FontAwesomeIcons.female, "Female"),
					],
				),
				SizedBox(height: 40.0),
				CustomSlider(
					val: heightVal,
					text: "HEIGHT",
					unit: "cm",
				),
				CustomSlider(
					val: weightVal,
					text: "WEIGHT",
					unit: "kg",
				),
			],
		);
	}

	MaterialButton _buildMaterialButton(isSelected,icon, text) {
		return MaterialButton(
			onPressed: () {},
			color: isSelected?Colors.white:Colors.white.withOpacity(0.4),
			shape: StadiumBorder(),
			child: Row(
				mainAxisSize: MainAxisSize.min,
				children: <Widget>[
					Icon(
						icon,
						color: isSelected?Colors.pink:Colors.white,
					),
					SizedBox(width: 5.0),
					Text(
						"$text",
						style: TextStyle(
							color: isSelected?Colors.pink:Colors.white,
							fontWeight: FontWeight.bold,
						),
					),
				],
			),
			padding: EdgeInsets.symmetric(
				horizontal: 32.0,
				vertical: 8.0,
			),
		);
	}
}

class MyClipper extends CustomClipper<Path> {
	@override
	Path getClip(Size size) {
		Path path = Path();
		path.lineTo(0, size.height);
		path.lineTo(size.width, size.height);
		path.lineTo(size.width, 20);
		path.quadraticBezierTo(size.width - size.width / 4, 0, size.width / 2, 50);
		path.quadraticBezierTo(size.width / 4, 100, 0, 20);
		return path;
	}

	@override
	bool shouldReclip(CustomClipper<Path> oldClipper) {
		return false;
	}
}

class CustomSlider extends StatefulWidget {
	final val;
	final text;
	final unit;

	CustomSlider({this.val, this.text, this.unit});

	@override
	_CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
	var value;

	@override
	void initState() {
		super.initState();
		value = widget.val;
	}

	@override
	Widget build(BuildContext context) {
		return Column(
			children: <Widget>[
				SizedBox(height: 20.0),
				Text(
					"${widget.text}",
					style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
				),
				SizedBox(height: 50.0),
				Theme(
					data: ThemeData(
							sliderTheme: SliderThemeData(
									thumbColor: Colors.white,
									overlayColor: Colors.transparent,
									activeTrackColor: Colors.white,
									trackHeight: 7.0,
									thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
									inactiveTrackColor: Colors.white70,
									valueIndicatorColor: Colors.white.withOpacity(0.2),
									valueIndicatorTextStyle: TextStyle(color: Colors.white))),
					child: Slider(
						value: value,
						onChanged: (w) {
							setState(() {
								value = w;
							});
						},
						divisions: 200,
						label: "${(value * 100).floor()} ${widget.unit}",
					),
				),
				SizedBox(height: 20.0),
			],
		);
	}
}
