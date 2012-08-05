import pygtk
pygtk.require('2.0')
import gtk, pango
import time
from neanderui import *
from neandermodel import *

class NeanderController:
	
	def main(self):
		self.neander = Neander()
		self.neander.set_stepped_function(self.neander_stepped)
		self.view = NeanderUI()
		self.view.file_open.connect("activate", self.file_open_onclick, "")
		self.view.sim_run.connect("activate", self.sim_run_onclick, "")

		for i in range(256):
			self.view.add_memory_row(i, 0)

		self.view.main()
	
	def file_open_onclick(self, widget, string):
		filename = self.view.show_file_dialog()
		if len(filename) != 0:
			self.neander.from_file(filename)
			for i in range(256):
				self.view.set_memory_row(i, self.neander.memory[i])
			print "File Loaded"

	def sim_run_onclick(self, widget, string):
		print "Running..."		
		self.neander.run()
		print "Done!"
		for i in range(256):
			print  "Memory[", i, "] = ",self.neander.memory[i]

	def neander_stepped(self):
		self.view.set_ac(self.neander.ac)
		self.view.set_pc(self.neander.pc)
		for i in range(256):
			self.view.set_memory_row(i, self.neander.memory[i])
		

if __name__ == "__main__":
	c = NeanderController()
	c.main()
