FROM alpine:3.10

LABEL "com.github.actions.name"="WIP blocker with labels in PR"
LABEL "com.github.actions.description"="Github action WIP blocker with labels in Pull requests"
LABEL "com.github.actions.icon"="tag"
LABEL "com.github.actions.color"="gray-dark"

LABEL repository="https://github.com/Felipebros/github-action-WIP-blocker-with-labels-in-PR"
LABEL homepage="https://github.com/Felipebros/github-action-WIP-blocker-with-labels-in-PR"

RUN apk add --no-cache bash curl jq git

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]