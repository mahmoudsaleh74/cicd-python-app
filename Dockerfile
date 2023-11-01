FROM python:3.7-alpine
WORKDIR /app
COPY ./app .
ENV FLAS_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
RUN pip install flask
RUN pip install redis
Expose 5000
CMD ["flask","run"]
