# Dockerfile for Railway Deployment

# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./

# Instala las dependencias del sistema, incluido Tesseract OCR
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    && apt-get clean

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port that the app runs on
EXPOSE 8000

# Define environment variables for Railway
ENV PYTHONUNBUFFERED=1
ENV PORT=8000

# Run the application
CMD ["python", "your_script_name.py"]
