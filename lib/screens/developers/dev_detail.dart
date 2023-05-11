import 'package:flutter/material.dart';

class DetailDevs extends StatefulWidget {
  const DetailDevs({Key? key,required this.image , required this.name, required this.email, required this.phoneNo, required this.address}) : super(key: key);
 final String image;
 final String name;
 final String email;
 final String phoneNo;
 final String address;

  @override
  State<DetailDevs> createState() => _DetailDevsState();
}

class _DetailDevsState extends State<DetailDevs> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double top = 0;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: LayoutBuilder(builder: (ctx, cons) {
                  top = cons.biggest.height;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: top <= 200 ? 1.0 : 0.0,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                  widget.image,
                                  ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(widget.name
                     )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                    
                    
                      // User Information
                      const _userTileHeightSpace(height: 15),
                      const _userTileText(text: "Developers' Contact Information"),
                      const _userTileHeightSpace(height: 10),
                      _userListTile(
                        lIcon: Icons.person,
                        color: Colors.deepPurple.shade700,
                        title: 'Name',
                        subTitle: widget.name,
                        onTap: () {},
                      ),
                      _userListTile(
                        lIcon: Icons.call,
                        color: Colors.green.shade700,
                        title: 'Phone Number',
                        subTitle: widget.phoneNo,
                        onTap: () {},
                      ),
                      _userListTile(
                        lIcon: Icons.email,
                        color: Colors.yellow.shade700,
                        title: 'Email',
                        subTitle: widget.email,
                        onTap: () {},
                      ),

                      _userListTile(
                        lIcon: Icons.location_on,
                        color: Colors.redAccent.shade100,
                        title: "Address",
                        subTitle: widget.address,
                      ),
                     
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
          // _buildFab(),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _userListTile extends StatelessWidget {
  final IconData lIcon;
  final Color color;
  final String title;
  final String? subTitle;
  final IconData? tIcon;
  final VoidCallback? tIconCallBack;
  final VoidCallback? onTap;
  const _userListTile({
    this.subTitle,
    this.tIcon,
    this.tIconCallBack,
    this.onTap,
    Key? key,
    required this.lIcon,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          lIcon,
          color: color,
        ),
        title: Text(title),
        subtitle: subTitle == null ? null : Text(subTitle!),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(tIcon),
          onPressed: tIconCallBack,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class _userTileHeightSpace extends StatelessWidget {
  final double height;
  const _userTileHeightSpace({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

// ignore: camel_case_types
class _userTileText extends StatelessWidget {
  final String text;
  const _userTileText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      ' $text',
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        // decoration: TextDecoration.underline,
      ),
    );
  }
}