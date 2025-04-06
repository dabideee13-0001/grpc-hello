FROM python:3.13.2-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app ./app
COPY ../protos ./protos

RUN python -m grpc_tools.protoc -I./protos \
    --python_out=./app \
    --grpc_python_out=./app \
    ./protos/helloworld.proto || true

WORKDIR /app/app
CMD ["python", "server.py"]
