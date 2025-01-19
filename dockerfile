## Base image
FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python libraries
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Copy the application code
WORKDIR /app
COPY . .

# Expose webhook port
EXPOSE 8443

# Command to run the bot
CMD ["python", "cca.py"]
