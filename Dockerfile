FROM python:3.9-slim

WORKDIR /app

# Install system dependencies that might be required
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libffi-dev

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
