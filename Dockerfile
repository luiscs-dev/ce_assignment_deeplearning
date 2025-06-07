FROM python:3.11-slim

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install -U setuptools && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /workspace /workspace/data

# Expose Jupyter Lab port
EXPOSE 8888

ENV PYTHONPATH=/workspace
ENV JUPYTER_ENABLE_LAB=yes

RUN useradd -m -s /bin/bash jupyter && \
    chown -R jupyter:jupyter /workspace

USER jupyter

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''", "--ServerApp.allow_origin='*'"]