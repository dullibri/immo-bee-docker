FROM python:3.10
RUN apt-get update                             \
 && apt-get install -y --no-install-recommends \
    ca-certificates curl firefox-esr           \
 && rm -fr /var/lib/apt/lists/*                \
 && curl -L https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz | tar xz -C /usr/local/bin \
 && apt-get purge -y ca-certificates curl


RUN python3.10 -m venv .venv && . .venv/bin/activate && \
    python3.10 -m pip install --upgrade pip && \
    python3.10 -m pip install immo-bee
CMD . .venv/bin/activate && \
   export immo_cmd="python -m immo_bee $locations $house_type -s3 $s3_bucket -df ." && \
   eval ${immo_cmd} 

# set AWS credentials and run:
# docker run -it -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID immo_bee /bin/bash