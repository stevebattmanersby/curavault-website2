#!/usr/bin/env bash
set -euo pipefail

readonly FLUTTER_VERSION="3.44.2"
readonly FLUTTER_COMMIT="c9a6c484230f8b5e408ec57be1ef71dee1e77020"
readonly CACHE_ROOT="${NETLIFY_CACHE_DIR:-${HOME:?HOME must be set}/.cache}/curavault"
readonly FLUTTER_ROOT="${CACHE_ROOT}/flutter/${FLUTTER_VERSION}"

mkdir -p "$(dirname "${FLUTTER_ROOT}")"

if [[ -d "${FLUTTER_ROOT}/.git" && -x "${FLUTTER_ROOT}/bin/flutter" ]]; then
  git -C "${FLUTTER_ROOT}" fetch --depth 1 origin "refs/tags/${FLUTTER_VERSION}"
  git -C "${FLUTTER_ROOT}" checkout --detach --force "${FLUTTER_COMMIT}"
elif [[ -e "${FLUTTER_ROOT}" ]]; then
  case "${FLUTTER_ROOT}" in
    "${CACHE_ROOT}"/flutter/*) rm -rf -- "${FLUTTER_ROOT}" ;;
    *) echo "Refusing to replace an unexpected Flutter path." >&2; exit 1 ;;
  esac
  git clone --branch "${FLUTTER_VERSION}" --depth 1 \
    https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
else
  git clone --branch "${FLUTTER_VERSION}" --depth 1 \
    https://github.com/flutter/flutter.git "${FLUTTER_ROOT}"
fi

if [[ "$(git -C "${FLUTTER_ROOT}" rev-parse HEAD)" != "${FLUTTER_COMMIT}" ]]; then
  echo "Flutter checkout does not match the pinned release." >&2
  exit 1
fi

export PATH="${FLUTTER_ROOT}/bin:${PATH}"
export CI=true
export FLUTTER_SUPPRESS_ANALYTICS=true

flutter config --enable-web
flutter pub get
flutter build web --release
