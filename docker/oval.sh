#!/bin/bash

if [ $# -eq 0 ]; then
	echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
	exit 1
fi

target=$1
shift

if [[ -z "${DOCKER_NETWORK}" ]]; then
	DOCKER_NETWORK_OPT=""
else
	DOCKER_NETWORK_OPT="--network ${DOCKER_NETWORK}"
fi


docker pull vuls/goval-dictionary
docker run --rm -it vuls/goval-dictionary version

# NOTE: fetches oval of the OS with security support enabled.
case "$target" in
	--redhat) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch redhat ${@} 6 7 8
		;;
	--amazon) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch amazon ${@}
		;;
	--debian) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch debian ${@} 9 10 11
		;;
	--ubuntu) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch ubuntu ${@} 14 16 18 20
		;;
	--alpine) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch alpine ${@} 3.12 3.13 3.14 3.15
		;;
	--oracle) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch oracle ${@}
		;;
	--fedora) docker run --rm -it \
		${DOCKER_NETWORK_OPT} \
		-v $PWD:/goval-dictionary \
		vuls/goval-dictionary fetch fedora ${@} 34 35
		;;
	--*)  echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
		exit 1
		;;
	*) echo "specify [--redhat --amazon --debian --ubuntu --alpine --oracle --fedora]"
		exit 1
		;;
esac

exit 0

