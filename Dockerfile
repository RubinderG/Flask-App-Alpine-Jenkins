# Use Python 3.6 or later as a base image
FROM python:3.6

# Copy contents into image
WORKDIR /app
COPY . /app

# Install pip dependencies from requirements
RUN pip install -r "requirements.txt"

# Set YOUR_NAME environment variable
ENV YOUR_NAME="Trainee"

# Expose the correct port
EXPOSE 5500

# Create an entrypoint
ENTRYPOINT [ "python3", "app.py" ]
