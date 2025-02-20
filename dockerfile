FROM cirrusci/flutter:stable

# सिस्टम अपडेट + डिपेंडेंसी इंस्टॉल
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    libglu1-mesa \
    python3 \
    python3-pip \
    gcc \
    make

# Firebase CLI इंस्टॉल (अगर चाहिए)
RUN curl -sL https://firebase.tools | bash

# Flutter प्रोजेक्ट सेटअप
WORKDIR /app
COPY . .

# Python dependencies इंस्टॉल
RUN pip3 install -r requirements.txt || echo "No requirements.txt found"

# Flutter dependencies इंस्टॉल
RUN flutter pub get

# C Code (raj.c) को Compile करके Executable (raja) बनाना
RUN gcc raj.c -o raja -pthread

# सभी फाइलों को executable बनाना
RUN chmod +x *

# Raja executable और Python script दोनों को रन करना
CMD ["python3 d.py"]
