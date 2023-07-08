FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    software-properties-common \
    pandoc \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt install -y gcc g++ python3.10 python3-venv python3-dev python3.10-dev
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN python3 -m pip install --upgrade pip
RUN pip3 install --upgrade pip setuptools wheel
RUN python3 -m pip install virtualenv
RUN pip3 install -U langchain
RUN CMAKE_ARGS="-DLLAMA_OPENBLAS=on" FORCE_CMAKE=1 pip install llama-cpp-python
RUN pip install psutil==5.7.1
WORKDIR /workspace

COPY requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt
COPY . .
ENTRYPOINT [ "python3"]
