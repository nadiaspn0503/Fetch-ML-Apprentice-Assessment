# Use an official Python image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy all files into the container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run your script (change to your script name)
CMD ["python", "main.py"]
