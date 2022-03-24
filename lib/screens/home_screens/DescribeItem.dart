import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:bkdms/components/AppBarGrey.dart';
import 'package:bkdms/screens/home_screens/DetailItem.dart';


class DescribeItem extends StatelessWidget {
  
  String htmlData = """<!DOCTYPE html>
<html lang="en">
<head>
<title>Page Title</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}

/* Style the body */
body {
  font-family: Arial, Helvetica, sans-serif;
  margin: 0;
}

/* Header/logo Title */
.header {
  padding: 80px;
  text-align: center;
  background: #1abc9c;
  color: white;
}

/* Increase the font size of the heading */
.header h1 {
  font-size: 40px;
}

/* Sticky navbar - toggles between relative and fixed, depending on the scroll position. It is positioned relative until a given offset position is met in the viewport - then it "sticks" in place (like position:fixed). The sticky value is not supported in IE or Edge 15 and earlier versions. However, for these versions the navbar will inherit default position */
.navbar {
  overflow: hidden;
  background-color: #333;
  position: sticky;
  position: -webkit-sticky;
  top: 0;
}

/* Style the navigation bar links */
.navbar a {
  float: left;
  display: block;
  color: white;
  text-align: center;
  padding: 14px 20px;
  text-decoration: none;
}


/* Right-aligned link */
.navbar a.right {
  float: right;
}

/* Change color on hover */
.navbar a:hover {
  background-color: #ddd;
  color: black;
}

/* Active/current link */
.navbar a.active {
  background-color: #666;
  color: white;
}

/* Column container */
.row {  
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
}

/* Create two unequal columns that sits next to each other */
/* Sidebar/left column */
.side {
  -ms-flex: 30%; /* IE10 */
  flex: 30%;
  background-color: #f1f1f1;
  padding: 20px;
}

/* Main column */
.main {   
  -ms-flex: 70%; /* IE10 */
  flex: 70%;
  background-color: white;
  padding: 20px;
}

/* Fake image, just for this example */
.fakeimg {
  background-color: #aaa;
  width: 100%;
  padding: 20px;
}

/* Footer */
.footer {
  padding: 20px;
  text-align: center;
  background: #ddd;
}

/* Responsive layout - when the screen is less than 700px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 700px) {
  .row {   
    flex-direction: column;
  }
}

/* Responsive layout - when the screen is less than 400px wide, make the navigation links stack on top of each other instead of next to each other */
@media screen and (max-width: 400px) {
  .navbar a {
    float: none;
    width: 100%;
  }
}
</style>
</head>
<body>

<div class="header">
  <h1>My Website</h1>
  <p>A <b>responsive</b> website created by me.</p>
</div>

<div class="navbar">
  <a href="#" class="active">Home</a>
  <a href="#">Link</a>
  <a href="#">Link</a>
  <a href="#" class="right">Link</a>
</div>

<div class="row">
  <div class="side">
    <h2>About Me</h2>
    <h5>Photo of me:</h5>
    <div class="fakeimg" style="height:200px;">Image</div>
    <p>Some text about me in culpa qui officia deserunt mollit anim..</p>
    <h3>More Text</h3>
    <p>Lorem ipsum dolor sit ame.</p>
    <div class="fakeimg" style="height:60px;">Image</div><br>
    <div class="fakeimg" style="height:60px;">Image</div><br>
    <div class="fakeimg" style="height:60px;">Image</div>
  </div>
  <div class="main">
    <h2>TITLE HEADING</h2>
    <h5>Title description, Dec 7, 2017</h5>
    <div class="fakeimg" style="height:200px;">Image</div>
    <p>Some text..</p>
    <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
    <br>
    <h2>TITLE HEADING</h2>
    <h5>Title description, Sep 2, 2017</h5>
    <div class="fakeimg" style="height:200px;">Image</div>
    <p>Some text..</p>
    <p>Sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco.</p>
  </div>
</div>

<div class="footer">
  <h2>Footer</h2>
</div>

</body>
</html>
""";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGrey("Mô tả sản phẩm"),
      body: SingleChildScrollView(
            child: Html(
                    data: htmlData,                  
                    style: {
                        "table": Style(
                            backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "tr": Style(
                            border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        "th": Style(
                            padding: EdgeInsets.all(6),
                            backgroundColor: Colors.grey,
                        ),
                        "td": Style(
                            padding: EdgeInsets.all(6),
                            alignment: Alignment.topLeft,
                        ),
                        'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                    },
                    customRender: {
                        "table": (context, child) {
                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:
                                (context.tree as TableLayoutElement).toWidget(context),
                            );
                        },
                        "bird": (RenderContext context, Widget child) {
                            return TextSpan(text: "🐦");
                        },
                        "flutter": (RenderContext context, Widget child) {
                            return FlutterLogo(
                                style: (context.tree.element!.attributes['horizontal'] != null) ?
                                FlutterLogoStyle.horizontal :
                                FlutterLogoStyle.markOnly,
                                textColor: context.style.color!,
                                size: context.style.fontSize!.size! * 5,
                            );
                        },
                    },
                    customImageRenders: {
                        networkSourceMatcher(domains: ["flutter.dev"]):
                            (context, attributes, element) {
                                return FlutterLogo(size: 36);
                            },
                        networkSourceMatcher(domains: ["mydomain.com"]): networkImageRender(
                            headers: {
                                "Custom-Header": "some-value"
                            },
                            altWidget: (alt) => Text(alt ?? ""),
                            loadingWidget: () => Text("Loading..."),
                        ),
                        // On relative paths starting with /wiki, prefix with a base url
                        (attr, _) =>
                        attr["src"] != null && attr["src"] !.startsWith("/wiki"): networkImageRender(
                            mapUrl: (url) => "https://upload.wikimedia.org" + url!),
                        // Custom placeholder image for broken links
                        networkSourceMatcher(): networkImageRender(altWidget: (_) => FlutterLogo()),
                    },
                    onLinkTap: (url, _, __, ___) {
                        print("Opening $url...");
                    },
                    onImageTap: (src, _, __, ___) {
                        print(src);
                    },
                    onImageError: (exception, stackTrace) {
                        print(exception);
                    },
            ),
      )
    );
  }
}