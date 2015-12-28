VERSION=`mvn -o help:evaluate -Dexpression=project.version | grep -v '\['`

echo $VERSION
