FROM cirrusci/flutter:stable

# सिस्टम अपडेट + डिपेंडेंसी इंस्टॉल
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    libglu1-mesa \
    python3 \
    python3-pip

# Flutter का PATH सेट करना (जरूरी!)
ENV PATH="$PATH:/usr/local/flutter/bin"

# Firebase CLI इंस्टॉल (अगर चाहिए)
RUN curl -sL https://firebase.tools | bash

# Flutter प्रोजेक्ट सही डायरेक्टरी में कॉपी करना
WORKDIR /app
COPY . /app  # ✅ अब pubspec.yaml सही जगह कॉपी होगा

# Flutter Cache क्लियर और `pub get`
RUN ls -la /app  # ✅ Debugging के लिए देख, pubspec.yaml सही जगह है कि नहीं!
RUN flutter clean
RUN flutter pub get

# Python dependencies इंस्टॉल
RUN pip3 install -r requirements.txt || echo "No requirements.txt found"

# सभी फाइलों को executable बनाना
RUN chmod +x *

# Raja.py रन करना
CMD ["python3", "raja.py"]
