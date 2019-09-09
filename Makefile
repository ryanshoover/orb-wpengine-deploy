test :
	circleci config pack src | circleci orb validate -

pack :
	circleci config pack src > orb.yml

clean :
	rm orb.yml

setup :
	hash circleci || brew install circleci
