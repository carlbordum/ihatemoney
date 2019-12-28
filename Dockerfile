FROM python:3.7-alpine

# Force the stdout and stderr streams from python to be unbuffered. See
# https://docs.python.org/3/using/cmdline.html#cmdoption-u
ENV PYTHONUNBUFFERED 1

ENV IHATEMONEY_SETTINGS_FILE_PATH=/ihatemoney.cfg

WORKDIR /code/
VOLUME /database
EXPOSE 8000

# Install wsgi server
RUN pip install --no-cache-dir gunicorn==20.0.4

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install application
COPY CONTRIBUTORS LICENSE README.rst ./
COPY ihatemoney ./ihatemoney

CMD ["gunicorn", "-b", "0.0.0.0:8000", "ihatemoney.wsgi:application"]
