function join { local IFS="$1"; shift; echo "$*"; }

VERSION=`mvn help:evaluate -Dexpression=project.version | grep -v '\['`
case "$VERSION" in
	"")
		echo "Could not read project version"
		exit 1
esac

goals=(clean)
profiles=()

if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [[ "$VERSION" == *-SNAPSHOT ]]
then
	goals+=('deploy')
	profiles=('deployment')
else
	goals+=('verify')
fi

if [ ${#profiles[@]} == 0 ]; then
	profiles=""
else
	profiles=`join , ${profiles[@]}`
	profiles="-P$profiles"
fi

command=`echo "mvn $profiles ${goals[@]}" | sed 's/  */ /g'`
echo "$ $command"
eval "$command"
