import pygtk
pygtk.require('2.0')
import gtk, pango
import time
from neanderui import *
from neandermodel import *

class NeanderController:
	
	def main(self):
		self.neander = Neander()

		self.view = NeanderUI()
		self.view.file_open.connect("activate", self.file_open_onclick, "")
		self.view.sim_run.connect("activate", self.sim_run_onclick, "")

		for i in range(256):
			self.view.add_memory_row(i, 6)

		self.view.main()
	
	def file_open_onclick(self, widget, string):
		filename = self.view.show_file_dialog()
		if len(filename) != 0:
			self.neander.from_file(filename)
			print "File Loaded"

	def sim_run_onclick(self, widget, string):
		print "Running..."		
		self.neander.run()
		print "Done!"
		for i in range(256):
			print  "Memory[", i, "] = ",self.neander.memory[i]

if __name__ == "__main__":
	c = NeanderController()
	c.main()
