# docker-appengine-go

[![Docker](https://github.com/appify-technologies/docker-appengine-go/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/appify-technologies/docker-appengine-go/actions/workflows/docker-publish.yml)

- GitHub Reposiitory
[appify-technologies/docker-appengine-go](https://github.com/appify-technologies/docker-appengine-go/)
- GitHub Container Registiry
[appify-technologies/appengine-go](https://github.com/orgs/appify-technologies/packages/container/package/appengine-go)
- Base image
[gcpug/docker-appengine-go](https://github.com/gcpug/docker-appengine-go)

## Github Container Registry構築手順
1. [Docikerfile](Dockerfile)を用意する
2. [docker-publish.yml](.github/workflows/docker-publish.yml)を用意する
3. Private Access Tokenを取得してCR_PATをこのリポジトリのSecretsに設定(CR_PAT作成者はadminである必要がある、GITHUB_TOKENは現在未対応)
4. [organization -> Settings -> Packages](https://github.com/organizations/appify-technologies/settings/packages) からPackages improved container supportのEnable improved container supportとContainer CreationのPublicにチェック
5. PushするとGithub ActionsからDocker imageのビルドとPushが実行される
6. CIを実行
7. [公開されたpackage](https://github.com/orgs/appify-technologies/packages/container/package/appengine-go)のPackage SettingsからChange package visibilityをPublicにする

- 参考: https://docs.github.com/ja/packages/guides/migrating-to-github-container-registry-for-docker-images

## コンテナリビルド方法
- https://github.com/appify-technologies/docker-appengine-go/actions から過去に成功したCIを選び再実行する
