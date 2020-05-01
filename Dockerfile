FROM thomasweise/texlive AS tex

ARG GIT_SHA
ENV GIT_SHA=$GIT_SHA
ARG GIT_TAG
ENV GIT_TAG=$GIT_TAG

COPY . /app

WORKDIR /app

RUN make tex/cv.pdf

ARG GIT_SHA
ENV GIT_SHA=$GIT_SHA
ARG GIT_TAG
ENV GIT_TAG=$GIT_TAG

FROM python:3.8.2-buster AS py

COPY --from=tex /app /app

WORKDIR /app

RUN pip install pipenv

RUN pipenv install --deploy

RUN make html

FROM nginx:1.17.0

COPY --from=py /app/output /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf
