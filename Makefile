.PHONY : run spec coverage clean

LOVE?=love

run:
	${LOVE} ./

spec:
	busted ./spec

