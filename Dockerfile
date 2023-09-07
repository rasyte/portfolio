# Use a suitable base image
FROM python:3.8-slim-buster

# Set working directory
WORKDIR /app

# Copy the requirements.txt file and install the required packages
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application's code into the container
COPY . /app

# Expose the port the app runs on
EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "app:app"]

