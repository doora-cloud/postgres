FROM postgres:14-alpine

ENV DB_MAX_CONNECTION=200
ENV VAULT_URL=https://vault.doora.cloud/api
ENV VAULT_ENV=prod

RUN apk add --no-cache bash curl && curl -1sLf \
  'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.alpine.sh' | bash

RUN apk --no-cache add infisical

CMD ["infisical", "run", \
    "--domain ${VAULT_URL}", \
    "--projectId ${VAULT_PROJECT_ID}", \
    "--env ${VAULT_ENV}", \
    "-- postgres -c log_statement=all -c max_connections=${DB_MAX_CONNECTION}"]