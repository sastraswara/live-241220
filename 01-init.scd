~cleanup = {
	s.freeAll;
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
};

~cleanup.();
ServerQuit.add(~cleanup);