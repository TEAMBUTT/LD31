.PHONY : run spec coverage clean

run:
	${LOVEPATH} ./

spec:
	busted ./spec

