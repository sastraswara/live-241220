~tambaTextures.at(\rebabWalk).play;
~tambaTextures.at(\rebabWalk).pause;

~tambaTextures.at(\rebabPartials).play;
~tambaTextures.at(\rebabPartials).pause;

~tambaTextures.at(\rebabCluster).play;
~tambaTextures.at(\rebabCluster).pause;

~tambaTextures.at(\rebabSenggrengan).play;
~tambaTextures.at(\rebabSenggrengan).pause;

~tambaTextures.at(\rebabDrone).play;
~tambaTextures.at(\rebabDrone).pause;

(
[\rebabWalk, \rebabPartials, \rebabCluster, \rebabSenggrengan, \rebabDrone].do { |k|
	~tambaTextures.at(k).pause;
};
)


///////////
~tambaTextures.at(\stochasticRun).reset.play;
~tambaTextures.at(\stochasticRun).stop;

~tambaTextures.at(\stochasticBounce).reset.play;
~tambaTextures.at(\stochasticBounce).stop;

~tambaTextures.at(\layers).value;
~tambaTextureLayers.do { |r| r.reset.play };
~tambaTextureLayers.do { |r| r.stop };


