# Dockerfile for Railway Deployment

# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./

# Install system dependencies, including Tesseract OCR and the Spanish language package
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    tesseract-ocr-spa \
    libtesseract-dev \
    libjpeg-dev \
    zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Verify Tesseract installation (for debugging)
RUN tesseract --version

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port that the app runs on
EXPOSE 8000

# Define environment variables for Railway
ENV PYTHONUNBUFFERED=1
ENV PORT=8000

# Run the application
CMD ["python", "cca"]
