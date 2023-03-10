project.analyze:
	./.handler.sh analyze
	echo "- Done analyzing"
project.integrate:
	./.handler.sh integrate
	echo "- Consolidated top entity"
project.clean:
	ghdl --clean
	echo "- Cleaned stack"
wave.gen:
	echo "- Dumping signals"
	./.handler.sh run
wave.show:
	echo "- Opening wave"
	./.handler.sh open
project.all: project.clean project.analyze project.integrate wave.gen wave.show
project.run: project.clean project.analyze project.integrate wave.gen
