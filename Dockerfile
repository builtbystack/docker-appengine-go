FROM ghcr.io/gcpug/appengine-go:slim

ARG GOLANGCI_LINT_VERSION=v1.43.0

# gofumportsがなくなったのでバージョン固定
RUN cd $(mktemp -d); go mod init tmp; go get github.com/99designs/gqlgen@v0.16.0; cd - && \
    cd $(mktemp -d); go mod init tmp; go get golang.org/x/tools/cmd/goimports; cd - && \
    cd $(mktemp -d); go mod init tmp; go get mvdan.cc/gofumpt/gofumports@v0.1.1; cd - && \
    cd $(mktemp -d); go mod init tmp; go get mvdan.cc/sh/v3/cmd/shfmt; cd - && \
    go get -u github.com/sachaos/xerrchk/cmd/xerrchk && \
    go install github.com/google/ko@latest && \
    go install github.com/sonatard/runenv@latest && \
    go install github.com/gqlgo/nodecheck/cmd/nodecheck@latest && \
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $GOLANGCI_LINT_VERSION && \
    \
    # Artifact RegistryにPushするための認証設定
    gcloud auth configure-docker asia-northeast1-docker.pkg.dev && \
    \
    apt-get update && \
	apt-get install -yqq --no-install-suggests --no-install-recommends \
		npm \
		dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf ${GOPATH}/src ${GOPATH}/pkg \
    # ここで入れるのは、modulesのcacheを消してしまうと、参照したいテンプレートファイルがなくなってしまって正しく動作しないため、cache消去後に入れている
    cd $(mktemp -d); go mod init tmp; go get -u github.com/Yamashou/gqlgenc@v0.0.2-gql; cd -
