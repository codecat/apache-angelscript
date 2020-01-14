# mod\_angelscript
This is an Angelscript module for Apache2. It adds a handler for `application/x-httpd-angelscript` that you can bind to `.as` files that are then compiled and executed on the fly to get the same convenience as with PHP, but with Angelscript as a language!

Here's a quick example:

```angelscript
void main()
{
	set_content_type("text/html");
	print("<h1>Hello, world!</h1>");
	print("<p>Angelscript says <b>hello</b>!</p>");
}
```

# Development
This project is a very early proof of concept right now. I don't know if I'm going to continue working on this, but I think it's a cool concept to explore more.

A lot of things are still in the design stages as well, so you'll notice that the code is pretty ugly right now, considering it's a quick concept that I hacked up in a few hours.

