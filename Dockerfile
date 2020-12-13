FROM python:3.7

RUN mkdir usr/app
WORKDIR usr/app

COPY . .

RUN pip install --upgrade pip setuptools==45.2.0

RUN pip install -r requirements.txt

CMD python app.py