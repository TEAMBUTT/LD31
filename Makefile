.PHONY : run spec coverage clean

LOVE?=love

run:
	${LOVE} ./

pieces.love:
	git archive --format zip --output pieces.love HEAD

spec:
	busted ./spec

.PHONY: pieces.love spec run
