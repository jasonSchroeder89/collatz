import gtk.Builder;
import gtk.Button;
import gtk.Entry;
import gtk.Main;
import gtk.TextView;
import gtk.Window;

struct Widgets
{
	Entry textEntry;
	TextView textView;
}

void main(string[] args)
{
	// Initializes gtk runtime
	Main.init(args);
	
	Builder builder = new Builder();

	builder.addFromFile("source/glade/mainWindow.glade");

	Window mainWindow = cast(Window)builder.getObject("mainWindow");
	Entry entry = cast(Entry)builder.getObject("inputEntry");
	TextView textView = cast(TextView)builder.getObject("collatzTextView");
	
	Widgets* tw = new Widgets(entry, textView);
	
	mainWindow.showAll();

	builder.connectSignals(tw);

	// Starts message loop and displays MainWindow
	Main.run();
}

extern(C) void on_mainWindow_destroy()
{
	Main.quit();
}

extern(C) void on_calculateButton_clicked(GtkButton* button,
	Widgets* widgets)
{
	import libcollatz.functions : printCollatzSequence;
	import std.conv : to;
	
	TextView tv = cast(TextView)widgets.textView;
	Entry entry = cast(Entry)widgets.textEntry;
	
	const ulong target = to!ulong(entry.getText());
	
	string result = printCollatzSequence(target, true, 5);
	
	tv.appendText(result ~ "\n\n");
}