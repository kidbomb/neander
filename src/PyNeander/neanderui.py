import pygtk
pygtk.require('2.0')
import gtk, pango
import time
from neandermodel import *

class NeanderUI:
	DEF_PAD = 10
	def init_window(self):
		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        	self.window.set_title("Neander")
		self.window.set_border_width(5)
		self.window.connect("destroy", lambda x: gtk.main_quit())
		self.window.set_size_request(500, 800)
		self.window.set_resizable(False)
		self.formatter = CommandFormatter()

	def create_menu(self):

		menu_bar = gtk.MenuBar()

		root_menu = gtk.MenuItem("File")
		
		menu = gtk.Menu()

		self.file_open = gtk.MenuItem("Open")
		menu.append(self.file_open)

		file_save = gtk.MenuItem("Save")
		menu.append(file_save)

		root_menu.set_submenu(menu)
		menu_bar.append (root_menu)
		
		root_menu = gtk.MenuItem("Simulator")
		
		menu = gtk.Menu()

		self.sim_run = gtk.MenuItem("Run")
		menu.append(self.sim_run)

		sim_step = gtk.MenuItem("Step")
		menu.append(sim_step)

		root_menu.set_submenu(menu)

		menu_bar.append (root_menu)
		self.vbox.pack_start(menu_bar, False, False, 2)

	def create_memory_view(self):
		
		self.liststore = gtk.ListStore(int, int, str)
		sw = gtk.ScrolledWindow()		
		self.sm = gtk.TreeModelSort(self.liststore)

		tv = gtk.TreeView(self.sm)
		sw.add(tv)
		tv.column = [None]*3
		tv.column[0] = gtk.TreeViewColumn('Addr')
		tv.column[1] = gtk.TreeViewColumn('Value')
		tv.column[2] = gtk.TreeViewColumn('Mneumonic')
		tv.cell = [None]*3
		for i in range(3):
			tv.cell[i] = gtk.CellRendererText()
			tv.cell[i].set_property('editable', True)
			tv.cell[i].connect('edited', self.aa_onclick)
			tv.append_column(tv.column[i])
			tv.column[i].pack_start(tv.cell[i], True)
			tv.column[i].set_attributes(tv.cell[i], text=i)

		self.vbox.pack_start(sw)

	def aa_onclick(self, widget, string):
		print "Test"

	def add_memory_row(self, addr, v):
		self.liststore.append([addr, v, self.formatter.format(0)])

	def set_memory_row(self,addr, v):
		self.liststore.set(self.liststore.get_iter(addr), 1, v)
		self.liststore.set(self.liststore.get_iter(addr), 2, self.formatter.format(v))

	def set_ac(self, ac):
		self.ac_label.set_text(str(ac))

	def set_pc(self, pc):
		self.pc_label.set_text(str(pc))

	def show_file_dialog(self):
		dialog = gtk.FileChooserDialog("Open..",None,gtk.FILE_CHOOSER_ACTION_OPEN,(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,gtk.STOCK_OPEN,  gtk.RESPONSE_OK))
		dialog.set_default_response(gtk.RESPONSE_OK)

		filter = gtk.FileFilter()
		filter.set_name("All files")
		filter.add_pattern("*")
		dialog.add_filter(filter)

		filter = gtk.FileFilter()
		filter.set_name("Images")
		filter.add_mime_type("image/png")

		filter.add_pattern("*.png")

		dialog.add_filter(filter)

		response = dialog.run()
		filename = ""
		if response == gtk.RESPONSE_OK:
			filename = dialog.get_filename()
		elif response == gtk.RESPONSE_CANCEL:
			filename = ""
		dialog.destroy()
		return filename


	def __init__(self):
		self.init_window()


		vboxl = gtk.VBox(False, self.DEF_PAD)
		vboxr = gtk.VBox(False, self.DEF_PAD)


		#top left
		hboxtl = gtk.HBox(False, self.DEF_PAD)

		frame = gtk.Frame()
		frame.set_label("AC")
		self.ac_label = gtk.Label("0")
		frame.add(self.ac_label)
		hboxtl.pack_start(frame, False, False, 0)

		frame = gtk.Frame()
		frame.set_label("PC")
		self.pc_label = gtk.Label("0")
		frame.add(self.pc_label)
		hboxtl.pack_start(frame, False, False, 0)
		
		vboxl.pack_start(hboxtl, False, False, 0)

		#top right
		hboxtr = gtk.HBox(False, self.DEF_PAD)

		frame = gtk.Frame()
		frame.set_label("Executions")
		label = gtk.Label("EXE_VALUE")
		frame.add(label)
		hboxtr.pack_start(frame, False, False, 0)

		vboxr.pack_start(hboxtr, False, False, 0)
				
		
		self.vbox = gtk.VBox()
		self.create_menu()
		self.vbox.pack_start(vboxl, False, False, 0)
		self.vbox.pack_start(vboxr, False, False, 0)
		self.create_memory_view()

		self.window.add(self.vbox)

		self.window.show_all()
		
	def main(self):
		gtk.main()
