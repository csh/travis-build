if [ "$TRAVIS_SECURE_ENV_VARS" != "true" ]; then
	echo "Could not find repository credentials"
	exit 1
fi

TARGET_DIR="$HOME/.m2"
TARGET_FILE="$TARGET_DIR/settings.xml"

mkdir -p "$TARGET_DIR"

read -r -d '' settings << EOF
<?xml version="1.0" encoding="UTF-8"?>
<settings>
  <servers>
    <id>$REPOSITORY_ID</id>
    <username>$REPOSITORY_USERNAME</username>
    <password>$REPOSITORY_PASSWORD</password>
  </servers>
</settings>
EOF

echo "$settings" >> "$TARGET_FILE"
