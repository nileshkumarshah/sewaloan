FROM python:3.8

# Set non-interactive frontend to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="Asia/Kolkata"

RUN python3 -m venv /opt/venv

# This is wrong!
RUN . /opt/venv/bin/activate

# Update, upgrade, and install necessary packages
# RUN apt-get update && apt-get upgrade -y && apt-get install -y \
#     build-essential \
#     libopencv-dev \
#     poppler-utils \
#     ffmpeg \
#     software-properties-common \
#     python3-opencv \
#     nginx \
#     supervisor \
#     --no-install-recommends

RUN apt-get update 
# Clean up APT cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup python environment
RUN mkdir /code
WORKDIR /code
COPY new_requirements.txt . 
RUN pip install -r new_requirements.txt

# Copy project files
COPY . .

# Make the script executable
RUN chmod a+x run.sh

# Default command to run the script
CMD ["./run.sh"]