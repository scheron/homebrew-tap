# Homebrew Tap for Daily

Homebrew tap for installing the Daily macOS app via cask.

## Add tap

```bash
brew tap scheron/tap
```

## Install

```bash
brew install --cask scheron/tap/daily
```

or after tap is added:

```bash
brew install --cask daily
```

## Upgrade

```bash
brew upgrade --cask scheron/tap/daily
```

## Notes

The cask includes a `postflight` step that removes the quarantine attribute from `Daily.app` as a temporary workaround until full notarization is in place.

## Maintenance

- Manual update (specific version):

  ```bash
  ./scripts/update-cask.sh 0.12.2
  ```

- Manual update (latest GitHub release):

  ```bash
  ./scripts/update-cask.sh
  ```

- Local validation:

  ```bash
  ./run-tests.sh
  ```

- Automated updates run via `.github/workflows/update-cask.yml`.
- CI checks run via `.github/workflows/build.yml`.
