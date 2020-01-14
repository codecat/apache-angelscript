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

I do not recommend building or testing this on a production server as it's definitely not production ready yet.

# Building
This currently only builds on Linux. To build this, you need to install `apache2-dev` in Debian (and probably other distros as well), have a copy of [`premake5`](https://premake.github.io/) in your path, fetch the git submodules, and then simply run `make`. This will do a number of things:

1. Generate the makefiles necessary for building the module, using premake.
2. Compile Angelscript and `mod_angelscript` and place them in the `bin` folder.
3. Installs the module using [`apxs`](https://httpd.apache.org/docs/2.4/programs/apxs.html). This will run with sudo!
4. Restarts apache using `service apache2 restart`. This will of course also run with sudo!

# Configuring
To configure Apache to accept `.as` files, you have to add this somewhere to your Apache config:

```xml
<FilesMatch ".+\.as$">
	SetHandler application/x-httpd-angelscript
</FilesMatch>
```

